package lq.sc.pojo;

import java.util.Date;

/** 
*   
* 项目名称：SevenHotel  
* 类名称：Member  
* 类描述： 用户会员类型的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Member {
	private int id; //类型主键id
	private String memberType; //用户类型，设置唯一性(会员优惠制)
	private double discount; //优惠折扣
	private int createdBy; //创建者(由管理者设立优惠)
	private Date creationDate; //创建时间
	private int modifyBy; //修改者 
	private Date modifyDate; //修改时间
	private Manager manager;//管理员
	private double memberPrice;//会员卡价格
	public double getMemberPrice() {
		return memberPrice;
	}
	public void setMemberPrice(double memberPrice) {
		this.memberPrice = memberPrice;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMemberType() {
		return memberType;
	}
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public int getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public int getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(int modifyBy) {
		this.modifyBy = modifyBy;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
}
