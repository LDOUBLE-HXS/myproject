package lq.sc.dao.memberOrder;


import lq.sc.pojo.MemberOrder;


/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：MemberOrderMapper  
* 类描述：  会员卡订单接口
* 创建人：lhh  
* 创建时间：2018-11-19 上午9:16:41
* @version   
*   
 */
public interface MemberOrderMapper {
	/*
	 * 添加订单
	 */
	public int addMemberOrder(MemberOrder memberOrder);
	/*
	 * 通过用户id删除会员卡订单
	 */
	public int deleteMemberOrder_ById(int customerId);
	/*
	 * 订单销售总额
	 */
	public double memberBusiness();
	/*
	 * 开卡次数
	 */
	public int memberCount();
}
