package lq.sc.service.memberOrder;

import lq.sc.pojo.MemberOrder;
/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：MemberOrderService  
* 类描述： 会员卡订单业务层 
* 创建人：lhh  
* 创建时间：2018-11-19 上午9:30:07
* @version   
*   
 */
public interface MemberOrderService {
	/*
	 * 添加会员卡订单
	 */
	public boolean addMemberOrder(MemberOrder memberOrder);
	/*
	 * 通过用户id删除会员卡订单
	 */
	public boolean deleteMemberOrder_ById(int customerId);
	/*
	 * 订单销售总额
	 */
	public double memberBusiness();
	/*
	 * 开卡次数
	 */
	public int memberCount();
}
