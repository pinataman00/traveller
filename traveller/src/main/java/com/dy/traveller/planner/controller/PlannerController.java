package com.dy.traveller.planner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/planner")
public class PlannerController {

	@RequestMapping("/startPlanner")
	public String startPlanner() {
		return "/planner/startPlanner";
	}
	
}
