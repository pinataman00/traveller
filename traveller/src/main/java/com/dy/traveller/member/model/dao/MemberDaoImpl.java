package com.dy.traveller.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dy.traveller.member.model.vo.Member;
import com.dy.traveller.member.model.vo.Profileimg;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public Member login(SqlSessionTemplate session, Member m) {
		//return session.selectOne("member.login",m); //로그인
		return session.selectOne("member.selectMember",m); //로그인
	}



	@Override 
	public int insertMember(SqlSessionTemplate session, Member m) {
	
			return session.insert("member.insertMember",m); //회원가입 
	}



	@Override
	public int insertProfileimg(SqlSessionTemplate session, Profileimg image) {
		
		return session.insert("member.insertProfileImg",image);
	}



	@Override
	public int updatePwd(SqlSessionTemplate session, Member m) {
		
		return session.update("member.updatePwd", m); //비밀번호 수정
	}



	@Override
	public int deleteMember(SqlSessionTemplate session, Member m) {
		
		return session.delete("member.deleteMember",m);
	}
	

}
