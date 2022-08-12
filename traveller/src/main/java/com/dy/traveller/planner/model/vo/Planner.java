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
	
	private Thumbnail img; //대표 이미지
	
}
