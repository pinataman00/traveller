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
	public void requestPlan(Request request, Model model) {
		
		System.out.println("도착했니");
		System.out.println(request);
		
		int res = service.insertRequest(request);
		if(res>0) {
			System.out.println("저장 성공!");
		} else System.out.println("저장 실패!");
		
	}

	
	
}
