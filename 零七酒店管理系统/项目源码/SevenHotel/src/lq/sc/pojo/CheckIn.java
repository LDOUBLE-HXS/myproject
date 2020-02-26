package lq.sc.pojo;

import java.util.Date;

/** 
*   
* 项目名称：SevenHotel  
* 类名称：checkin  
* 类描述： 用户入住的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class CheckIn {
	private int id; //入住记录编号
	private int orderId; //关联订单id
	private int managerId; //关联管理员id，办理入住的职工工号
	private int roomId;
	private int checkState; //入住状态
	private Order order; //订单信息
	private Manager manager;//管理员信息
	private Room room;//房间信息
	private Date editOrderTime;//处理入住时间
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getManagerId() {
		return managerId;
	}
	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}
	
	public int getCheckState() {
		return checkState;
	}
	public void setCheckState(int checkState) {
		this.checkState = checkState;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public int getRoomId() {
		return roomId;
	}
	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	public Date getEditOrderTime() {
		return editOrderTime;
	}
	public void setEditOrderTime(Date editOrderTime) {
		this.editOrderTime = editOrderTime;
	}
	
}
