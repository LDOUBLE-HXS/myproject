package lq.sc.pojo;

import java.util.Date;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：memberOrder  
* 类描述：会员卡购买订单  
* 创建人：lhh  
* 创建时间：2018-11-19 上午9:11:04
* @version   
*   
 */
public class MemberOrder {
	private int id;//会员卡订单编号
	private int memberId;//会员卡编号
	private int customerId;//订购会员卡的酒店用户
	private Date orderTime;//订购下单的时间
	private double orderPrice;//下单价格
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public Date getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	public double getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(double orderPrice) {
		this.orderPrice = orderPrice;
	}
}
