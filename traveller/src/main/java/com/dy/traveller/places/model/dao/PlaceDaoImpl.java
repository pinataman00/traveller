package com.dy.traveller.places.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dy.traveller.places.model.vo.Place;

@Repository
public class PlaceDaoImpl implements PlaceDao {

	@Override
	public List<Place> keywordSearch(String keyword, SqlSessionTemplate session) {
		
		return session.selectList("place.keywordSearch",keyword);
	}

	@Override
	public List<Place> keywordSearchList(Map param, SqlSessionTemplate session) {
		int offSet = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		String keyword = (String)param.get("keyword");
		
		return session.selectList("place.keywordSearchList",keyword,new RowBounds((offSet-1)*limit, limit));
	}

	@Override
	public int keywordResultCnt(String keyword, SqlSessionTemplate session) {
		
		return session.selectOne("place.keywordResultCnt",keyword);
	}

	@Override
	public List<Place> areaFilter(Map<String, Object> map, SqlSessionTemplate session) {
	
		return session.selectList("place.filterSearch",map);
	}

}
