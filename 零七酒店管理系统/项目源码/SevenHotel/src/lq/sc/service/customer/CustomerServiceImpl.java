package lq.sc.service.customer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import lq.sc.dao.customer.CustomerMapper;
import lq.sc.pojo.Customer;
/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CustomerServiceImpl  
* 类描述：  客户业务实现层
* 创建人：lhh
* 创建时间：2019-5-16 上午11:10:49
* @version   
*   
 */
@Service
public class CustomerServiceImpl implements CustomerService{
	@Resource
	private CustomerMapper customerMapper;
	//登陆
	public Customer login(String userCode, String userPassword) {
		return customerMapper.login(userCode, userPassword);
	}
	//注册
	public boolean register(Customer customer) {
		int result=customerMapper.register(customer);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	//校验登录名
	public boolean userCodeAjax(String userCode) {
		int result=customerMapper.userCodeAjax(userCode);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	//修改密码
	public boolean modifyPassword(Customer customer) {
		int result =customerMapper.modifyPassword(customer);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	//修改个人信息
	public boolean modifyPersonalMessage(Customer customer) {
		int result =customerMapper.modifyPersonalMessage(customer);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	//积分更改
	public boolean modifyIntegral(Customer customer) {
		if(customerMapper.modifyIntegral(customer)>0){
			return true;
		}else{
			return false;
		}
	}
	//分页查询所有用户
	public List<Customer> selAllCustomerPage(String userName, int userMemberId,
			int currentPageNo, int pageSize) throws Exception {
		Map<String,Object> map=new HashMap<String, Object>();	
		map.put("userName", userName);
		map.put("userMemberId", userMemberId);
		map.put("currentPageNo", currentPageNo);
		map.put("pageSize", pageSize);
		List<Customer> customerList = customerMapper.selAllCustomerPage(map);
		return customerList;
	}
	//获得总数据
	public int getCustomerCount(String userName,int userMemberId) {
		return customerMapper.getCustomerCount(userName, userMemberId);
	}
	//管理员添加会员
	public boolean addCustomer(Customer customer) {
		if(customerMapper.addCustomer(customer)>0){
			return true;
		}else{
			return false;
		}
	}
	//管理员通过id查询会员
	public Customer selCustomerById(int id) {
		return customerMapper.selCustomerById(id);
	}
	//管理员通过id修改会员
	public boolean modifyCustomerById(Customer customer) {
		if(customerMapper.modifyCustomerById(customer)>0){
			return true;
		}else{
			return false;
		}
	}
	//管理员通过id删除会员
	public boolean deleteCustomerById(int id) {
		if(customerMapper.deleteCustomerById(id)>0){
			return true;
		}else{
			return false;
		}
	}
	//更改会员等级
	public boolean modifyMemberName_ByCustomerId(Customer customer) {
		if(customerMapper.modifyMemberName_ByCustomerId(customer)>0){
			return true;
		}else{
			return false;
		}
	}
	//通过用户账号查询id
	public Customer selCustomer_ByUserCode(String userCode) {
		return customerMapper.selCustomer_ByUserCode(userCode);
	}
}
