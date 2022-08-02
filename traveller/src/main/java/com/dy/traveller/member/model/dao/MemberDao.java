package com.dy.traveller.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.member.model.vo.Member;
import com.dy.traveller.member.model.vo.Profileimg;

public interface MemberDao {

	public Member login(SqlSessionTemplate session, Member m);

	public int insertMember(SqlSessionTemplate session, Member m);

	public int insertProfileimg(SqlSessionTemplate session, Profileimg image);
	
}
