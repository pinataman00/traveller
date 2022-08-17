package com.dy.traveller.member.model.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
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
