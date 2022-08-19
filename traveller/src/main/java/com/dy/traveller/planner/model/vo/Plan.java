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
}
