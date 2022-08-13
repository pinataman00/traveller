package com.dy.traveller.planner.model.service;

import java.util.Iterator;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.traveller.planner.model.dao.PlannerDao;
import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;

@Service
public class PlannerServiceImpl implements PlannerService {

	@Autowired
	private PlannerDao dao;
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int inputCrew(Crew crew) throws RuntimeException {
		
		System.out.println("여기까지 오기는 하니...");
		int res = 0;
		
		try {
			
			//先 CREW테이블 : CREW 관련 총체적인 정보 저장 
			res = dao.insertCrew(session,crew); //selectkey가 안 되네 왤까?
			/*
			 * System.out.println("여기는 올 수 있어?");
			 * System.out.println("갓 생성된 Crew테이블의 시퀀스 넘버 확인하기 "+crew.getCrewId());
			 */
			
			if(res>0) {
				//list에 저장된 멤버들을 하나씩 Friends테이블에 저장하기
				//외래키, crew_id 가져가기!
				for(Friends f : crew.getFriends()) {
					f.setCrewId(crew.getCrewId()); //CREW의 PK를, FRIENDS의 FK로 저장하기
					res = dao.insertFriends(session,f);
					if(res==0) throw new RuntimeException("FRIENDS 저장 실패");
				}
				
			}
			
		} catch (RuntimeException e) { //後 FRIENDS테이블 : CREW에 소속된 MEMBER 저장
			throw new RuntimeException("CREW 저장 실패");
		}
		
		return res;
		
	}

}
