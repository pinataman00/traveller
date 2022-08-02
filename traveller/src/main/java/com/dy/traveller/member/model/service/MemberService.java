package com.dy.traveller.member.model.service;

import com.dy.traveller.member.model.vo.Member;

public interface MemberService {

	Member login(Member m);

	int insertMember(Member m);

	
	
}
