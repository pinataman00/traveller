package com.dy.traveller.places.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.places.model.vo.Place;

public interface PlaceDao {

	List<Place> keywordSearch(String keyword, SqlSessionTemplate session);

	List<Place> keywordSearchList(Map param, SqlSessionTemplate session);

	int keywordResultCnt(String keyword, SqlSessionTemplate session);

	List<Place> areaFilter(Map<String, Object> map, SqlSessionTemplate session);

}
