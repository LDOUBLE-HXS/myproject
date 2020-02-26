package lq.sc.service.customer;

import java.util.List;


import lq.sc.pojo.Customer;


/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：customerService  
* 类描述：  客户业务层
* 创建人：lhh
* 创建时间：2018-10-16 上午9:35:50
* @version   
*   
 */
public interface CustomerService {
	/*
	 * 登陆
	 */
	public Customer login(String userCode,String userPassword);
	/*
	 * 注册
	 */
	public boolean register(Customer customer);
	/*
	 * 校验登录名
	 */
	public boolean userCodeAjax(String userCode);
	/*
	 * 修改密码
	 */
	public boolean modifyPassword(Customer customer);
	/*
	 * 修改个人信息
	 */
	public boolean modifyPersonalMessage(Customer customer);
	/*
	 * 积分更改
	 */
	public boolean modifyIntegral(Customer customer);
	/*
	 * 更改会员等级
	 */
	public boolean modifyMemberName_ByCustomerId(Customer customer);
	/*
	 * 分页查询所有用户
	 */
	public List<Customer> selAllCustomerPage(String userName,int userMemberId,int currentPageNo, int pageSize)throws Exception;
	/*
	 * 获得用户总数据
	 */
	public int getCustomerCount(String userName,int userMemberId);
	/*
	 * 管理员添加会员
	 */
	public boolean addCustomer(Customer customer);
	/*
	 * 管理员通过id查询会员
	 */
	public Customer selCustomerById(int id);
	/*
	 * 管理员通过id修改会员
	 */
	public boolean modifyCustomerById(Customer customer);
	/*
	 * 管理员通过id删除会员
	 */
	public boolean deleteCustomerById(int id);
	/*
	 * 通过用户账号查询id
	 */
	public Customer selCustomer_ByUserCode(String userCode);
}
