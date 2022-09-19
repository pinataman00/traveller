package com.dy.traveller.creator.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.creator.model.vo.Request;

public interface CreatorDao {

	int insertRequest(Request request, SqlSessionTemplate session);

}
