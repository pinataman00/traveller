package com.dy.traveller.places.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Proposal {

	private String memberId; //제안한 사람
	private String proposalId;
	private String title;
	private int areaCode;
	private int sigunguCode;
	private String address;
	private String cat2;	
	private String approval; //제안 승인-반려 여부
	private String mapx;
	private String mapy;
	private String info; //소개글
	private Date uploadDate;
	private Proposalimg firstImg; //사용자 등록 장소 대표 이미지
	
	
	
}
