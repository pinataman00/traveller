package com.dy.traveller.planner.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;

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

}
