package com.dy.traveller.places.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Proposalimg {

	private String proposalId; //FK
	private String imgNo; //PK
	private String oriName;
	private String renamedFileName;
	private Date uploadDate;
	
}
