package com.dy.traveller.message;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class MessageHandler extends TextWebSocketHandler {

	//Session 관리
	private List<WebSocketSession> clients = new ArrayList();
	
	@Override //클라이언트가 WebSocket Server에 접속 時, 실행될 메소드
	//※ 프론트의 WebSocket객체.onopen()실행 -> 본 메소드가 실행될 것임
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		clients.add(session);
		System.out.println("현재 접속자 수? : "+clients.size());
		sessionCheck();
	}
	
	public void sessionCheck() { //session 관리하기
		Iterator<WebSocketSession> sessions = clients.iterator();
		while(sessions.hasNext()) {
			WebSocketSession temp = sessions.next();
			if(!temp.isOpen()) sessions.remove();
		}
	}

	@Override
	//프론트) 클라이언트가 WebSocket객체.send()메소드로써 서버에 전송한 데이터를, 
	//본 method의 매개변수, TextMessage객체로 전달받아 데이터를 처리할 수 있음 
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//WebSocket서버 접속 클라이언트 관련 정보를 프론트로부터 "객체(名: Message)"형태로 받아왔음
		//-> ObjectMapper객체를 활용하면 (JS->JSON.stringify()로써 JSON문자열化된 데이터를...)Java객체로 변환 可
		ObjectMapper mapper = new ObjectMapper();
		Message msg = mapper.readValue(message.getPayload(), Message.class);
		
		System.out.println(msg);
		
		switch(msg.getType()) { //클라이언트의 type에 따라서 (※type은 이용 시점에 따라 분류됨)
			//case "access" : addClients(session,msg);break; //접속 時 실행
			case "access" : addClients(session,msg);break;
			case "msg" : sendMsg(msg);break; //메시지 발송 時 실행

		}
	
	}
	
	private void sendMsg(Message message) throws Exception{
		
		//WebSocket접속 클라이언트의 정보 中
		//receiver, room을 기준으로 메시지 발송 작업을 분기처리하여 수행할 수 있음!
		ObjectMapper mapper = new ObjectMapper();
		
		//JSON → Java객체化하기
		/*
		 * for(WebSocketSession client : clients) {
		 * 
		 * Message data = (Message)client.getAttributes().get("msg");
		 * System.out.println("확인///////////"+data); client.sendMessage(new
		 * TextMessage(mapper.writeValueAsString(message))); }
		 */
		System.out.println("접속자 수? "+clients.size());
		
		
		for(WebSocketSession client : clients) {

			
			//websocket객체.send()로 보낸 클라이언트를 앞서 WebsocketSession에 msg라는 key값으로 추가했음
			//따라서 해당 key값으로 value소환하기
			Message data=(Message)client.getAttributes().get("msg"); 

			
			System.out.println("///////////////"+data);
			
			if(!message.getReceiver().isEmpty()) { //수신자가 지정되어 있음 -> 1:1통신

				
			
			}
			
		}
		 
		
		//TODO ROOM 관련해서도 분기 처리 가능!
		
		
		
	}
	
	private void addClients(WebSocketSession session, Message message) {
		session.getAttributes().put("msg", message);
		clients.add(session);
		//sessionCheck();
	}
	
	

}
