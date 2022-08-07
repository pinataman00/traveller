package com.dy.traveller.places.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dy.traveller.common.PageFactory;
import com.dy.traveller.member.model.service.MemberService;
import com.dy.traveller.member.model.vo.Member;
import com.dy.traveller.places.model.service.PlaceService;
import com.dy.traveller.places.model.vo.Place;
import com.google.gson.JsonIOException;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	@Autowired
	private PlaceService service;
	@Autowired
	private MemberService mservice;

	@RequestMapping("/placesMain")
	public String placeMain() { //메인화면 > 여행지 메인 화면으로 이동
		return "place/placeMain";
	}
	
	
	@RequestMapping("/test.do")
	@ResponseBody
	public Member test(String memberId, HttpServletResponse response) throws JsonIOException, IOException {
		
		System.out.println(memberId);
		System.out.println("원래 이런지");
		
		Member m = Member.builder().memberId(memberId).build();

		 System.out.println(mservice.login(m));
		return mservice.login(m);

	}
	
	@RequestMapping("/keywordSearch.do")
	@ResponseBody
	public List<Place> keywordSearch(String keyword){
		
		System.out.println(keyword);
		List<Place> list = service.keywordSearch(keyword);
		System.out.println(list);
		return list;
	}
	
	
	@RequestMapping("/searchList.do")
	public ModelAndView memberList(
								  String title, 
								  @RequestParam(value="cPage", defaultValue="1") int cPage,
			  					  @RequestParam(value="numPerPage", defaultValue="5") int numPerPage,
								  ModelAndView mv) 
	{ //전체 회원 조회 > 게시판 페이징 처리
		
		System.out.println(title);
		Map<String,Object> param = Map.of("keyword",title,"cPage",1,"numPerPage",5);
		List<Place> list = service.keywordSearchList(param);
		
		System.out.println("검색했니? "+list.size());
		
		int totalData = service.selectResultCnt(title);
		
		System.out.println("총 몇 개?"+totalData);
		
		mv.addObject("list",list);
		mv.addObject("totalData", totalData);
		mv.addObject("keyword",title);		
		mv.addObject("pageBar", PageFactory.getPageBar(totalData, numPerPage, cPage, "searchList.do"));
		mv.setViewName("place/placeMain");
	
		return mv;
	}

	
	
	
}
