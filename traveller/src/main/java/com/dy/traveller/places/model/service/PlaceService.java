package com.dy.traveller.places.model.service;

import java.util.List;
import java.util.Map;

import com.dy.traveller.places.model.vo.Likes;
import com.dy.traveller.places.model.vo.LikesInfo;
import com.dy.traveller.places.model.vo.Place;
import com.dy.traveller.places.model.vo.Proposal;

public interface PlaceService {

	List<Place> keywordSearch(String keyword);

	List<Place> keywordSearchList(Map param);

	int selectResultCnt(String keyword);

	List<Place> areaFilter(Map<String, Object> map);

	Place selectPlace(Map<String, Object> map);

	int insertProposal(Proposal proposal);

	List<Proposal> selectProposalListPage(Map param);

	int selectProposalCnt();

	Proposal selectProposal(Proposal build);

	int deleteProposal(String proposalId);

	int insertPlace(Place build);

	int updateApproval(String proposalId);

	List<Likes> getLikes(String memberId);

	Likes insertLikes(Map<String, Object> param);

	int insertLikesInfo(Map<String, String> param);

	List<Likes> selectLikes(Likes likes);

	int deleteLike(LikesInfo like);

	List<LikesInfo> savedHearts(LikesInfo likes);

	List<Place> selectLikedPlace(LikesInfo like);

}
