package lq.sc.service.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import lq.sc.dao.order.OrderMapper;
import lq.sc.pojo.Order;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：OrderServiceImpl  
* 类描述：  订单服务层实现
* 创建人：lhh  
* 创建时间：2019-6-3 下午4:26:41
* @version   
*   
 */
@Service
public class OrderServiceImpl implements OrderService{
	@Resource
	private OrderMapper orderMapper;
	//添加订单
	public boolean addOrder(Order orderForm) {
		if(orderMapper.addOrder(orderForm)>0){
			return true;
		}else{
			return false;
		}
	}
	//查询未处理的订单（即还未入住的订单）
	public List<Order> selUntreatedOrder() {
		return orderMapper.selUntreatedOrder();
	}
	//分页查询所有订单
	public List<Order> selAllOrderPage(String userName, int orderState,
			int currentPageNo, int pageSize)
			throws Exception {
		Map<String,Object> map=new HashMap<String, Object>();	
		map.put("userName", userName);
		map.put("orderState", orderState);
		map.put("currentPageNo", currentPageNo);
		map.put("pageSize", pageSize);
		List<Order> orderList =orderMapper.selAllOrderPage(map);
		return orderList;
	}
	//得到订单总数
	public int getAllOrderCount(String userName,
			int orderState) {
		return orderMapper.getAllOrderCount(userName, orderState);
	}
	//根据id查询订单详情
	public Order selOrderById(int orderId) {
		return orderMapper.selOrderById(orderId);
	}
	//根据id进行退单处理
	public boolean modifyOrderStateIsFour(int orderId) {
		if(orderMapper.modifyOrderStateIsFour(orderId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id进行订单回收
	public boolean modifyOrderStateIsThree(int orderId) {
		if(orderMapper.modifyOrderStateIsThree(orderId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id进行订单回收
		public boolean modifyOrderStateIsOne(int orderId) {
			if(orderMapper.modifyOrderStateIsOne(orderId)>0){
				return true;
			}else{
				return false;
			}
		}
	//根据id进行删除
	public boolean deleteOrder(int orderId) {
		if(orderMapper.deleteOrder(orderId)>0){
			return true;
		}else{
			return false;
		}
	}
	//查询未处理的订单中已经预定的房间类型数量
	public List<Integer> selUntreatedOrderRoomNum(int roomTypeId) {
		return orderMapper.selUntreatedOrderRoomNum(roomTypeId);
	}
	//根据用户id查询客户未付款的订单
	public List<Order> selUntreatedOrderByCustomerId(int customerId) {
		return orderMapper.selUntreatedOrderByCustomerId(customerId);
	}
	//通过用户名删除订单
	public boolean deleteOrder_ByCustomerId(int customerId) {
		if(orderMapper.deleteOrder_ByCustomerId(customerId)>0){
			return true;
		}else{
			return false;
		}
	}
	//通过入住-离开时间查询订单
	public List<Order> selOrder_ByCheckRangeTime(Order order) {
		return orderMapper.selOrder_ByCheckRangeTime(order);
	}
	//查询销售订单总额
	public double selBusiness() {
		return orderMapper.selBusiness();
	}
	//查询下单最多的前三订单
	public List<Order> selTopThree() {
		return orderMapper.selTopThree();
	}
}
