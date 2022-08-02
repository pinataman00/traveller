package com.dy.traveller.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Member {

	private String memberId;
	private String email;
	private String memberPwd;
	private String phone;
	private Profileimg image;
	private String grade;
	private String introduce;
	private Date enrollDate;
	private int areaCode;
	private int sigunguCode;
	
}
