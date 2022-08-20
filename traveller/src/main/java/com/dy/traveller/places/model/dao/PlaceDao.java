package com.dy.traveller.places.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.places.model.vo.Place;
import com.dy.traveller.places.model.vo.Proposal;
import com.dy.traveller.places.model.vo.Proposalimg;

public interface PlaceDao {

	List<Place> keywordSearch(String keyword, SqlSessionTemplate session);

	List<Place> keywordSearchList(Map param, SqlSessionTemplate session);

	int keywordResultCnt(String keyword, SqlSessionTemplate session);

	List<Place> areaFilter(Map<String, Object> map, SqlSessionTemplate session);

	Place selectPlace(Map<String, Object> map, SqlSessionTemplate session);

	int insertProposal(SqlSessionTemplate session, Proposal proposal);

	int insertProposalImg(SqlSessionTemplate session, Proposalimg firstImg);

	List<Proposal> selectProposalListPage(SqlSessionTemplate session, Map param);

	int selectProposalCnt(SqlSessionTemplate session);

	Proposal selectProposal(SqlSessionTemplate session, Proposal p);

}
