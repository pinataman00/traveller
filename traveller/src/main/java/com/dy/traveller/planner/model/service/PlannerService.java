package com.dy.traveller.planner.model.service;

import java.util.List;

import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;
import com.dy.traveller.planner.model.vo.Planner;

public interface PlannerService {

	int inputCrew(Crew c);

	int insertPlanner(Planner planner);

}
