package com.dy.traveller.planner.controller;


import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Planner;

@Controller
@RequestMapping("/planner")
public class PlannerController {

	@RequestMapping("/startPlanner")
	public String startPlanner() {
		return "/planner/startPlanner";
	}
	
	@RequestMapping("/setting")
	public ModelAndView setting(Planner p, Crew c, @RequestParam(value="crewMember") String[]crewMember, ModelAndView mv) {
	//public ModelAndView setting(Map<String,Object>param, ModelAndView mv) {
		System.out.println("될까? "+p);
		
		//if(c!=null)
		System.out.println("될까? "+c);
		//System.out.println(crewMember[0]);
		
		if(crewMember.length>0) {
			for(int i=0;i<crewMember.length;i++) {
				System.out.println(crewMember[i]);
			}
		}
		
		//쿠키로 넘겨보자...
		
		mv.addObject("tempPlanner", p);
		mv.addObject("tempCrew",c);
		mv.setViewName("/planner/plannerEditor");
		
		return mv;
		
		
		
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
		
		//return new Planner().builder().memberId(memberId).plannerTitle(plannerTitle).travelDays(travelDays).theme(theme).areaCode(areaCode).sigunguCode(sigunguCode).build();
		
//		String travelDays = (String.valueOf(map.get("travelDays")));
//		
//		System.out.println("테스트 : "+plannerTitle+" "+theme+" "+memberId+" "+areaCode+" "+sigunguCode+" "+travelDays);
//		
//		//cookie에 임시 저장하기  (사유 : 작성 취소할 수 있으므로)
//		//※ cookie에는 String형만 저장할 수 있음!
//		
//		  Cookie forOption = new Cookie("forOption",travelDays);
//		  forOption.setMaxAge(20*60*60); //Cookie, 하루 동안 유지하기
//		  response.addCookie(forOption);
//		  
//		  Cookie forTheme = new Cookie("forTheme",theme); forTheme.setMaxAge(20*60*60);
//		  response.addCookie(forTheme);
//		 
//		
//		//제목에 공백이 포함된 경우, 이스케이프 처리하기
//		
//		  String temp = plannerTitle; 
//		  String title = ""; 
//		  if(temp.contains(" ")) { 
//			  title = temp.replace(" ", "_"); 
//		  } else { title = temp; }
//		 
//		System.out.println("플래너 제목 (이스케이프 처리 확인하기) : "+title); 
//		Cookie forTitle = new Cookie("forTitle",title);
//		forTitle.setMaxAge(24*60*60);
//		response.addCookie(forTitle);
//		
//		//클라이언트 정의 "주요 방문 지역" 정보
//		//1. areaCode (대분류)
//		
//		  Cookie forArea = new Cookie("forArea",areaCode); forArea.setMaxAge(20*60*60);
//		  response.addCookie(forArea); 
//		  //2. sigunguCode (소분류) 
//		  Cookie forSigungu = new Cookie("forSigungu",sigunguCode); 
//		  forSigungu.setMaxAge(20*60*60);
//		  response.addCookie(forSigungu);
//		  
//		  //return "redirect:/";
//		  //response.sendRedirect(request.getContextPath()+"/planner/plannerEditor");
//		  return "redirect:/";
	}
	
	@RequestMapping("/plannerEditor")
	public String plannerEditor() {
		return "/planner/plannerEditor";
	}
	
	
}
