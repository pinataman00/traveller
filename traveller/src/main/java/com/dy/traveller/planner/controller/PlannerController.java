package com.dy.traveller.planner.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dy.traveller.planner.model.service.PlannerService;
import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;
import com.dy.traveller.planner.model.vo.Planner;

@Controller
@RequestMapping("/planner")
public class PlannerController {
	
	@Autowired
	private PlannerService service;

	@RequestMapping("/startPlanner")
	public String startPlanner() {
		return "/planner/startPlanner";
	}
	
	@RequestMapping("/setting")
	public ModelAndView setting(Planner planner, Crew crew, @RequestParam(value="crewMember") String[]crewMember, ModelAndView mv) {

		System.out.println("될까? "+planner);
		System.out.println("될까? "+crew);

		if(crewMember[0].equals("fakeData")) { //크루가 없는 경우
			System.out.println("크루 입력 값이 존재하지 않습니다!");
			
			mv.addObject("tempPlanner", planner);
			//mv.addObject("tempCrew",crew);
			mv.setViewName("/planner/plannerEditor");
			
			return mv;
			
			
		} else { //crewMember 저장하기 -> (부모)Crew테이블에 저장하기 -> (자식)Friends에 저장하기 
			
			//클라이언트가 입력한 멤버들 list에 저장하기
			List<Friends> list = new ArrayList();
		    for(int i=0;i<crewMember.length;i++) { //입력했던 멤버들 전원 저장하기
		    	list.add(new Friends().builder().memberId(crewMember[i]).build());
		    }
		    
		    //클라이언트 본인도 멤버에 추가하기
		    list.add(new Friends().builder().memberId(planner.getMemberId()).build());
			System.out.println("멤버들 확인하기 : "+list);
			crew.setFriends(list);

			try {
				
				service.inputCrew(crew); //crew저장 성공 時
				mv.addObject("tempPlanner", planner);
				mv.addObject("tempCrew",crew);
				mv.setViewName("/planner/plannerEditor");
				
				return mv;
				
			} catch (RuntimeException e) {
				
				System.out.println("저장 실패!!!!!!");
				mv.setViewName("/"); //실패 시 메인화면으로 이동
				return mv;
			}
			
			
		}
		

//		mv.addObject("tempPlanner", planner);
//		mv.addObject("tempCrew",crew);
//		mv.setViewName("/planner/plannerEditor");
//		
//		return mv;
		
	}
	
	@RequestMapping("/basicSetting")
	@ResponseBody
	public ModelAndView basicSetting(@RequestBody Map<String,Object> map, ModelAndView mv) {

		
//		//System.out.println(map);
		String plannerTitle = String.valueOf(map.get("plannerTitle"));
		String theme = String.valueOf(map.get("theme"));
		String memberId = String.valueOf(map.get("memberId"));
		int areaCode = Integer.parseInt(String.valueOf(map.get("areaCode")));
		//String areaCode = String.valueOf(map.get("areaCode"));
		//String sigunguCode = String.valueOf(map.get("sigunguCode"));
		int sigunguCode = Integer.parseInt(String.valueOf(map.get("sigunguCode")));
		int travelDays = Integer.parseInt(String.valueOf(map.get("travelDays")));
		
		Planner p = new Planner().builder().memberId(memberId).plannerTitle(plannerTitle).travelDays(travelDays).theme(theme).areaCode(areaCode).sigunguCode(sigunguCode).build();
		System.out.println("//////////////"+p);
		mv.addObject("tempData", p);
		//return p;
		mv.setViewName("/");
		return mv;
		
	}
	
	@RequestMapping("/plannerEditor")
	public String plannerEditor() {
		return "/planner/plannerEditor";
	}
	
	
}
