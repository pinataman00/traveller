package com.dy.traveller.planner.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Friends {
	
	private String frinedsNo;
	private String crewId;
	private String memberId;

}
