package com.dy.traveller.places.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.dy.traveller.places.model.vo.Likes;
import com.dy.traveller.places.model.vo.LikesInfo;
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

	int deleteProposal(SqlSessionTemplate session, String proposalId);

	int insertPlace(SqlSessionTemplate session, Place p);

	int updateApproval(SqlSessionTemplate session, String proposalId);

	List<Likes> getLikes(SqlSessionTemplate session, String memberId);

	int insertLikes(SqlSessionTemplate session, Map<String, Object> param);

	int insertLikesInfo(SqlSessionTemplate session, Map<String, String> param);

	List<Likes> selectLikes(SqlSessionTemplate session, Likes likes);

	int deleteLike(SqlSessionTemplate session, LikesInfo like);

	List<LikesInfo> savedHearts(SqlSessionTemplate session, LikesInfo like);

	List<Place> selectLikedPlace(SqlSessionTemplate session, LikesInfo like);

	List<Place> searchWithKeyword(SqlSessionTemplate session, Map<String, String> param);

}
