package lq.sc.service.member;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import lq.sc.dao.member.MemberMapper;
import lq.sc.pojo.Member;
@Service
public class MemberServiceImpl implements MemberService{
	@Resource
	private MemberMapper memberMapper;
	//查询所有会员类别
	public List<Member> getAllMember() {
		return memberMapper.getAllMember();
	}
	//验证会员类别是否存在
	public boolean selMemberType(String memberType) {
		if(memberMapper.selMemberType(memberType)>0){
			return true;
		}else{
			return false;
		}
	}
	//添加会员类别
	public boolean addMemberType(Member member) {
		if(memberMapper.addMemberType(member)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id查询会员类别
	public Member selMemberById(int id) {
		return memberMapper.selMemberById(id);
	}
	//根据id修改会员福利
	public boolean modifyMemberById(Member member) {
		if(memberMapper.modifyMemberById(member)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id删除会员福利
	public boolean deleteMemberById(int id) {
		if(memberMapper.deleteMemberById(id)>0){
			return true;
		}else{
			return false;
		}
	}

}
