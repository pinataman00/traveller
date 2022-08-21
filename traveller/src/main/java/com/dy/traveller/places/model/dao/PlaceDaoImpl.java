package com.dy.traveller.places.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.dy.traveller.places.model.vo.Place;
import com.dy.traveller.places.model.vo.Proposal;
import com.dy.traveller.places.model.vo.Proposalimg;

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

	@Override
	public Place selectPlace(Map<String, Object> map, SqlSessionTemplate session) {
		
		return session.selectOne("place.selectPlace",map);
	}

	@Override
	public int insertProposal(SqlSessionTemplate session, Proposal proposal) {
		
		return session.insert("place.insertProposal",proposal);
	}

	@Override
	public int insertProposalImg(SqlSessionTemplate session, Proposalimg firstImg) {
		
		return session.insert("place.insertProposalImg", firstImg);
	}

	@Override
	public List<Proposal> selectProposalListPage(SqlSessionTemplate session, Map param) {
		
		int offSet = (int)param.get("cPage");
		int limit = (int)param.get("numPerPage");
		return session.selectList("place.selectProposalList",null,new RowBounds((offSet-1)*limit, limit));
	}

	@Override
	public int selectProposalCnt(SqlSessionTemplate session) {
		return session.selectOne("place.selectProposalCnt");
	}

	@Override
	public Proposal selectProposal(SqlSessionTemplate session,Proposal p) {
		return session.selectOne("place.selectProposal",p);
	}

	@Override
	public int deleteProposal(SqlSessionTemplate session, String proposalId) {
		return session.delete("place.deleteProposal",proposalId);
	}

}
