package com.dy.traveller.planner.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;
import com.dy.traveller.planner.model.vo.Plan;
import com.dy.traveller.planner.model.vo.Planner;
import com.dy.traveller.planner.model.vo.Thumbnail;

public interface PlannerDao {

	int insertCrew(SqlSessionTemplate session, Crew crew);

	int insertFriends(SqlSessionTemplate session, Friends f);

	int insertPlanner(SqlSessionTemplate session, Planner planner);

	int insertThumbnail(SqlSessionTemplate session, Thumbnail image);

	int insertPlan(SqlSessionTemplate session, Plan p);

	List<Planner> getPlanner(SqlSessionTemplate session, String memberId);

	List<Plan> getPlans(SqlSessionTemplate session, String plannerNo);

	Planner selectPlanner(SqlSessionTemplate session, String plannerNo);

}
