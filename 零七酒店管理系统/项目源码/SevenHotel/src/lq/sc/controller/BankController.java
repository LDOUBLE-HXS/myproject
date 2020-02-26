package lq.sc.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lq.sc.pojo.Bank;
import lq.sc.pojo.Customer;
import lq.sc.service.bank.BankService;
import lq.sc.service.customer.CustomerService;
import lq.sc.tools.Constants;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：BankController  
* 类描述：银行卡控制层  
* 创建人：lhh  
* 创建时间：2018-10-30 上午11:28:38
* @version   
*   
 */
@RequestMapping("/bank")
@Controller
public class BankController {
	@Resource
	private BankService bankService;
	@Resource
	private CustomerService customerService;
	/*
	 * 根据id查询银行信息(ajax)
	 */
	@RequestMapping(value="/selBankInfById",method=RequestMethod.GET)
	@ResponseBody
	public Object selBankInfById(HttpSession session){
		return (Bank)bankService.selBankInfById(((Customer)session.getAttribute(Constants.USER_SESSION)).getId());
	}
	/*
	 * 银行卡绑定(ajax)
	 */
	@RequestMapping(value="/bindBankCard",method=RequestMethod.POST)
	@ResponseBody
	public Object bindBankCard(@RequestParam("bankName") String bankName,@RequestParam("bankCard") String bankCard,@RequestParam("bankPassword") String bankPassword,@RequestParam("balance") String balance,HttpSession session){
		HashMap<String, String> result = new HashMap<String, String>();
		Bank bank=new Bank();
		bank.setUserId(((Customer)session.getAttribute(Constants.USER_SESSION)).getId());
		bank.setBankName(bankName);
		bank.setBankCard(Long.parseLong(bankCard));
		bank.setBankPassword(bankPassword);
		bank.setBalance(Double.parseDouble(balance));
		if(bankService.bindBankCard(bank)){
			Customer refreshCustomer=customerService.login(((Customer)session.getAttribute(Constants.USER_SESSION)).getUserCode(), ((Customer)session.getAttribute(Constants.USER_SESSION)).getUserPassword());
			session.setAttribute(Constants.USER_SESSION,refreshCustomer);
			result.put("bind", "true");
		}else{
			result.put("bind", "false");
		}
		return result;
	}
	/*
	 * 更改余额（ajax）
	 */
	@RequestMapping(value="/payForOrderAjax",method=RequestMethod.GET)
	@ResponseBody
	public Object payForOrderAjax(@RequestParam("balance") String balance,
			@RequestParam(value="customerId",required=false) String customerId
			,HttpSession session){
		HashMap<String, String> result = new HashMap<String, String>();
		Bank bank=new Bank();
		if(customerId!=null){
			bank.setUserId(Integer.parseInt(customerId));
		}else{
			bank.setUserId(((Customer)session.getAttribute(Constants.USER_SESSION)).getId());
		}
		bank.setBalance(Double.parseDouble(balance));
		if(bankService.payForOrder(bank)){
			result.put("result", "true");
		}else{
			result.put("result", "false");
		}
		return result;
	}
}
