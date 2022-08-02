package com.dy.traveller.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dy.traveller.member.model.vo.Member;

@Controller
public class TravellerController {


	@RequestMapping("/")
	public String index() {
		return "index";
	}

	
}
