package lq.sc.service.member;

import java.util.List;

import lq.sc.pojo.Member;
/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：MemberService  
* 类描述： 会员机制业务层 
* 创建人：lhh  
* 创建时间：2018-11-6 下午9:51:39
* @version   
*   
 */
public interface MemberService {
	/*
	 * 查询所有会员类别
	 */
	public List<Member> getAllMember();
	/*
	 * 验证会员类别是否存在
	 */
	public boolean selMemberType(String memberType);
	/*
	 * 添加会员类别
	 */
	public boolean addMemberType(Member member);
	/*
	 * 根据id查询会员福利
	 */
	public Member selMemberById(int id);
	/*
	 * 根据id修改会员福利
	 */
	public boolean modifyMemberById(Member member);
	/*
	 * 根据id删除会员福利
	 */
	public boolean deleteMemberById(int id);
}
