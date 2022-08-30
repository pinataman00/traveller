package com.dy.traveller.places.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.dy.traveller.places.model.vo.Likes;
import com.dy.traveller.places.model.vo.LikesInfo;
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
		
		//System.out.println("잘 도착했니?");
		//System.out.println(map);

		List<Place> list = service.areaFilter(map);
		//System.out.println("결과 총 : "+list.size()+"개");
		return list;
		
	}
	
	@RequestMapping("/placeView/{id}")
	public ModelAndView getPlaceView(@PathVariable String id, ModelAndView mv) {
		
		//System.out.println("도착했니?");
		//System.out.println(id);
		
		mv.addObject("contentId", id);
		mv.setViewName("/place/placeView");
		
		return mv;
		
	}
	
	@RequestMapping("/placeDetail")
	@ResponseBody
	public Place getPlaceView(@RequestBody Map<String,Object> map) {
		
		System.out.println("장소 관련 정보 잘 도착했니?");
		
		System.out.println("확인 : "+map);
		Place p = service.selectPlace(map);
		
		System.out.println("/////////////////////////"+p);
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
		System.out.println("내가 선택한 테마 : //////////////////////////////////////"+proposal.getCat2());
		
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
	
	@RequestMapping("/loadLikesList.do")
	@ResponseBody
	public List<Likes> test3 (@RequestBody Map<String,String> data) {
		//System.out.println("잘 가져왔니?? : "+data.get("memberId"));
		String memberId = data.get("memberId");
		//System.out.println("아이디 확인 : "+memberId);
		List<Likes> list = service.getLikes(memberId);
		//System.out.println("리스트 확인 : "+list.size());
		
		//System.out.println("리스트에 저장된 요소 개수 : "+list.size());
		
		//존재한다면, 리스트 형태를 보내기
		return list;
	
	}
	
	
	  @RequestMapping("/addCat.do") 
	  @ResponseBody
	  public Likes addCat(@RequestBody Map<String,Object> param) {
	  
		  System.out.println("카테고리 추가하기 데이터 확인 : "+param);
		  //memberId, title
		  
		  //DB테이블에 해당 데이터를 추가한 이후, 화면에 반영해주는 순으로 로직 구현하기
		  //LIKES(개괄), LIKES_INFO(상세)
		 Likes res = service.insertLikes(param);
		  
		  if(res.getLikesId()!=null) { //LIKES테이블에 데이터 추가 성공 時
			  System.out.println("좋아요 목록 추가 성공!");
		  } else System.out.println("좋아요 목록 추가 실패!");
	  
		  return res;
		  
	  }
	  
	  @RequestMapping("/saveLikes.do")
	  @ResponseBody
	  public LikesInfo saveLikes(@RequestBody Map<String,String> param) {
		  
		  String contentId = param.get("contentId");
		  String likesId = param.get("likesId");
		  
		  //likesId의 value값이 basicLikes인 경우, 
		  //기본 좋아요 data가 존재할 경우는 해당 데이터의 LIKES_ID로 연결된 LIKES_INFO테이블에 저장
		  //TODO0830 기본 좋아요, 만들지 않음
			/*
			 * if(likesId.equals("basicLikes")) {
			 * 
			 * System.out.println("기본 좋아요에 장소 정보 저장하기"); int ck =
			 * service.selectBasic(likesId);
			 * 
			 * if(ck==0) { //기본 좋아요, 가 부재하는 경우 LIKES테이블에 데이터 추가하기
			 * 
			 * }
			 * 
			 * }
			 */
		  
		  
		  //부재하는 경우는, LIKES에 카테고리 추가 이후 LIKES_INFO테이블에 이어 저장할 것
		  //System.out.println("좋아요LIKES_INFO테이블에 추가할 것 : "+param);
		  
		  int res = service.insertLikesInfo(param);
		  
		  if(res>0) {
			
			  System.out.println("좋아요 추가 성공!!!");
	  
			  return LikesInfo.builder().contentId(contentId).likesId(likesId).build();
			  
		  } else {
			  System.out.println("좋아요 추가 실패!!!");
			  return new LikesInfo();
		  }
		  
	  }
	 
	
	  @RequestMapping("/searchHeart.do")
	  @ResponseBody
	  public List<String> searchHeart(@RequestBody Likes likes) {
		  
		  //System.out.println("하트 데이터 가져오기 : "+likes);
		  
		  List<Likes> res = service.selectLikes(likes);
		  //List<String> res = service.selectLikes(likes);
		  //System.out.println("데이터 가져왔니? "+res.size());
		  //System.out.println("가져온 데이터 보여줘 "+res);

		  List<String> list = new ArrayList();
		  
		  for (Likes l : res) {
			  for(LikesInfo info : l.getList()) {
				  //System.out.println("콘텐츠 아이디 확인 : "+info.getContentId());
				  list.add(info.getContentId()); //리스트에 콘텐츠 아이디 추가하기
			  }
		  }
		  
		  return list;
	  
	  }
	  
	  @RequestMapping("/deleteLikes.do")
	  @ResponseBody
	  public int deleteHeart(@RequestBody LikesInfo like) {
		  
		  //lcode 가져오기
		  //System.out.println("하트 데이터 가져오기 : "+like);
		  int res = service.deleteLike(like);
		  
		  if(res>0) {
			  System.out.println("삭제 성공!");
			  return res;
			  
		  } else {
			  System.out.println("삭제 실패!");
			  return res;
		  }
		  
		  //return res;
		  
	  }
	
	  @RequestMapping("/heartInfo.do")
	  @ResponseBody
	  public Map<String,String> heartInfo(@RequestBody Likes likes) {
		  
		  //0830) key는 고유한 값으로서 Map객체는 key를 중복으로 가져올 수 없음!
		  //-> LikesInfo의 FK(LIKES_ID) 아닌 PK(LCODE)를 key로 활용해야 함

		  List<Likes> res = service.selectLikes(likes);
		  
		  System.out.println("데이터 가져왔는가? "+res);
		  
		  Map<String,String> map = new HashMap();
		  
		  for (Likes like : res) {
			
			for(LikesInfo info : like.getList()) {
				//Map<String,String> map = Map.of("id",info.getLikesId(),"contentId",info.getContentId());
				map.put(info.getLcode(),info.getContentId());
			}
		  }
		  
		  
		  return map;
		  
	  }
	
}
