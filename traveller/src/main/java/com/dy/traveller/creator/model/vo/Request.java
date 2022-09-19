package com.dy.traveller.creator.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Request {

	private String requestNo;
	private String memberId;
	private String requestTitle;
	private String requestContents;
	private int travelDays;
	private Date writtenDate;
	private String theme;
	private int areacode;
	private int sigungucode;
	private String creatorId;
	
	//의뢰 승인-반려 여부
	private String approval;
	
	
}
