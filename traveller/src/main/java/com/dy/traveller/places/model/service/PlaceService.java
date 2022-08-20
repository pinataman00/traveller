package com.dy.traveller.places.model.service;

import java.util.List;
import java.util.Map;

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

}
