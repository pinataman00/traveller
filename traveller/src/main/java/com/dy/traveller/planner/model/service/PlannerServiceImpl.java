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
import com.dy.traveller.planner.model.vo.Plan;
import com.dy.traveller.planner.model.vo.Planner;

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
			res = dao.insertCrew(session,crew); 
			
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

	@Override
	public int insertPlanner(Planner planner) {

		//플래너 저장하기 : PLANNER > THUMBNAIL > PLAN 저장하기
		//THUMBNAIL, PLAN테이블 공통 : PLANNER의 PK인 PLANNER_NO를 FK로서 저장해야 함
		
		int res = 0;
		
		try {
			
			//System.out.println("여기까지 왔니?");
			//부모 테이블 > PLANNER에 기본 데이터 저장하기
			res = dao.insertPlanner(session, planner);
			//System.out.println("여기는 왔니?");
			//PLANNER > PK값 변수에 따로 저장하기!
			String plannerNo = planner.getPlannerNo();
			//System.out.println("방금 생성된 시퀀스 넘버 : "+plannerNo);
			
				//THUMBNAIL 썸네일 저장하기 -------------------------------------------------
				if(res>0&&planner.getImage()!=null) {
					
					//System.out.println("PLANNER는 저장 성공했어");
					
					//IMAGE에 SEQUENCE로써 갓 생성된 PLANNER의 PK값(=PLANNER_NO) 저장하기
					planner.getImage().setPlannerNo(plannerNo);
					
					res = dao.insertThumbnail(session, planner.getImage());
					if(res==0) throw new RuntimeException("썸네일 저장 실패!");
					
				}
				
				
				//PLAN 플랜 저장하기 --------------------------------------------------------
				if(res>0) {
					
					List<Plan[]> list = planner.getPlan();
					for(int i=0;i<list.size();i++) { //일자 만큼 순회하기
					//2차원 배열(실 내용은 객체 형태로 저장됨)이 저장된 List 순회 
						
						//(고정) 특정 일자의~ 방문 장소 만큼 순회하기
						for (Plan p : list.get(i)) {
							
							//1. PLANNER > PLANNER_NO를 FK로 저장하기
							p.setPlannerNo(plannerNo);
							//2. PLAN에 저장하기
							res = dao.insertPlan(session, p);
							if(res==0) throw new RuntimeException("플랜 저장 실패!");
						}
								
						
					}
				}

			
		} catch (RuntimeException e) { //3개 로직 중 하나라도 저장 실패 시...
			throw new RuntimeException("플래너 저장 실패!!!!!");
		}
		
		return res;
	}

	@Override
	public List<Planner> getPlanner(String memberId) {
		return dao.getPlanner(session, memberId);
	}

	@Override
	public List<Plan> getPlans(String plannerNo) {
		return dao.getPlans(session,plannerNo);
	}

}
