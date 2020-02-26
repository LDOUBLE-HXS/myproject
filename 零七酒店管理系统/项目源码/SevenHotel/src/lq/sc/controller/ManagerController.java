package lq.sc.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lq.sc.pojo.CheckIn;
import lq.sc.pojo.Customer;
import lq.sc.pojo.Manager;
import lq.sc.pojo.Member;
import lq.sc.pojo.Order;
import lq.sc.pojo.Room;
import lq.sc.pojo.RoomType;
import lq.sc.service.bank.BankService;
import lq.sc.service.checkIn.CheckInService;
import lq.sc.service.comment.CommentService;
import lq.sc.service.customer.CustomerService;
import lq.sc.service.manager.ManagerService;
import lq.sc.service.member.MemberService;
import lq.sc.service.memberOrder.MemberOrderService;
import lq.sc.service.order.OrderService;
import lq.sc.service.position.PositionService;
import lq.sc.service.room.RoomService;
import lq.sc.service.roomtype.RoomTypeService;
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
 * 
 * 项目名称：SevenHotel 
 * 类名称：ManagerController 
 * 类描述：管理员控制层  
 * 创建人：lhh  
 * 创建时间：2018-10-27 上午11:08:50
 * 
 * @version       
 */
@Controller
@RequestMapping("/manager")
public class ManagerController {
	@Resource
	private ManagerService managerService;
	@Resource
	private CustomerService customerService;
	@Resource
	private MemberService memberService;
	@Resource
	private OrderService orderService;
	@Resource
	private CheckInService checkInService;
	@Resource
	private RoomService roomService;
	@Resource
	private RoomTypeService roomTypeService;
	@Resource
	private MemberOrderService memberOrderService;
	@Resource
	private PositionService positionService;
	@Resource
	private BankService bankService;
	@Resource
	private CommentService commentService;
	/*
	 * 404页面
	 */
	@RequestMapping("*")
	public String fourZeroFour(){
		return "admin_404";
	}
	/*
	 * 跳转登陆
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "admin_login";
	}

	/*
	 * 验证管理员登入账号
	 */
	@RequestMapping(value = "/manCodeAjax", method = RequestMethod.POST)
	@ResponseBody
	public Object manCodeAjax(@RequestParam("manCode") String manCode) {
		return (Manager)managerService.manCodeExist(manCode);
	}

