package com.dy.traveller.planner.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Crew {

	private String crewId;
	//private Friends f
	private String crewTitle;
	private Date createdDate;
	private List<Friends> friends;
	
}
