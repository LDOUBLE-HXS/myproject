package lq.sc.pojo;

import java.util.Date;

/** 
*   
* 项目名称：SevenHotel  
* 类名称：Comment  
* 类描述：  用户评论的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Comment {
	private int id; //评论编号
	private int comStar;//评星
	private int orderId;//评论的订单id
	private String comContext; //评论内容
	private String comImg;//评论图片
	private Date comDate; //评论时间
	private Order order;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getComContext() {
		return comContext;
	}
	public void setComContext(String comContext) {
		this.comContext = comContext;
	}
	public Date getComDate() {
		return comDate;
	}
	public void setComDate(Date comDate) {
		this.comDate = comDate;
	}
	public int getComStar() {
		return comStar;
	}
	public void setComStar(int comStar) {
		this.comStar = comStar;
	}
	public String getComImg() {
		return comImg;
	}
	public void setComImg(String comImg) {
		this.comImg = comImg;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	
}
