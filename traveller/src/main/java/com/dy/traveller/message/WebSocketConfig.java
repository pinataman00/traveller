package com.dy.traveller.message;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

	private final MessageHandler messageHandler;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
		//※ setAllowedOrigins("*")를 붙이면, 도메인이 다른 서버에서도 접속할 수 있다고 함
		//EndPoint를 "/message"로 설정함
		registry.addHandler(messageHandler, "ws/message").setAllowedOrigins("*");
		
	}
	
	
	
}
