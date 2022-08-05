package com.dy.traveller.places.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dy.traveller.places.model.service.PlaceService;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	@Autowired
	private PlaceService service;

	@RequestMapping("/placesMain")
	public String placeMain() { //메인화면 > 여행지 메인 화면으로 이동
		return "place/placeMain";
	}
	
	
	
	
}
