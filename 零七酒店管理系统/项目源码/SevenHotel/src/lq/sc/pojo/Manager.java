package lq.sc.pojo;

import java.util.Date;

/** 
*   
* 项目名称：SevenHotel  
* 类名称：Manager  
* 类描述：  管理员信息的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Manager {
	private int id; //人员主键id
	private String manCode; //管理员登陆使用的工号
	private String manName; //管理员真实姓名
	private String manPassword; //登陆密码(6-12位)
	private String manPhone; //管理员电话(11位)
	private int manSex; //职工性别（1:女、 2:男）
	private String workPicPath; //上传个人工作证件照存储路径
	private Date creationDate; //创建时间(截取上岗成功入职后时间)
	private int positionId; //职位(取自职位表-类型id)
	private Position position;//职位对象
	private int manState;//上岗状态
	public int getManState() {
		return manState;
	}
	public void setManState(int manState) {
		this.manState = manState;
	}
	public Position getPosition() {
		return position;
	}
	public void setPosition(Position position) {
		this.position = position;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getManCode() {
		return manCode;
	}
	public void setManCode(String manCode) {
		this.manCode = manCode;
	}
	public String getManName() {
		return manName;
	}
	public void setManName(String manName) {
		this.manName = manName;
	}
	public String getManPassword() {
		return manPassword;
	}
	public void setManPassword(String manPassword) {
		this.manPassword = manPassword;
	}
	public String getManPhone() {
		return manPhone;
	}
	public void setManPhone(String manPhone) {
		this.manPhone = manPhone;
	}
	public int getManSex() {
		return manSex;
	}
	public void setManSex(int manSex) {
		this.manSex = manSex;
	}
	public String getWorkPicPath() {
		return workPicPath;
	}
	public void setWorkPicPath(String workPicPath) {
		this.workPicPath = workPicPath;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public int getPositionId() {
		return positionId;
	}
	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}

}
