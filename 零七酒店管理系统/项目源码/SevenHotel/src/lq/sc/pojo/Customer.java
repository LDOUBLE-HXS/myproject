package lq.sc.pojo;

import java.util.Date;


/** 
*   
* 项目名称：SevenHotel  
* 类名称：Customer  
* 类描述：  用户注册的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Customer {
	private int id; //用户主键id
	private String userCode; //用户登陆使用的账号，设置唯一性，不可重复
	private String userName; //用户真实姓名
	private String userPassword; //登陆密码(6-12位)
	private String userPhone; //用户电话(11位)
	private String userCard; //身份证号码(15或18位)，用于实名制
	private Date creationDate; //创建时间(截取用户提交注册成功后时间)
	private int modifyBy; //更新者(用户或管理员更新id)
	private Date modifyDate; //更新时间
	private int userMemberId; //用户等级(取自用户类型表-类型id)，默认普通用户
	private int integral; //会员所有积分，默认为0
	private Bank bank;//银行卡
	private Member member;//用户类型
	public Bank getBank() {
		return bank;
	}
	public void setBank(Bank bank) {
		this.bank = bank;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserCode() {
		return userCode;
	}
	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserCard() {
		return userCard;
	}
	public void setUserCard(String userCard) {
		this.userCard = userCard;
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
	public int getUserMemberId() {
		return userMemberId;
	}
	public void setUserMemberId(int userMemberId) {
		this.userMemberId = userMemberId;
	}
	public int getIntegral() {
		return integral;
	}
	public void setIntegral(int integral) {
		this.integral = integral;
	}
}
