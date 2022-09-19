package com.dy.traveller.creator.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dy.traveller.creator.model.vo.Request;

@Repository
public class CreatorDaoImpl implements CreatorDao {

	@Override
	public int insertRequest(Request request, SqlSessionTemplate session) {
		return session.insert("creator.insertRequest", request);
		
	}

}
