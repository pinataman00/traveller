package com.dy.traveller.creator.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.traveller.creator.model.dao.CreatorDao;
import com.dy.traveller.creator.model.vo.Request;

@Service
public class CreatorServiceImpl implements CreatorService {

	@Autowired
	private CreatorDao dao;
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertRequest(Request request) {
		return dao.insertRequest(request,session);
	}
	
}
