package com.dy.traveller.planner.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Planner {

	private String plannerNo;
	private String memberId;
	private String plannerTitle;
	private int travelDays;
	private Date writtenDate;
	private String theme;
	private int areaCode;
	private int sigunguCode;
	private int score;
	
	private Plan[] plan; //planner에 속한 상세 plan들
	
	private String crewId; //그룹 아이디
	private String summary; //플래너 소개
	private Thumbnail imgage; //대표 이미지
	
}