	/*
	 * 登陆
	 */
	@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
	public String doLogin(@RequestParam("manCode") String manCode,
			@RequestParam("manPassword") String manPassword,
			HttpSession session, HttpServletRequest req) {
		session.setAttribute("manCode", manCode);
		Manager manager=managerService.login(manCode, manPassword);
		if(manager!=null){
			session.setAttribute(Constants.ADMIN_SESSION, manager);
			return "admin_main";
		}else{
			req.setAttribute("error", "密码不正确！！！");
			return "admin_login";
		}
		
	}
	/*
	 * 退出登陆
	 */
	@RequestMapping(value="/exit",method=RequestMethod.GET)
	public String exit(HttpSession session){
		if (session != null) {
			session.removeAttribute("manCode");
			session.removeAttribute(Constants.ADMIN_SESSION);
		}
		return "redirect:/manager/login";
	}
	/*
	 * 主页面的加载页面
	 */
	@RequestMapping("/hello")
	public String Hello(Model model) {
		model.addAttribute("orderList", orderService.selUntreatedOrder());
		return "admin_hello";
	}
	/*
	 * 用户分页
	 */
	@RequestMapping("/customerList")
	public String getAllCustomer(
			@RequestParam(value = "userName", required = false) String userName,
			@RequestParam(value = "userMemberId", required = false) String userMemberId,
			String pageIndex, Model model, HttpSession session)
			throws Exception {
		int _userMemberId = 0;
		List<Customer> customerList = null;
		// 设置页面容量
		int pageSize = Constants.pageSize;
		// 当前页码
		int currentPageNo = 1;
		if (userName == null) {
			userName = "";
		}
		if (userMemberId != null && !userMemberId.equals("")) {
			_userMemberId = Integer.parseInt(userMemberId);
		}

		if (pageIndex != null) {
			try {
				currentPageNo = Integer.valueOf(pageIndex);
			} catch (NumberFormatException e) {
				return "error";
			}
		}
		// 总数量（表）
		int totalCount = customerService.getCustomerCount(userName,
				_userMemberId);
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

		customerList = customerService.selAllCustomerPage(userName,
				_userMemberId, (currentPageNo - 1) * pageSize, pageSize);
		model.addAttribute("customerList", customerList);
		List<Member> memberList = null;
		memberList = memberService.getAllMember();
		session.setAttribute("memberList", memberList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("userName", userName);
		model.addAttribute("usermemberId", _userMemberId);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPageNo", currentPageNo);
		return "admin_customerList";// 返回集合页面
	}
	/*
	 * 跳转添加会员
	 */
	@RequestMapping(value="/addCustomer",method=RequestMethod.GET)
	public String addCustomer() {
		return "admin_addCustomer";
	}
	/*
	 * 添加会员
	 */
	@RequestMapping(value="/doAddCustomer",method=RequestMethod.POST)
	public String doAddCustomer(Customer customer,HttpSession session){
		customer.setModifyBy(((Manager)session.getAttribute(Constants.ADMIN_SESSION)).getId());
		if(customerService.addCustomer(customer)){
			return "redirect:/manager/customerList";
		}else{
			return "redirect:/manager/addCustomer";
		}
	}
	/*
	 * 管理员通过id查询用户(ajax)
	 */
	@RequestMapping(value="/selCustomerAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selCustomerAjax(@RequestParam("id")String id){
		return (Customer)customerService.selCustomerById(Integer.parseInt(id));
	}
	/*
	 * 管理员通过id修改用户(ajax)
	 */
	@RequestMapping(value = "/modifyCustomerAjax", method = RequestMethod.POST)
	@ResponseBody
	public Object modifyCustomerAjax(@RequestParam("id") String id,
			@RequestParam("userCode") String userCode,
			@RequestParam("userName") String userName,
			@RequestParam("userPhone") String userPhone,
			@RequestParam("userCard") String userCard,
			@RequestParam("userMemberId") String userMemberId,
			@RequestParam("integral") String integral,
			HttpSession session) {
		Map<String, String> result = new HashMap<String, String>();
		Customer customer=new Customer();
		customer.setId(Integer.parseInt(id));
		customer.setUserCode(userCode);
		customer.setUserName(userName);
		customer.setUserPhone(userPhone);
		customer.setUserCard(userCard);
		customer.setUserMemberId(Integer.parseInt(userMemberId));
		customer.setIntegral(Integer.parseInt(integral));
		customer.setModifyBy(((Manager)session.getAttribute(Constants.ADMIN_SESSION)).getId());
		if (customerService.modifyCustomerById(customer)) {
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 通过id删除会员
	 */
	@RequestMapping(value="/deleteCustomerAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object deleteCustomerAjax(@RequestParam("id") String id){
		Map<String, String> result = new HashMap<String, String>();
		//删除银行绑定信息
		bankService.deleteBankByCustomerId(Integer.parseInt(id));
		//删除用户前先删除他关联的房间订单
		orderService.deleteOrder_ByCustomerId(Integer.parseInt(id));
		//再删除会员卡订单
		memberOrderService.deleteMemberOrder_ById(Integer.parseInt(id));
		if (customerService.deleteCustomerById(Integer.parseInt(id))) {
			result.put("result", "true");
		} else {
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 跳转会员福利页面
	 */
	@RequestMapping(value="/memberWelfare",method=RequestMethod.GET)
	public String memberWelfare(HttpSession session){
		List<Member> memberList = null;
		memberList = memberService.getAllMember();
		session.setAttribute("memberList", memberList);
		return "/admin_member";
	}
	/*
	 * 根据id查询管理员
	 */
	@RequestMapping(value="/selManagerAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object selManagerAjax(@RequestParam("id") String id){
		return (Manager)managerService.selManageById(Integer.parseInt(id));
	}
	/*
	 * 验证是否已存在会员类别
	 */
	@RequestMapping(value="/selMemberAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object selMemberAjax(@RequestParam("memberType") String memberType){
		Map<String, String> result=new HashMap<String, String>();
		if(memberService.selMemberType(memberType)){
			result.put("result", "true");
		}else{
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 添加会员类别
	 */
	@RequestMapping(value="/addMemberAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object addMemberAjax(@RequestParam("memberType")String memberType,
			@RequestParam("discount")String discount,
			HttpSession session){
		Map<String, String> result=new HashMap<String, String>();
		Member member=new Member();
		member.setMemberType(memberType);
		member.setDiscount(Double.parseDouble(discount));
		member.setCreatedBy(((Manager)session.getAttribute(Constants.ADMIN_SESSION)).getId());
		if(memberService.addMemberType(member)){
			result.put("result", "true");
		}else{
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 根据id查询会员福利
	 */
	@RequestMapping(value="/selMemberByIdAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selMemberByIdAjax(@RequestParam("id")String id){
		return (Member)memberService.selMemberById(Integer.parseInt(id));
	}
	/*
	 * 根据id修改会员福利
	 */
	@RequestMapping(value="/modifyMemberByIdAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object modifyMemberByIdAjax(@RequestParam("id")String id,
			@RequestParam("memberType")String memberType,
			@RequestParam("discount")String discount,
			HttpSession session
			){
		Map<String, String> result=new HashMap<String, String>();
		Member member=new Member();
		member.setId(Integer.parseInt(id));
		member.setMemberType(memberType);
		member.setDiscount(Double.parseDouble(discount));
		member.setModifyBy(((Manager)session.getAttribute(Constants.ADMIN_SESSION)).getId());
		if(memberService.modifyMemberById(member)){
			result.put("result", "true");
		}else{
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 根据id删除会员福利
	 */
	@RequestMapping(value="/deleteMemberByIdAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object deleteMemberByIdAjax(@RequestParam("id")String id){
		Map<String, String> result=new HashMap<String, String>();
		if(memberService.deleteMemberById(Integer.parseInt(id))){
			result.put("result", "true");
		}else{
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 订单分页
	 */
	@RequestMapping("/orderList")
	public String getAllOrder(
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
		orderList = orderService.selAllOrderPage(userName, _orderState, (currentPageNo - 1) * pageSize, pageSize);
		model.addAttribute("orderList", orderList);
		model.addAttribute("userName", userName);
		model.addAttribute("orderState", _orderState);
		model.addAttribute("totalPageCount", totalPageCount);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPageNo", currentPageNo);
		return "admin_orderList";// 返回集合页面
	}
	/*
	 * 跳转处理订单办理入住
	 */
	@RequestMapping(value="/dealOrder",method=RequestMethod.GET)
	public String dealOrder(Model model){
		List<Order> orderList=orderService.selUntreatedOrder();
		model.addAttribute("orderList",orderList);
		return "admin_orderEdit";
	}
	/*
	 * 实现顾客订单入住
	 */
	@RequestMapping(value="/editOrderAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object editOrderAjax(@RequestParam("orderId") String orderId,
			@RequestParam("roomId") String roomId,
			HttpSession session){
		Map<String, String> result=new HashMap<String, String>();
		CheckIn checkIn=new CheckIn();
		checkIn.setManagerId(((Manager)session.getAttribute(Constants.ADMIN_SESSION)).getId());
		checkIn.setOrderId(Integer.parseInt(orderId));
		checkIn.setRoomId(Integer.parseInt(roomId));
		if(checkInService.addCheckIn(checkIn)){
			result.put("result", "true");
		}else{
			result.put("result", "false");
		}
		return result;
	}
	/*
	 * 跳转房间管理
	 */
	@RequestMapping(value="/toRoomManager")
	public String toRoomManager(Model model){
		List<Room> roomList=roomService.selAllRoom();
		List<RoomType> roomTypeList=roomTypeService.selAllRoomType();
		model.addAttribute("roomList", roomList);
		model.addAttribute("roomTypeList", roomTypeList);
		return "admin_roomList";
	}
	/*
	 * 跳转房间类型管理
	 */
	@RequestMapping(value="/toRoomTypeManager",method=RequestMethod.GET)
	public String toRoomTypeManager(Model model){
		List<RoomType> roomTypeList=roomTypeService.selAllRoomType();
		model.addAttribute("roomTypeList",roomTypeList);
		return "admin_roomTypeList";
	}
	/*
	 * 跳转办理入住页面
	 */
	@RequestMapping(value="/toCheckInPage",method=RequestMethod.GET)
	public String toCheckInPage(Model model){
		model.addAttribute("roomTypeList", roomTypeService.selAllRoomType());
		return "admin_checkIn";
	}
	/*
	 * 跳转员工管理
	 */
	@RequestMapping(value="/toManagerPage")
	public String toManagerPage(@RequestParam(value = "manState", required = false) String manState,
			Model model) throws Exception{
		List<Manager> managerList=null;
		int _manState=0;
		if(manState!=null){
			_manState=Integer.parseInt(manState);
		}
		managerList=managerService.selManagerByState(_manState);
		model.addAttribute("managerList",managerList );
		model.addAttribute("positionList", positionService.selAllPosition());
		return "admin_managerList";
	}
	/*
	 * 跳转添加员工
	 */
	@RequestMapping(value="/toAddManager")
	public String toAddManager(Model model){
		model.addAttribute("positionList", positionService.selAllPosition());
		return "admin_addManager";
	}
	/*
	 * 添加员工信息
	 */
	@RequestMapping(value="/addManagerAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object addManagerAjax(@RequestParam(value="workImgFile",required=false)MultipartFile workImgFile,
			@RequestParam(value="manCode",required=false)String manCode,
			@RequestParam(value="manName",required=false)String manName,
			@RequestParam(value="manPhone",required=false)String manPhone,
			@RequestParam(value="manSex",required=false)String manSex,
			@RequestParam(value="positionId",required=false)String positionId,
			HttpSession session,HttpServletRequest req){
		String fileName=null;
		File file=null;
		String newWorkImgFile=null;
		if(workImgFile!=null){
			//1.是否有上传文件
			if (!workImgFile.isEmpty()) {
				// 2.设置文件存放路径
				String path = req.getSession().getServletContext()
						.getRealPath("/static/")
						+ File.separator
						+ "admin"
						+ File.separator
						+ "images"
						+ File.separator + "workPic";
				//3.获取原文件名
				String originalName=workImgFile.getOriginalFilename();
				//4.获得文件后缀名
				String suffix=FilenameUtils.getExtension(originalName);
				//添加格式为时间戳加随机数
				fileName=System.currentTimeMillis()+RandomUtils.nextInt(1000000)+"_WORK."+suffix;
				file=new File(path,fileName);
				// 如果文件不存在就创建一个
				if (!file.exists()) {
					file.mkdirs();
				}
				try {
					workImgFile.transferTo(file);
					newWorkImgFile="static/admin/images/workPic/"+fileName;
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		Map<String, String> result=new HashMap<String, String>();
		Manager manager=new Manager();
		manager.setManSex(Integer.parseInt(manSex));
		manager.setWorkPicPath(newWorkImgFile);
		manager.setManCode(manCode);
		manager.setManName(manName);
		manager.setManPhone(manPhone);
		manager.setPositionId(Integer.parseInt(positionId));
		if(managerService.addManager(manager)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 修改员工信息
	 */
	@RequestMapping(value="/modifyManagerAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object modifyManagerAjax(@RequestParam(value="workImgFile",required=false)MultipartFile workImgFile,
			@RequestParam(value="manName",required=false)String manName,
			@RequestParam(value="manPhone",required=false)String manPhone,
			@RequestParam(value="positionId",required=false)String positionId,
			@RequestParam(value="manState",required=false)String manState,
			@RequestParam(value="managerId",required=false)String managerId,
			HttpServletRequest req){
		String fileName=null;
		File file=null;
		if(workImgFile!=null){
			//1.是否有上传文件
			if (!workImgFile.isEmpty()) {
				// 2.设置文件存放路径
				String path = req.getSession().getServletContext()
						.getRealPath("/static/")
						+ File.separator
						+ "admin"
						+ File.separator
						+ "images"
						+ File.separator + "workPic";
				// 得到管理员存放图片的路径
				Manager manager=managerService.selManageById(Integer.parseInt(managerId));
				String workPicPath=manager.getWorkPicPath();
				//截取图片名
				fileName=workPicPath.substring(workPicPath.length()-22);
				file = new File(path, fileName);
				// 如果文件不存在就创建一个
				if (!file.exists()) {
					file.mkdirs();
				}
				try {
					workImgFile.transferTo(file);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
		Map<String, String> result=new HashMap<String, String>();
		Manager modifyManager=new Manager();
		modifyManager.setId(Integer.parseInt(managerId));
		modifyManager.setManName(manName);
		modifyManager.setManPhone(manPhone);
		modifyManager.setManState(Integer.parseInt(manState));
		modifyManager.setPositionId(Integer.parseInt(positionId));
		if(managerService.modifyManager_ById(modifyManager)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据id删除员工
	 */
	@RequestMapping(value="/deleteManagerAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object deleteManagerAjax(@RequestParam(value="managerId")String managerId,
			HttpServletRequest req){
		Map<String, String> result = new HashMap<String, String>();
		// 根据文件路径删除
		Manager manager = managerService.selManageById(Integer.parseInt(managerId));
		String filePath = req.getSession().getServletContext()
				.getRealPath("/static/")
				+ File.separator
				+ "admin"
				+ File.separator
				+ "images"
				+ File.separator + "workPic";
		String workPicPath = manager.getWorkPicPath();
		String fileName = workPicPath.substring(workPicPath.length() - 22);
		try {
			File file = new File(filePath, fileName);
			if (file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			System.out.println("删除文件操作出错");
			e.printStackTrace();
		}
		if(managerService.deleteManager_ById(Integer.parseInt(managerId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 跳转评论
	 */
	@RequestMapping("/toComment")
	public String toComment(Model model){
		model.addAttribute("commentList", commentService.selAllComment());
		return "admin_comment";
	}
	/*
	 * 跳转流水统计
	 */
	@RequestMapping("toBusiness")
	public String toBusiness(Model model){
		//销售订单总额
		model.addAttribute("orderBusiness", orderService.selBusiness());
		//会员卡订单总额
		model.addAttribute("memberBusiness", memberOrderService.memberBusiness());
		//开卡次数
		model.addAttribute("memberCount", memberOrderService.memberCount());
		//会员卡列表
		model.addAttribute("memberList", memberService.getAllMember());
		return "admin_business";
	}
}
