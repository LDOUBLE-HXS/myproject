package lq.sc.pojo;

import java.util.Date;

/** 
*   
* 项目名称：SevenHotel  
* 类名称：Order  
* 类描述： 用户订单信息的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Order {
	private int id; //订单编号
	private int roomTypeId; //房间类型
	private int userId; //关联客户id，得到客户信息、订房折扣
	private Date checkInTime; //入住时间
	private Date checkOutTime; //退房时间
	private Date orderTime;//下单时间
	private int orderRoomNum;//订单的房间数量
	private String orderDesc; //结算信息
	private int orderState; //订单状态(1:已付款。2：未付款)
	private double settlement; //结算金额
	private  Customer customer;//用户
	private RoomType roomtype; //房间类型
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getRoomTypeId() {
		return roomTypeId;
	}
	public void setRoomTypeId(int roomTypeId) {
		this.roomTypeId = roomTypeId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getCheckInTime() {
		return checkInTime;
	}
	public void setCheckInTime(Date checkInTime) {
		this.checkInTime = checkInTime;
	}
	public Date getCheckOutTime() {
		return checkOutTime;
	}
	public void setCheckOutTime(Date checkOutTime) {
		this.checkOutTime = checkOutTime;
	}
	public String getOrderDesc() {
		return orderDesc;
	}
	public void setOrderDesc(String orderDesc) {
		this.orderDesc = orderDesc;
	}
	public int getOrderState() {
		return orderState;
	}
	public void setOrderState(int orderState) {
		this.orderState = orderState;
	}
	public double getSettlement() {
		return settlement;
	}
	public void setSettlement(double settlement) {
		this.settlement = settlement;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public RoomType getRoomtype() {
		return roomtype;
	}
	public void setRoomtype(RoomType roomtype) {
		this.roomtype = roomtype;
	}
	public Date getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	public int getOrderRoomNum() {
		return orderRoomNum;
	}
	public void setOrderRoomNum(int orderRoomNum) {
		this.orderRoomNum = orderRoomNum;
	}
	
}
