package com.dy.traveller.places.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Likes {

	private String likesId;
	private String likesTitle;
	private String memberId;
	
	private List<LikesInfo> list; //has a 관계이므로
	
}
