package lq.sc.service.memberOrder;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import lq.sc.dao.memberOrder.MemberOrderMapper;
import lq.sc.pojo.MemberOrder;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：MemberOrderServiceImpl  
* 类描述： 会员卡订单业务实现层  
* 创建人：lhh  
* 创建时间：2019-6-19 上午9:30:27
* @version   
*   
 */
@Service
public class MemberOrderServiceImpl implements MemberOrderService{
	@Resource
	private MemberOrderMapper memberOrderMapper;
	//添加会员卡订单
	public boolean addMemberOrder(MemberOrder memberOrder) {
		if(memberOrderMapper.addMemberOrder(memberOrder)>0){
			return true;
		}else{
			return false;
		}
	}
	//通过用户id删除会员卡订单
	public boolean deleteMemberOrder_ById(int customerId) {
		if(memberOrderMapper.deleteMemberOrder_ById(customerId)>0){
			return true;
		}else{
			return false;
		}
	}
	//订单销售总额
	public double memberBusiness() {
		return memberOrderMapper.memberBusiness();
	}
	//开卡次数
	public int memberCount() {
		return memberOrderMapper.memberCount();
	}
}
