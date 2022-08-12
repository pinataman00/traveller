package com.dy.traveller.planner.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Thumbnail {

	private String imgNo;
	private String plannerNo;
	private String oriName;
	private String renamedFileName;
	private Date savedDate;
}
