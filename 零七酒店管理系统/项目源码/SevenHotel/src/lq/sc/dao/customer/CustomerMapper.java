package lq.sc.dao.customer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import lq.sc.pojo.Customer;
/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CustomerInterface  
* 类描述： 客户接口 
* 创建人：lhh  
* 创建时间：2018-10-16 上午10:30:30
* @version   
*   
 */
@Service
public interface CustomerMapper {
	/*
	 * 登陆
	 */
	public Customer login(@Param("userCode")String userCode,@Param("userPassword")String userPassword);
	/*
	 * 注册会员
	 */
	public int register(Customer customer);
	/*
	 * 校验登录名
	 */
	public int userCodeAjax(@Param("userCode")String userCode);
	/*
	 * 修改个人信息
	 */
	public int modifyPersonalMessage(Customer customer);
	/*
	 * 修改密码
	 */
	public int modifyPassword(Customer customer);
	/*
	 * 积分更改
	 */
	public int modifyIntegral(Customer customer);
	/*
	 * 更改会员等级
	 */
	public int modifyMemberName_ByCustomerId(Customer customer);
	/*
	 * 分页查询所有用户
	 */
	public List<Customer> selAllCustomerPage(Map<String,Object> map)throws Exception;
	/*
	 * 获得用户总数据
	 */
	public int getCustomerCount(@Param("userName")String userName,@Param("userMemberId")int userMemberId);
	/*
	 * 管理员添加会员
	 */
	public int addCustomer(Customer customer);
	/*
	 * 管理员通过id查询会员
	 */
	public Customer selCustomerById(int id);
	/*
	 * 管理员通过id修改会员
	 */
	public int modifyCustomerById(Customer customer);
	/*
	 * 管理员通过id删除会员
	 */
	public int deleteCustomerById(int id);
	/*
	 * 退单回扣账号积分
	 */
	public int delIntegral(int customerId,int integral);
	/*
	 * 通过用户账号查询id
	 */
	public Customer selCustomer_ByUserCode(@Param("userCode")String userCode);
}