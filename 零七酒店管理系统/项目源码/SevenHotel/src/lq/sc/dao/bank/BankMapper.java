package lq.sc.dao.bank;

import org.springframework.stereotype.Service;

import lq.sc.pojo.Bank;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：BankMapper  
* 类描述：银行卡mapper接口(虚假货币，只用于测试)  
* 创建人：lhh
* 创建时间：2018-10-30 上午11:14:24
* @version   
*   
 */
@Service
public interface BankMapper {
	/*
	 * 根据id查询银行所有信息
	 */
	public Bank selBankInfById(int customerId);
	/*
	 * 绑定银行卡
	 */
	public int bindBankCard(Bank bank);
	/*
	 * 更改余额
	 */
	public int payForOrder(Bank bank);
	/*
	 * 根据用户id删除银行卡
	 */
	public int deleteBankByCustomerId(int customerId);
}
