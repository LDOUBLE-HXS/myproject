package lq.sc.pojo;
/** 
*   
* 项目名称：SevenHotel  
* 类名称：Position  
* 类描述： 管理员职位的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Position {
	private int id; //角色主键id
	private String positionType; //职位类型
	private double salary; //每月薪水
	private String positionDesc; //职位描述
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPositionType() {
		return positionType;
	}
	public void setPositionType(String positionType) {
		this.positionType = positionType;
	}
	public double getSalary() {
		return salary;
	}
	public void setSalary(double salary) {
		this.salary = salary;
	}
	public String getPositionDesc() {
		return positionDesc;
	}
	public void setPositionDesc(String positionDesc) {
		this.positionDesc = positionDesc;
	}
	
}
