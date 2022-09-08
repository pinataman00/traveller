package com.dy.traveller.planner.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;
import com.dy.traveller.planner.model.vo.Plan;
import com.dy.traveller.planner.model.vo.Planner;
import com.dy.traveller.planner.model.vo.Thumbnail;

@Repository
public class PlannerDaoImpl implements PlannerDao {

	
	//클라이언트가 "CREW"지정 時, 테이블에 관련 정보 저장하기
	@Override
	public int insertCrew(SqlSessionTemplate session, Crew crew) {
		return session.insert("crew.insertCrew",crew);
	}

	@Override
	public int insertFriends(SqlSessionTemplate session, Friends f) {
		return session.insert("crew.insertFriends",f);
	}

	//플래너 저장 관련 메소드 3종 (PLANNER, THUMBNAIL, PLAN) ------------------------
	@Override
	public int insertPlanner(SqlSessionTemplate session, Planner planner) {
		
		return session.insert("planner.insertPlanner",planner);
	}

	@Override
	public int insertThumbnail(SqlSessionTemplate session, Thumbnail image) {
		
		return session.insert("planner.insertThumbnail",image);
	}

	@Override
	public int insertPlan(SqlSessionTemplate session, Plan plan) {
		
		return session.insert("planner.insertPlan",plan);
	}
	//-------------------------------------------------------------------------

	@Override
	public List<Planner> getPlanner(SqlSessionTemplate session, String memberId) {
		
		return session.selectList("planner.selectPlanner",memberId);
	}
}
