package com.dy.traveller.places.model.service;

import java.util.List;
import java.util.Map;

import com.dy.traveller.places.model.vo.Place;

public interface PlaceService {

	List<Place> keywordSearch(String keyword);

	List<Place> keywordSearchList(Map param);

	int selectResultCnt(String keyword);

}
