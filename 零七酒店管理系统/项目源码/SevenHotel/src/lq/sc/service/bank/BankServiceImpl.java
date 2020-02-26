package lq.sc.service.bank;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import lq.sc.dao.bank.BankMapper;
import lq.sc.pojo.Bank;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：BankServiceImpl  
* 类描述：  银行服务实现层
* 创建人：Administrator  
* 创建时间：2018-10-30 上午11:26:49
* @version   
*   
 */
@Service
public class BankServiceImpl implements BankService{
	@Resource
	private BankMapper bankMapper;

	//根据id查询银行信息
	public Bank selBankInfById(int customerId) {
		return bankMapper.selBankInfById(customerId);
	}

	//绑定银行卡
	public boolean bindBankCard(Bank bank) {
		if(bankMapper.bindBankCard(bank)>0){
			return true;
		}else{
			return false;
		}
	}

	//支付扣除余额
	public boolean payForOrder(Bank bank) {
		if(bankMapper.payForOrder(bank)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据用户id删除银行卡
	public boolean deleteBankByCustomerId(int customerId) {
		if(bankMapper.deleteBankByCustomerId(customerId)>0){
			return true;
		}else{
			return false;
		}
	}
	
}
