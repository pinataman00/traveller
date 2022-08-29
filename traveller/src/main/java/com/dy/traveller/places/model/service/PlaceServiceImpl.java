package com.dy.traveller.places.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.traveller.places.model.dao.PlaceDao;
import com.dy.traveller.places.model.vo.Likes;
import com.dy.traveller.places.model.vo.LikesInfo;
import com.dy.traveller.places.model.vo.Place;
import com.dy.traveller.places.model.vo.Proposal;

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

	@Override
	public int insertProposal(Proposal proposal) { //제안 등록
		
		int res = 0;
		
		try {
			
			//先 PROPOSAL테이블 : 제안 기본 정보 저장
			res = dao.insertProposal(session,proposal);
			
			//後 PROPOSAL_IMG테이블 : 이미지 정보 저장하기
			if(res>0&&proposal.getFirstImg()!=null) {//등록 절차 성공 AND 대표 이미지 사진이 존재하는 경우
				
				System.out.println("여기는...?");
				//SEQUENCE, PROPOSAL_ID값 외래키로서 저장하기
				proposal.getFirstImg().setProposalId(proposal.getProposalId());
				//(Controller에서 저장한 원본명, 리네임드 파일명 정보 등이 포함되어 있으며)
				//현재 메소드의 로직으로 인해 PROPOSAL_ID값이 저장된 Proposal객체, proposal을 이용해 이미지 정보 저장하기
				res = dao.insertProposalImg(session, proposal.getFirstImg());
				if(res==0) throw new RuntimeException("장소 대표 이미지 등록 실패!");
			}
			
		} catch (RuntimeException e) {
			throw new RuntimeException("등록 실패!");		
		}
				
		return res;
	}

	@Override
	public List<Proposal> selectProposalListPage(Map param) {
		return dao.selectProposalListPage(session,param);
	}

	@Override
	public int selectProposalCnt() {
		return dao.selectProposalCnt(session);
	}

	@Override
	public Proposal selectProposal(Proposal p) {
		return dao.selectProposal(session,p);
	}

	@Override
	public int deleteProposal(String proposalId) {
		return dao.deleteProposal(session,proposalId);
	}

	@Override
	public int insertPlace(Place p) {
		return dao.insertPlace(session,p);
	}

	@Override
	public int updateApproval(String proposalId) {
		return dao.updateApproval(session,proposalId);
	}

	@Override
	public List<Likes> getLikes(String memberId) {
		return dao.getLikes(session,memberId);
	}

	@Override
	public Likes insertLikes(Map<String, Object> param) {
		
		int res = 0;
		res = dao.insertLikes(session,param);
		
		if (res>0) {
			
			System.out.println("방금 생성된 '좋아요' PK 아이디 : "+param.get("likesId"));			
			String id = (String)param.get("likesId");
			String title = (String)param.get("title");
			return Likes.builder().likesId(id).likesTitle(title).build();
			
		} else return Likes.builder().build();
			
	}

	@Override
	public int insertLikesInfo(Map<String, String> param) {
		return dao.insertLikesInfo(session,param);
	}

	@Override
	public List<Likes> selectLikes(Likes likes) {
		return dao.selectLikes(session,likes);
	}

}
