package lq.sc.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lq.sc.pojo.Customer;
import lq.sc.pojo.MemberOrder;
import lq.sc.pojo.Order;
import lq.sc.service.bank.BankService;
import lq.sc.service.checkIn.CheckInService;
import lq.sc.service.comment.CommentService;
import lq.sc.service.customer.CustomerService;
import lq.sc.service.memberOrder.MemberOrderService;
import lq.sc.service.order.OrderService;
import lq.sc.tools.Constants;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 *     项目名称：SevenHotel   类名称：OrderController   类描述： 订单控制层  创建人：lhh  
 * 创建时间：2018-11-3 下午4:29:45
 * 
 * @version       
 */
@Controller
@RequestMapping("/order")
public class OrderController {
	@Resource
	private OrderService orderService;
	@Resource
	private CustomerService customerService;
	@Resource
	private BankService bankService;
	@Resource
	private MemberOrderService memberOrderService;
	@Resource
	private CommentService commentService;
	@Resource
	private CheckInService checkInService;
	/*
	 * 用户添加订单(ajax)
	 */
	@RequestMapping(value = "/addOrder", method = RequestMethod.POST)
	@ResponseBody
	public Object addOrder(
			@RequestParam("roomTypeId") String roomTypeId,
			@RequestParam("checkInTime") String checkInTime,
			@RequestParam("checkOutTime") String checkOutTime,
			@RequestParam("orderState") String orderState,
			@RequestParam("settlement") String settlement,
			@RequestParam("orderRoomNum") String orderRoomNum,
			@RequestParam(value = "orderDesc", required = false) String orderDesc,
			HttpSession session) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Order order=new Order();
		order.setRoomTypeId(Integer.parseInt(roomTypeId));
		order.setUserId(((Customer)session.getAttribute(Constants.USER_SESSION)).getId());
		order.setCheckInTime((Date)dateFormat.parseObject(checkInTime));
		order.setCheckOutTime((Date)dateFormat.parseObject(checkOutTime));
		order.setOrderState(Integer.parseInt(orderState));
		order.setSettlement(Double.parseDouble(settlement));
		order.setOrderRoomNum(Integer.parseInt(orderRoomNum));
		order.setOrderDesc(orderDesc);
		if(orderService.addOrder(order)){
			Customer refreshCustomer=customerService.login(((Customer)session.getAttribute(Constants.USER_SESSION)).getUserCode(), ((Customer)session.getAttribute(Constants.USER_SESSION)).getUserPassword());
			session.setAttribute(Constants.USER_SESSION,refreshCustomer);//重新登陆
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 管理员添加订单(ajax)
	 */
	@RequestMapping(value = "/addOrderByManager", method = RequestMethod.POST)
	@ResponseBody
	public Object addOrderByManager(
			@RequestParam("customerId") String customerId,
			@RequestParam("roomTypeId") String roomTypeId,
			@RequestParam("checkInTime") String checkInTime,
			@RequestParam("checkOutTime") String checkOutTime,
			@RequestParam("orderState") String orderState,
			@RequestParam("settlement") String settlement,
			@RequestParam("orderRoomNum") String orderRoomNum,
			@RequestParam(value = "orderDesc", required = false) String orderDesc,
			HttpSession session) throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Order order=new Order();
		order.setRoomTypeId(Integer.parseInt(roomTypeId));
		order.setUserId(Integer.parseInt(customerId));
		order.setCheckInTime((Date)dateFormat.parseObject(checkInTime));
		order.setCheckOutTime((Date)dateFormat.parseObject(checkOutTime));
		order.setOrderState(Integer.parseInt(orderState));
		order.setSettlement(Double.parseDouble(settlement));
		order.setOrderRoomNum(Integer.parseInt(orderRoomNum));
		order.setOrderDesc(orderDesc);
		if(orderService.addOrder(order)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据id查询订单
	 */
	@RequestMapping(value="/selOrderAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selOrderAjax(@RequestParam("orderId") String orderId){
		return (Order)orderService.selOrderById(Integer.parseInt(orderId));
	}
	/*
	 * 根据id进行退单
	 */
	@RequestMapping(value="/returnOrderAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object returnOrderAjax(@RequestParam(value="orderId") String orderId){
		Map<String, String> result=new HashMap<String, String>();
		if(orderService.modifyOrderStateIsFour(Integer.parseInt(orderId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据id进行订单回收
	 */
	@RequestMapping(value="/recoverOrderAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object recoverOrderAjax(@RequestParam("orderId") String orderId){
		Map<String, String> result=new HashMap<String, String>();
		if(orderService.modifyOrderStateIsThree(Integer.parseInt(orderId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据id支付未付款订单
	 */
	@RequestMapping(value="/payForUntreatedOrderAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object payForUntreatedOrderAjax(@RequestParam("orderId") String orderId){
		Map<String, String> result=new HashMap<String, String>();
		if(orderService.modifyOrderStateIsOne(Integer.parseInt(orderId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 删除订单
	 */
	@RequestMapping(value="/deleteOrderAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object deleteOrderAjax(@RequestParam("orderId") String orderId){
		Map<String, String> result=new HashMap<String, String>();
		//删除入住记录
		checkInService.deleteCheckInByOrderId(Integer.parseInt(orderId));
		if(orderService.deleteOrder(Integer.parseInt(orderId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 查询未处理的订单中已经预定的房间类型数量
	 */
	@RequestMapping(value="/selUntreatedOrderRoomNumAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selUntreatedOrderRoomNumAjax(@RequestParam("roomTypeId") String roomTypeId){
		List<Integer> intList=orderService.selUntreatedOrderRoomNum(Integer.parseInt(roomTypeId));
		return intList;
	}
	/*
	 * 添加会员卡订单
	 */
	@RequestMapping(value="/addMemberOrderAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object addMemberOrderAjax(
			@RequestParam("memberId") String memberId,
			@RequestParam("orderPrice") String orderPrice,
			HttpSession session){
		Map<String, String> result=new HashMap<String, String>();
		MemberOrder memberOrder=new MemberOrder();
		memberOrder.setCustomerId(((Customer)session.getAttribute(Constants.USER_SESSION)).getId());
		memberOrder.setMemberId(Integer.parseInt(memberId));
		memberOrder.setOrderPrice(Double.parseDouble(orderPrice));
		if(memberOrderService.addMemberOrder(memberOrder)){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
	/*
	 * 根据入住离店时间查询订单
	 */
	@RequestMapping(value="/selOrder_ByCheckRangeTimeAjax",method=RequestMethod.POST)
	@ResponseBody
	public Object selOrder_ByCheckRangeTimeAjax(
			@RequestParam("checkInTime") String checkInTime,
			@RequestParam("checkOutTime") String checkOutTime) throws ParseException{
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Order order=new Order();
		order.setCheckInTime((Date)dateFormat.parseObject(checkInTime));
		order.setCheckOutTime((Date)dateFormat.parseObject(checkOutTime));
		return orderService.selOrder_ByCheckRangeTime(order);
	}
	/*
	 * 根据订单id查看是否已评论
	 */
	@RequestMapping(value="/selCommentByOrderIdAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object selCommentByOrderIdAjax(@RequestParam("orderId") String orderId){
		Map<String, String> result=new HashMap<String, String>();
		if(commentService.selCommentCount_ByOrderId(Integer.parseInt(orderId))){
			result.put("result","true");
		}else{
			result.put("result","false");
		}
		return result;
	}
}
