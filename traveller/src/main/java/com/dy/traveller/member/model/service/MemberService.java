package com.dy.traveller.member.model.service;

import java.util.List;
import java.util.Map;

import com.dy.traveller.member.model.vo.Member;

public interface MemberService {

	Member login(Member m);

	int insertMember(Member m);

	int updatePwd(Member m);

	int deleteMember(Member member);

	int deletePic(Member memberInfo);

	int updateMember(Member m);

	List<Member> selectMemberListPage(Map param);

	int selectMemberCnt();

	
	
}
