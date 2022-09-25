package com.dy.traveller.creator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dy.traveller.creator.model.service.CreatorService;
import com.dy.traveller.creator.model.vo.Request;

@Controller
@RequestMapping("/creator")
public class CreatorController {
	
	@Autowired
	private CreatorService service;
	
	@RequestMapping("/requestPlan.do")
	public String requestPlan(Request request, Model model) {
		
		
		int res = service.insertRequest(request);
		
		String msg, loc = "";
		
		if(res>0) {
		
			msg = "의뢰 등록 완료! 검토 후 연락드리겠습니다 :)";
			loc = "/";
			
		} else {
			
			msg = "등록 실패! 다시 시도해주세요 :(";
			loc = "/creatorsBlog/"+request.getCreatorId(); //크리에이터 블로그로 이동
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("loc", loc);
		return "common/msg";
		
	}

	
	
}
