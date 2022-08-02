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
public class Profileimg {

	private String imgNo;
	private String memberId;
	private String oriName;
	private String renamedFileName;
	private Date uploadDate;
	
}
