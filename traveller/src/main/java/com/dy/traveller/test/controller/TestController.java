package com.dy.traveller.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController { //API 테스트 컨트롤러
	
	@RequestMapping("/test/apiTest")
	public String page() {
		return "/test/apiTest";
	}

}
