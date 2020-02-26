package lq.sc.service.bank;

import lq.sc.pojo.Bank;
/**
 *
*   
* 项目名称：SevenHotel  
* 类名称：BankService  
* 类描述： 银行卡服务层 
* 创建人：lhh  
* 创建时间：2018-10-30 上午11:25:12
* @version   
*   
 */
public interface BankService {
	/*
	 * 根据id查询银行所有信息
	 */
	public Bank selBankInfById(int customerId);
	/*
	 * 绑定银行卡
	 */
	public boolean bindBankCard(Bank bank);
	/*
	 * 支付扣除余额
	 */
	public boolean payForOrder(Bank bank);
	/*
	 * 根据用户id删除银行卡
	 */
	public boolean deleteBankByCustomerId(int customerId);
}
