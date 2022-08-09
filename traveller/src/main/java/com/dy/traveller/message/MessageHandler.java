package com.dy.traveller.message;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class MessageHandler extends TextWebSocketHandler {

	
	
	@Override //클라이언트가 WebSocket Server에 접속 時, 실행될 메소드
	//※ 프론트의 WebSocket객체.onopen()실행 -> 본 메소드가 실행될 것임
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
	}

	@Override
	//프론트) 클라이언트가 WebSocket객체.send()메소드로써 서버에 전송한 데이터를, 
	//본 method의 매개변수, TextMessage객체로 전달받아 데이터를 처리할 수 있음 
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
	}

}
