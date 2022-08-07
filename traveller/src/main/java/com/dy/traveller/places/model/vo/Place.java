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
	
	
}
