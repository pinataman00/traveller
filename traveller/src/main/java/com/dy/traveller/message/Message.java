package com.dy.traveller.message;

import lombok.Data;

@Data
public class Message {

	private String type;
	private String sender;
	private String receiver;
	private String msg;
	private String room;
	
}
