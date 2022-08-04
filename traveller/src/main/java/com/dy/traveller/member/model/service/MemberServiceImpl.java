package com.dy.traveller.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.traveller.member.model.dao.MemberDao;
import com.dy.traveller.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao dao;
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public Member login(Member m) {
		return dao.login(session, m);
	}

	
	@Override
	public int insertMember(Member m) { //회원가입
		
		int res = 0;
		
		try {
			//先 MEMBER테이블 : 회원 기본 정보 저장
			res = dao.insertMember(session, m);
			
			//後 PROFILEIMG테이블 : 회원 프로필 사진 저장
			if(res>0&&m.getImage()!=null) { //회원 가입 절차 성공 AND 프로필 사진이 존재하는 경우
				
				//MEMBER_ID값 저장하기
				m.getImage().setMemberId(m.getMemberId());
				res = dao.insertProfileimg(session, m.getImage());
				if(res==0) throw new RuntimeException("프로필 사진 저장 실패!");
			}
			
		} catch (RuntimeException e) {
			throw new RuntimeException("가입 실패!");
		}
		
		return res;
	}

	@Override
	public int updatePwd(Member m) {
		
		return dao.updatePwd(session,m);
	}

	@Override
	public int deleteMember(Member m) {
		
		return dao.deleteMember(session,m);
	}


	@Override
	public int deletePic(Member m) {
		
		//PROFILEIMG테이블에서 ROW 삭제하기
		return dao.deletePic(session, m);
	}

}
