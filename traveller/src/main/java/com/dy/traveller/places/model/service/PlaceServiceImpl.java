package com.dy.traveller.places.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.traveller.places.model.dao.PlaceDao;
import com.dy.traveller.places.model.vo.Place;

@Service
public class PlaceServiceImpl implements PlaceService {

	@Autowired
	private PlaceDao dao;
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Place> keywordSearch(String keyword) {
		
		return dao.keywordSearch(keyword,session);
	}

	@Override
	public List<Place> keywordSearchList(Map param) {
		return dao.keywordSearchList(param,session);
	}

	@Override
	public int selectResultCnt(String keyword) {
		return dao.keywordResultCnt(keyword,session);
	}

	@Override
	public List<Place> areaFilter(Map<String, Object> map) {
		return dao.areaFilter(map,session);
	}

	@Override
	public Place selectPlace(Map<String, Object> map) {
		return dao.selectPlace(map,session);
	}

}
