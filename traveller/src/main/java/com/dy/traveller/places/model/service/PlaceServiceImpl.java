package com.dy.traveller.places.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dy.traveller.places.model.dao.PlaceDao;
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
			System.out.println("여기는 와?");
			//先 PROPOSAL테이블 : 제안 기본 정보 저장
			res = dao.insertProposal(session,proposal);
			System.out.println("여기는 돼?");
			
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

}
