package lq.sc.pojo;
/**
* 
*   
* 项目名称：SevenHotel  
* 类名称：Bank  
* 类描述：用户银行卡的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Bank {
	private Integer id; //银行编号
	private Integer userId; //关联客户id，得到持该卡客户
	private String bankName; //银行名
	private Long bankCard; //银行卡号
	private double balance; //余额
	private String bankPassword;//银行卡密码
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public Long getBankCard() {
		return bankCard;
	}
	public void setBankCard(Long bankCard) {
		this.bankCard = bankCard;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getBankPassword() {
		return bankPassword;
	}
	public void setBankPassword(String bankPassword) {
		this.bankPassword = bankPassword;
	}
}
