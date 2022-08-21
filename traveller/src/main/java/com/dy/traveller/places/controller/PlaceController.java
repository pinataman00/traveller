package com.dy.traveller.places.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dy.traveller.common.PageFactory;
import com.dy.traveller.member.model.service.MemberService;
import com.dy.traveller.member.model.vo.Member;
import com.dy.traveller.places.model.service.PlaceService;
import com.dy.traveller.places.model.vo.Place;
import com.dy.traveller.places.model.vo.Proposal;
import com.dy.traveller.places.model.vo.Proposalimg;
import com.google.gson.JsonIOException;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	@Autowired
	private PlaceService service;
	@Autowired
	private MemberService mservice;

	@RequestMapping("/placesMain")
	public String placeMain() { //메인화면 > 여행지 메인 화면으로 이동
		return "place/placeMain";
	}
	
	
	@RequestMapping("/test.do")
	@ResponseBody
	public Member test(String memberId, HttpServletResponse response) throws JsonIOException, IOException {
		
		System.out.println(memberId);
		System.out.println("원래 이런지");
		
		Member m = Member.builder().memberId(memberId).build();

		 System.out.println(mservice.login(m));
		return mservice.login(m);

	}
	
	@RequestMapping("/keywordSearch.do")
	@ResponseBody
	public List<Place> keywordSearch(String keyword){
		
		System.out.println(keyword);
		List<Place> list = service.keywordSearch(keyword);
		System.out.println(list);
		return list;
	}
	
	
	@RequestMapping("/searchList.do")
	public ModelAndView memberList(
								  String title, 
								  @RequestParam(value="cPage", defaultValue="1") int cPage,
			  					  @RequestParam(value="numPerPage", defaultValue="5") int numPerPage,
								  ModelAndView mv) 
	{ //전체 회원 조회 > 게시판 페이징 처리
		
		System.out.println(title);
		Map<String,Object> param = Map.of("keyword",title,"cPage",1,"numPerPage",5);
		List<Place> list = service.keywordSearchList(param);
		
		System.out.println("검색했니? "+list.size());
		
		int totalData = service.selectResultCnt(title);
		
		System.out.println("총 몇 개?"+totalData);
		
		mv.addObject("list",list);
		mv.addObject("totalData", totalData);
		mv.addObject("keyword",title);		
		mv.addObject("pageBar", PageFactory.getPageBar(totalData, numPerPage, cPage, "searchList.do"));
		mv.setViewName("place/placeMain");
	
		return mv;
	}

	@RequestMapping("/searchFilter.do")
	@ResponseBody
	public List<Place> searchFilter(@RequestBody Map<String,Object> map){
		
		System.out.println("잘 도착했니?");
		System.out.println(map);

		List<Place> list = service.areaFilter(map);
		System.out.println("결과 총 : "+list.size()+"개");
		return list;
		
	}
	
	@RequestMapping("/placeView/{id}")
	public ModelAndView getPlaceView(@PathVariable String id, ModelAndView mv) {
		
		System.out.println("도착했니?");
		System.out.println(id);
		
		mv.addObject("contentId", id);
		mv.setViewName("/place/placeView");
		
		return mv;
		
	}
	
	@RequestMapping("/placeDetail")
	@ResponseBody
	public Place getPlaceView(@RequestBody Map<String,Object> map) {
		
		System.out.println("장소 관련 정보 잘 도착했니?");
		System.out.println(map);
		Place p = service.selectPlace(map);
		return p;
		
	}
	
	@RequestMapping("/propose")
	public String proposeView() {
		return "/place/placePropose";
	}
	
	@RequestMapping("/placeProposal")
	public String proposal(Proposal proposal, Model model, MultipartFile img, HttpServletRequest rs) {
		
		//● 로직 순서
		//1. PROPOSAL테이블에 제안 정보 저장하기
		//-> 실패 시 ROLLBACK 처리
		//2. (PROPOSAL테이블에 데이터 INSERT시 생성된 SEQUENCE 전달) PROPOSAL_IMG테이블에 대표 이미지 관련 정보 저장하기
		//-> 테이블 간 관계 : PROPOSAL_IMG테이블은, PROPOSAL테이블에 종속됨
		//-> PROPOSAL테이블의 PK, PROPOSAL_ID는 PROPOSAL_IMG의 FK임
		
		System.out.println("제안 관련 기본 정보 : "+proposal);
		
		//0. 대표 이미지 관련 =============================================================================
		System.out.println("파일 이름 : "+img.getOriginalFilename());
		System.out.println("파일 크기 : "+img.getSize());
		
		//첨부파일 저장 경로 설정하기
		String path = rs.getServletContext().getRealPath("/resources/place/proposal/");
		File uploadDir = new File(path);
		// 폴더가 없는 경우에는 생성하기
		if (!uploadDir.exists())
			uploadDir.mkdirs();
		
		//파일 리네임 및 서버 업로드
		  if(!img.isEmpty()) { //만약, 파일을 업로드했다면 //리네임 처리!
			  
			  String oriName = img.getOriginalFilename(); //원본 파일명 가져오기 
			  String ext = oriName.substring(oriName.lastIndexOf(".")); //파일명으로부터 확장자 추출 //리네임 작명 규칙 설정
			  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS"); 
			  int rndNum = (int)(Math.random()*10000); 
			  String rename = sdf.format(System.currentTimeMillis())+"_"+rndNum+ext;
			  
			  //서버 업로드 처리하기 
				try {
					
					img.transferTo(new File(path+rename));
					Proposalimg proposalImg = Proposalimg.builder().oriName(oriName).renamedFileName(rename).build();
					proposal.setFirstImg(proposalImg);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
		  }
		  
		  //DB에 이미지 파일 저장하기
		  
		  String msg,loc="";
		  
		  
		  try {
		  
			  service.insertProposal(proposal);
			  msg="감사합니다! 관리자 검토 후 연락드리겠습니다";
			  loc="/";

		  } catch (RuntimeException e) {
			  msg="등록 실패. 다시 시도해주세요.";
			  loc="/place/propose";

			  if(!img.isEmpty()) {
				  File deleteFile = new File(path+proposal.getFirstImg().getRenamedFileName());
				  if(deleteFile.exists()) {
					  deleteFile.delete();
				  }
			  }

		  }
	  
	  
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		  
		return "common/msg";
	
	}
	
	@RequestMapping("/proposalList.do") //페이징 처리할 것
	public ModelAndView proposalList(@RequestParam(value="cPage", defaultValue="1") int cPage,
							  @RequestParam(value="numPerPage", defaultValue="5") int numPerPage,
							  ModelAndView mv) {
		
		//전체 제안 조회 > 게시판 페이징 처리
		
		Map param = Map.of("cPage",cPage,"numPerPage",numPerPage);
		List<Proposal> list = service.selectProposalListPage(param);
		//System.out.println("제안 검색했어? "+list.size());
		
		int totalProposal = service.selectProposalCnt();
		mv.addObject("list",list);
		mv.addObject("totalProposal",totalProposal);
		mv.addObject("pageBar",PageFactory.getPageBar(totalProposal, numPerPage, cPage, "proposalList.do"));
		mv.setViewName("place/proposalList");
		
		return mv;
	}
	
	//proposal 내용 상세 보기 페이지로 이동
	@RequestMapping("/proposalView/{id}")
	public String getProposalView (@PathVariable String id, Model m) {
		m.addAttribute("proposalId",id);
		
		return "place/printProposal";
	}
	
	//proposal 내용 출력하기
	@RequestMapping("/printProposal/{proposalId}")
	@ResponseBody
	public Proposal getProposal (@PathVariable String proposalId) {
		Proposal p = service.selectProposal(Proposal.builder().proposalId(proposalId).build());
		return p;
	}
	
	//proposal 삭제하기
	@RequestMapping("/deleteProposal.do")
	public String deleteProposal(String proposalId, Model m, HttpServletRequest rs) { //사진이 존재할 경우, 사진까지 삭제하기
		
		
		  Proposal p = service.selectProposal(Proposal.builder().proposalId(proposalId).build());		
		  int res = service.deleteProposal(proposalId);
		  System.out.println("사진 정보 확인 : "+p.getFirstImg().getRenamedFileName());
		  String msg= "";
		  
		  if(res>0) {
			  msg="제안 삭제 완료";
			  //"/resources/place/proposal/"
			  //대표 이미지가 첨부된 제안인 경우, 사진 삭제하기
			  String path = rs.getServletContext().getRealPath("/resources/place/proposal/");
			  File deleteImg = new File(path+p.getFirstImg().getRenamedFileName());
			  if(deleteImg.exists()) {
				  deleteImg.delete();
			  }
		  } else {
			  msg = "제안 삭제 실패. 다시 시도해주세요";
		  }
		  
		  m.addAttribute("msg",msg);
		  m.addAttribute("loc","/place/proposalList.do");
		  
		  return "common/msg";
		 
		
	}
	
	@RequestMapping("/test2.do")
	public String test2(Place p, Model m, String proposalId) {
		
		System.out.println("잘 받아왔니? "+p);

		System.out.println("제안 ID : "+proposalId);
		
		
		
		  int res = service.insertPlace(p);
		  
		  String msg,loc = "";
		  
		  if(res>0) {
		  
		  //proposal의 approval값 'N'에서 'Y'로 변경하기 res =
		  service.updateApproval(proposalId); if(res>0) { msg= "등록 성공! 메인화면으로 이동합니다";
		  loc= "/"; } else { msg = "등록에 실패했습니다! 다시 시도해주세요"; loc = "/"; }
		  
		  
		  } else {
		  
		  msg= "등록 실패! 다시 시도해주세요!"; loc = "place/proposalList.do"; }
		  m.addAttribute("msg",msg); m.addAttribute("loc",loc);
		  
		  return "common/msg";
		 
		 
		
		
	}
	
	
}
