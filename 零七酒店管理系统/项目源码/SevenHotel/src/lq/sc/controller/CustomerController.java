package lq.sc.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lq.sc.pojo.CheckIn;
import lq.sc.pojo.Comment;
import lq.sc.pojo.Customer;
import lq.sc.pojo.Order;
import lq.sc.service.checkIn.CheckInService;
import lq.sc.service.comment.CommentService;
import lq.sc.service.customer.CustomerService;
import lq.sc.service.member.MemberService;
import lq.sc.service.order.OrderService;
import lq.sc.tools.Constants;
import lq.sc.tools.PageSupport;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 项目名称：SevenHotel   类名称：UserController  类描述：客户的控制层   客户控制层 创建人：lhh
 * 创建时间：2018-10-16 上午8:52:12
 * 
 * @version       
 */
@Controller
@RequestMapping("/user")
public class CustomerController {
	@Resource
	private CustomerService customerService;
	@Resource
	private MemberService memberService;
	@Resource
	private OrderService orderService;
	@Resource
	private CheckInService checkInService;
	@Resource
	private CommentService commentService;
	/*
	 * 404页面
	 */
	@RequestMapping("*")
	public String fourZeroFour(){
		return "customer_404";
	}
	/*
	 * 跳转酒店主页
	 */
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "redirect:../room/main";
	}
	/*
	 * 跳转酒店博客页面
	 */
	@RequestMapping(value = "/blog", method = RequestMethod.GET)
	public String customer_blog() {
		return "redirect:../room/blog";
	}
	/*
	 * 跳转酒店服务页面
	 */
	@RequestMapping(value = "/services", method = RequestMethod.GET)
	public String customer_services() {
		return "redirect:../room/services";
	}
	/*
	 * 跳转登陆页面
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "customer_login";
	}

	/*
	 * 跳转注册页面
	 */
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() {
		return "customer_register";
	}

	/*
	 * 进行登陆
	 */
	@RequestMapping(value = "/doLogin", method = RequestMethod.GET)
	public String doLogin(
			@RequestParam(value = "userCode", required = false) String userCode,
			@RequestParam(value = "userPassword", required = false) String userPassword,
			HttpSession session, HttpServletRequest req) {
		if (userCode == null || userCode == "" || userPassword == null
				|| userPassword == "") {
			req.setAttribute("error", "用户名密码不能为空！！！");
			return "customer_login";
		}
		Customer customer = customerService.login(userCode, userPassword);
		if (customer != null) {
			session.setAttribute(Constants.USER_SESSION, customer);
			return "redirect:../user/main";
		} else {
			req.setAttribute("error", "密码不正确！！！");
			req.setAttribute("userCode", userCode);
			return "customer_login";
		}
	}

	/*
	 * 退出
	 */
	@RequestMapping(value = "/signOut")
	public String outframe(HttpSession session) {
		if (session != null) {
			session.removeAttribute(Constants.USER_SESSION);
		}
		return "redirect:../user/main";
	}

	/*
	 * ajax验证用户名
	 */
	@RequestMapping(value = "/userCodeExist", method = RequestMethod.GET)
	@ResponseBody
	public Object userCodeExist(@RequestParam String userCode) {
		Map<String, String> result = new HashMap<String, String>();
		if (customerService.userCodeAjax(userCode)) {
			result.put("userCode", "true");
		} else {
			result.put("userCode", "false");
		}
		return result;
	}

	/*
	 * 进行注册
	 */
	@RequestMapping(value = "/doRegister", method = RequestMethod.POST)
	public String doRegister(Customer customer) {
		if (customerService.register(customer)) {
			return "customer_login";
		} else {
			return "customer_register";
		}
	}

	/*
	 * ajax查询用户
	 */
	@RequestMapping(value = "/selMyInformation", method = RequestMethod.GET)
	@ResponseBody
	public Object selMyInformation(HttpSession session) {
		if (session.getAttribute(Constants.USER_SESSION) != null) {
			// 刷新用户信息
						Customer refreshCustomer = customerService.login(((Customer) session.getAttribute(Constants.USER_SESSION))
								.getUserCode(),
								((Customer) session.getAttribute(Constants.USER_SESSION))
										.getUserPassword());
						session.setAttribute(Constants.USER_SESSION, refreshCustomer);
			return (Customer) session.getAttribute(Constants.USER_SESSION);
		} else {
			return "null";
		}
	}

	/*
	 * 修改用户
	 */
	@RequestMapping(value = "/modifyInformation", method = RequestMethod.POST)
	@ResponseBody
	public Object modifyInformation(@RequestParam("userCode") String userCode,
			@RequestParam("userPhone") String userPhone, HttpSession session) {
		HashMap<String, String> result = new HashMap<String, String>();
		Customer customer = new Customer();
		customer.setUserCode(userCode);
		customer.setUserPhone(userPhone);
		customer.setId(((Customer) session.getAttribute(Constants.USER_SESSION))
				.getId());
		if (customerService.modifyPersonalMessage(customer)) {
			// 刷新用户信息
			Customer refreshCustomer = customerService.login(userCode,
					((Customer) session.getAttribute(Constants.USER_SESSION))
							.getUserPassword());
			session.setAttribute(Constants.USER_SESSION, refreshCustomer);
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}

	/*
	 * ajax校验原密码
	 */
	@RequestMapping(value = "/oldPasswordAjax", method = RequestMethod.GET)
	@ResponseBody
	public Object oldPasswordAjax(
			@RequestParam(value = "oldUserPassword") String oldUserPassword,
			HttpSession session) {
		HashMap<String, String> result = new HashMap<String, String>();
		if (oldUserPassword.equals(((Customer) session
				.getAttribute(Constants.USER_SESSION)).getUserPassword())) {
			result.put("oldUserPassword", "true");
		} else {
			result.put("oldUserPassword", "false");
		}
		return result;
	}

	/*
	 * 修改密码
	 */
	@RequestMapping(value = "/modifyPassword", method = RequestMethod.POST)
	@ResponseBody
	public Object modifyPassword(
			@RequestParam(value = "userPassword") String userPassword,
			HttpSession session) {
		HashMap<String, String> result = new HashMap<String, String>();
		Customer customer = new Customer();
		customer.setUserPassword(userPassword);
		customer.setId(((Customer) session.getAttribute(Constants.USER_SESSION))
				.getId());
		if (customerService.modifyPassword(customer)) {
			// 重新登陆
			if (session != null) {
				session.removeAttribute(Constants.USER_SESSION);
			}
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}

	/*
	 * 积分操作
	 */
	@RequestMapping(value = "/modifyIntegralAjax", method = RequestMethod.GET)
	@ResponseBody
	public Object modifyIntegralAjax(
			@RequestParam("integral") String integral,
			@RequestParam(value = "customerId", required = false) String customerId,
			HttpSession session) {
		HashMap<String, String> result = new HashMap<String, String>();
		Customer customer = new Customer();
		customer.setIntegral(Integer.parseInt(integral));
		if (customerId != null) {
			customer.setId(Integer.parseInt(customerId));
		} else {
			customer.setId(((Customer) session
					.getAttribute(Constants.USER_SESSION)).getId());
		}
		if (customerService.modifyIntegral(customer)) {
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}

	/*
	 * 跳转我的订单集合
	 */
	@RequestMapping(value = "/toMyOrder")
	public String toMyOrder(
			@RequestParam(value = "userName", required = false) String userName,
			@RequestParam(value = "orderState", required = false) String orderState,
			String pageIndex, Model model, HttpSession session)
			throws Exception {
		int _orderState = 0;
		List<Order> orderList = null;
		// 设置页面容量
		int pageSize = Constants.pageSize;
		// 当前页码
		int currentPageNo = 1;
		if (userName == null) {
			userName = "";
		} else {
			// 转换页面乱码值
			userName = java.net.URLDecoder.decode(userName, "utf8");
		}
		if (orderState != null && !orderState.equals("")) {
			_orderState = Integer.parseInt(orderState);
		}

		if (pageIndex != null) {
			try {
				currentPageNo = Integer.valueOf(pageIndex);
			} catch (NumberFormatException e) {
				return "error";
			}
		}
		// 总数量（表）
		int totalCount = orderService.getAllOrderCount(userName, _orderState);
		// 总页数
		PageSupport pages = new PageSupport();
		pages.setCurrentPageNo(currentPageNo);
		pages.setPageSize(pageSize);
		pages.setTotalCount(totalCount);
		int totalPageCount = pages.getTotalPageCount();
		// 控制首页和尾页
		if (currentPageNo < 1) {
			currentPageNo = 1;
		} else if (currentPageNo > totalPageCount) {
			currentPageNo = totalPageCount;
		}
		orderList = orderService.selAllOrderPage(userName, _orderState,
				(currentPageNo - 1) * pageSize, pageSize);
		model.addAttribute("orderList", orderList);
		model.addAttribute("orderState", _orderState);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPageNo", currentPageNo);
		return "customer_orderList";
	}

	/*
	 * 跳转未支付的订单
	 */
	@RequestMapping(value="/UntreatedOrder",method=RequestMethod.GET)
	public String UntreatedOrder(
			@RequestParam(value = "customerId", required = false) String customerId,
			Model model) {
		List<Order> orderList=orderService.selUntreatedOrderByCustomerId(Integer.parseInt(customerId));
		model.addAttribute("orderList", orderList);
		return "customer_orderEdit";
	}
	/*
	 * 跳转我的房间记录
	 */
	@RequestMapping(value="/selMyCheckIn")
	public String selMyCheckIn(
			String pageIndex, Model model, HttpSession session)
			throws Exception {
		int customerId=((Customer)session.getAttribute(Constants.USER_SESSION)).getId();
		List<CheckIn> checkInList = null;
		// 设置页面容量
		int pageSize = Constants.pageSize;
		// 当前页码
		int currentPageNo = 1;
		if (pageIndex != null) {
			try {
				currentPageNo = Integer.valueOf(pageIndex);
			} catch (NumberFormatException e) {
				return "error";
			}
		}
		// 总数量（表）
		int totalCount = checkInService.selCountByCustomerId(customerId);
		// 总页数
		PageSupport pages = new PageSupport();
		pages.setCurrentPageNo(currentPageNo);
		pages.setPageSize(pageSize);
		pages.setTotalCount(totalCount);
		int totalPageCount = pages.getTotalPageCount();
		// 控制首页和尾页
		if (currentPageNo < 1) {
			currentPageNo = 1;
		} else if (currentPageNo > totalPageCount) {
			currentPageNo = totalPageCount;
		}
		checkInList = checkInService.selCheckInByCustomerId(customerId,(currentPageNo - 1) * pageSize, pageSize);
		model.addAttribute("checkInList", checkInList);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPageNo", currentPageNo);
		return "customer_myRoom";
	}
	/*
	 * 更改会员等级
	 */
	@RequestMapping(value="/modifyUserMemberIdAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object modifyUserMemberIdAjax(@RequestParam("memberId") String memberId,
			HttpSession session){
		Map<String, String> result = new HashMap<String, String>();
		Customer customer=new Customer();
		customer.setId(((Customer)session.getAttribute(Constants.USER_SESSION)).getId());
		customer.setUserMemberId(Integer.parseInt(memberId));
		if (customerService.modifyMemberName_ByCustomerId(customer)) {
			Customer refreshCustomer=customerService.login(((Customer)session.getAttribute(Constants.USER_SESSION)).getUserCode(), ((Customer)session.getAttribute(Constants.USER_SESSION)).getUserPassword());
			session.setAttribute(Constants.USER_SESSION,refreshCustomer);//重新登陆
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 通过用户账号查询id
	 */
	@RequestMapping(value="/selCustomerByUserCodeAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object selCustomerByUserCodeAjax(@RequestParam("userCode") String userCode){
		return customerService.selCustomer_ByUserCode(userCode);
	}
	/*
	 * 添加顾客评论(ajax)
	 */
	@RequestMapping(value="/addCommentAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object addCommentAjax(@RequestParam(value="commentFile",required=false)MultipartFile commentFile,
			@RequestParam(value="commentStar")String commentStar,
			@RequestParam(value="commentContext")String commentContext,
			@RequestParam(value="orderId")String orderId,
			HttpSession session,HttpServletRequest req){
		String fileName=null;
		File file=null;
		String newCommentFile=null;
		if(commentFile!=null){
			//1.是否有上传文件
			if(!commentFile.isEmpty()){
				//2.设置文件存放路径
				String path=req.getSession().getServletContext().getRealPath("/static/")+File.separator+"customer"+File.separator+"images"+File.separator+"commentImg";
				//3.获取原文件名
				String originalName=commentFile.getOriginalFilename();
				//4.判断文件大小
				int size=500000;
				//5.获得文件后缀名
				String suffix=FilenameUtils.getExtension(originalName);
				if(commentFile.getSize()>size){
					req.setAttribute("fileError_COMM", "上传的文件过大,请重新上传!");
				}else if(suffix.equalsIgnoreCase("jpg")||
						suffix.equalsIgnoreCase("jpeg")||
						suffix.equalsIgnoreCase("png")||
						suffix.equalsIgnoreCase("pneg")
						){
					//添加格式为时间戳加随机数
					fileName=System.currentTimeMillis()+RandomUtils.nextInt(1000000)+"_COMM."+suffix;
					file=new File(path,fileName);
					//如果文件不存在就创建一个
					if(!file.exists()){
						file.mkdirs();
					}
					try {
						commentFile.transferTo(file);
						newCommentFile="static/customer/images/commentImg/"+fileName;
					} catch (Exception e) {
						req.setAttribute("fileError_COMM", e.getMessage());
					}
				}else{
					req.setAttribute("fileError_COMM", "上传的文件后缀不满足,请重新上传!");
				}
			}
		}
		Map<String, String> result=new HashMap<String, String>();
		Comment comment=new Comment();
		comment.setComContext(commentContext);
		comment.setComImg(newCommentFile);
		comment.setComStar(Integer.parseInt(commentStar));
		comment.setOrderId(Integer.parseInt(orderId));
		if(commentService.addComment(comment)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 我的评论
	 */
	@RequestMapping(value="/selMyComment",method=RequestMethod.GET)
	public String selMyComment(Model model,HttpSession session){
		model.addAttribute("commentList", commentService.selComment_ByCustomerId(((Customer)session.getAttribute(Constants.USER_SESSION)).getId()));
		return "customer_myComment";
	}
	/*
	 * 根据id删除评论
	 */
	@RequestMapping(value="/deleteCommentAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object deleteCommentAjax(@RequestParam("commentId") String commentId,HttpServletRequest req){
		Map<String, String> result = new HashMap<String, String>();
		//根据文件路径删除
		Comment comment=commentService.selComment_ById(Integer.parseInt(commentId));
		String filePath=req.getSession().getServletContext().getRealPath("/static/")+File.separator+"customer"+File.separator+"images"+File.separator+"commentImg";
		String imgFile=comment.getComImg();
		String fileName=imgFile.substring(imgFile.length()-22);
		try {
			File file = new File(filePath, fileName);
			//如果文件不存在就创建一个
			if (file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			System.out.println("删除文件操作出错");
			e.printStackTrace();
		}
		if(commentService.deleteComment(Integer.parseInt(commentId))){
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}
}
