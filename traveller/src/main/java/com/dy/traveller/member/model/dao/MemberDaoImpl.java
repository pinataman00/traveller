package com.dy.traveller.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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



	@Override
	public int deletePic(SqlSessionTemplate session, Member m) {
		return session.delete("member.deleteProfileImg",m);
	}



	@Override //회원 수정 1) 일반 정보 수정
	public int updateMember(SqlSessionTemplate session, Member m) {
		return session.update("member.updateMember",m);
	}

	@Override //회원 수정 2) 프로필 사진 등록
	public int updateProfileimg(SqlSessionTemplate session, Profileimg image) {
		return session.update("member.updateProfileImg",image);
		
	}



	@Override //관리자 > 전체 회원 조회
	public List<Member> selectMemberListPage(SqlSessionTemplate session, Map param) {
		int offSet = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		return session.selectList("member.selelctMemberList",null,new RowBounds((offSet-1)*limit, limit));
	}



	@Override
	public int selectMemberCnt(SqlSessionTemplate session) {
		return session.selectOne("member.selectMemberCnt");
	}



	@Override
	public int updateGrade(SqlSessionTemplate session, Member m) {
		return session.update("member.updateGrade",m);
	}



	@Override
	public List<Member> selectPlanner(SqlSessionTemplate session) {
		return session.selectList("member.selectPlannerList");
	}





}
