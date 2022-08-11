package com.dy.traveller.message;

import lombok.Data;

@Data
public class MessageRoom { //메시지 방 별로 구별하기 위해 만듦
	
	private int roomNum;
	private String roomName;

}
