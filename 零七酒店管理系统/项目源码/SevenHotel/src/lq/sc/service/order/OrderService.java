package lq.sc.service.order;

import java.util.List;


import lq.sc.pojo.Order;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：OrderService  
* 类描述：订单服务层  
* 创建人：lhh  
* 创建时间：2018-11-3 下午4:26:18
* @version   
*   
 */
public interface OrderService {
	/*
	 * 添加订单
	 */
	public boolean addOrder(Order orderForm);
	/*
	 * 查询未处理的订单（即还未入住的订单）
	 */
	public List<Order> selUntreatedOrder();
	/*
	 * 分页查询所有订单
	 */
	public List<Order> selAllOrderPage(String userName, int orderState,
			int currentPageNo, int pageSize)throws Exception;
	/*
	 * 得到订单总数
	 */
	public int getAllOrderCount(String userName,int orderState);
	/*
	 * 根据id查询订单详情
	 */
	public Order selOrderById(int orderId);
	/*
	 * 根据id进行退单处理
	 */
	public boolean modifyOrderStateIsFour(int orderId);
	/*
	 * 根据id进行订单回收
	 */
	public boolean modifyOrderStateIsThree(int orderId);
	/*
	 * 根据订单id进行支付未付款订单
	 */
	public boolean modifyOrderStateIsOne(int orderId);
	/*
	 * 根据订单id进行删除
	 */
	public boolean deleteOrder(int orderId);
	/*
	 * 查询未处理的订单中已经预定的房间类型数量
	 */
	public List<Integer> selUntreatedOrderRoomNum(int roomTypeId);
	/*
	 * 根据用户id查询客户未付款的订单
	 */
	public List<Order> selUntreatedOrderByCustomerId(int customerId);
	/*
	 * 通过用户名删除订单
	 */
	public boolean deleteOrder_ByCustomerId(int customerId);
	/*
	 * 通过入住-离开时间查询订单
	 */
	public List<Order> selOrder_ByCheckRangeTime(Order order);
	/*
	 * 查询销售订单总额
	 */
	public double selBusiness();
	/*
	 * 查询下单最多的前三订单
	 */
	public List<Order> selTopThree();
}
