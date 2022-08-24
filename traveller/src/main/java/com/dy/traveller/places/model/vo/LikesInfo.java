package com.dy.traveller.places.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LikesInfo {

	private String lcode;
	private String likesId;
	private String contentId;
	
}
