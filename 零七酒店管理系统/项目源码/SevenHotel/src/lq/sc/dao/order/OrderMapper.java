package lq.sc.dao.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import lq.sc.pojo.Order;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：OrderMapper  
* 类描述：订单Mapper接口  
* 创建人：lhh  
* 创建时间：2018-11-3 下午4:15:04
* @version   
*   
 */
@Service
public interface OrderMapper {
	/*
	 * 添加订单
	 */
	public int addOrder(Order order);
	/*
	 * 查询未处理的订单（即还未入住的订单）
	 */
	public List<Order> selUntreatedOrder();
	/*
	 * 分页查询所有订单
	 */
	public List<Order> selAllOrderPage(Map<String,Object> map)throws Exception;
	/*
	 * 得到订单总数
	 */
	public int getAllOrderCount(@Param("userName")String userName,@Param("orderState")int orderState);
	/*
	 * 根据订单id查询订单详情
	 */
	public Order selOrderById(int orderId);
	/*
	 * 根据订单id进行退单处理
	 */
	public int modifyOrderStateIsFour(int orderId);
	/*
	 * 根据订单id进行订单回收
	 */
	public int modifyOrderStateIsThree(int orderId);
	/*
	 * 根据订单id进行支付未付款订单
	 */
	public int modifyOrderStateIsOne(int orderId);
	/*
	 * 根据订单id进行删除
	 */
	public int deleteOrder(int orderId);
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
	public int deleteOrder_ByCustomerId(int customerId);
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
