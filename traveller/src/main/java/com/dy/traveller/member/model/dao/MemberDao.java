package com.dy.traveller.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.member.model.vo.Member;

public interface MemberDao {

	public Member login(SqlSessionTemplate session, Member m);
	
}
