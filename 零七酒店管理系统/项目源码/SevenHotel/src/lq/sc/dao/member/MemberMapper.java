package lq.sc.dao.member;

import java.util.List;

import org.springframework.stereotype.Service;

import lq.sc.pojo.Member;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：MemberMapper  
* 类描述：会员机制mapper接口  
* 创建人：lhh  
* 创建时间：2018-11-6 下午9:46:59
* @version   
*   
 */
@Service
public interface MemberMapper {
	/*
	 * 查询所有会员类别
	 */
	public List<Member> getAllMember();
	/*
	 * 验证会员类别是否存在
	 */
	public int selMemberType(String memberType);
	/*
	 * 添加会员类别
	 */
	public int addMemberType(Member member);
	/*
	 * 根据id查询会员福利
	 */
	public Member selMemberById(int id);
	/*
	 * 根据id修改会员福利
	 */
	public int modifyMemberById(Member member);
	/*
	 * 根据id删除会员福利
	 */
	public int deleteMemberById(int id);
}
