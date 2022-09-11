package com.dy.traveller.planner.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Plan {

	private String planCode;
	private String plannerNo;
	private String day;
	private String latitude;
	private String longitude;
	private String memo;
	private String placeName;
	
	private String id; //방문 순서 식별하기 위해 만듦
	
	//TODO 0911
	private String address; //장소의 주소 정보도 있으면 좋음...
}
