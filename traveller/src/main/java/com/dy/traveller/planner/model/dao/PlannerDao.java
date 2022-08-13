package com.dy.traveller.planner.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;

public interface PlannerDao {

	int insertCrew(SqlSessionTemplate session, Crew crew);

	int insertFriends(SqlSessionTemplate session, Friends f);

}
