package com.dy.traveller.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.member.model.vo.Member;
import com.dy.traveller.member.model.vo.Profileimg;

public interface MemberDao {

	public Member login(SqlSessionTemplate session, Member m);

	public int insertMember(SqlSessionTemplate session, Member m);

	public int insertProfileimg(SqlSessionTemplate session, Profileimg image);

	public int updatePwd(SqlSessionTemplate session, Member m);

	public int deleteMember(SqlSessionTemplate session, Member m);

	public int deletePic(SqlSessionTemplate session, Member m);

	public int updateMember(SqlSessionTemplate session, Member m);

	public int updateProfileimg(SqlSessionTemplate session, Profileimg image);

	public List<Member> selectMemberListPage(SqlSessionTemplate session, Map param);

	public int selectMemberCnt(SqlSessionTemplate session);

	public int updateGrade(SqlSessionTemplate session, Member m);

	public List<Member> selectPlanner(SqlSessionTemplate session);


	
}
