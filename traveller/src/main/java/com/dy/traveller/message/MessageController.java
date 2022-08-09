package com.dy.traveller.message;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/message")
public class MessageController {

	@RequestMapping("/openMessageMain.do")
	public String openMessageMain() { //메시지 메인 화면으로 이동
		return "/message/messageMain";
	}
	
	@RequestMapping("/openMessage/{receiver}") //수신자 지정, 메시지 주고받기
	public ModelAndView getPlaceView(@PathVariable String receiver, ModelAndView mv) {

		mv.addObject("receiver", receiver);
		mv.setViewName("/message/openMessage");
		
		return mv;
		
	}

	
	
}
