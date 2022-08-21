package com.dy.traveller.places.model.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Place {

	private String contentId;
	private String contentTypeId;
	private String title;
	private int areacode;
	private int sigungucode;
	private String address;
	private String cat1;
	private String cat2;
	private String cat3;
	private String firstImage;
	private String mapx;
	private String mapy;
	
	//사용자 제안 장소 추가
	private String proposalId; //기본 값: N (사용자가 제안한 장소로서 등록된 경우는 Y로 표기)
	private String info;
}
