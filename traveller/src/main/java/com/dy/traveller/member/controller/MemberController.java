package com.dy.traveller.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dy.traveller.common.PageFactory;
import com.dy.traveller.member.model.service.MemberService;
import com.dy.traveller.member.model.vo.Member;
import com.dy.traveller.member.model.vo.Profileimg;

@Controller
@RequestMapping("/member")
@SessionAttributes({ "loginMember" })
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private BCryptPasswordEncoder pwEncoder; // 단방향 암호화 관련 encoder

	@RequestMapping("/memberLogin.do")
	public String memberLogin(Member m, Model model) {

		Member loginMember = service.login(m); // 1. 클라이언트 입력 아이디-DB 아이디 대조

		//DB에서 loginMember객체를 가져오니까, images는 못 가져올 수밖에...
		System.out.println("로그인 멤버 확인 "+loginMember);

		String viewName = "redirect:/";

		if (loginMember != null && pwEncoder.matches(m.getMemberPwd(),
		 loginMember.getMemberPwd())) {

			System.out.println("클라이언트 입력 값 : " + m.getMemberPwd());
			System.out.println("DB에 저장된 값 : " + loginMember.getMemberPwd());

			model.addAttribute("loginMember", loginMember);

		} else {

			model.addAttribute("msg", "로그인 실패!");
			model.addAttribute("loc", "/"); // 메인화면으로
			viewName = "common/msg"; // msg.jsp파일 -> alert창 띄우기

		}

		return viewName; // 로그인 성패 따라 다른 화면 출력

	}

	@RequestMapping("logout.do")
	public String logout(SessionStatus status) {
		if (!status.isComplete()) {
			status.setComplete();
		}
		return "redirect:/";
	}

	@RequestMapping("enrollMember.do")
	public String enrollMember() {
		return "member/enrollMember";
	}

	// 아이디 중복 체크
	@RequestMapping("checkMemberId.do")
	@ResponseBody
	public String checkId(String memberId, ModelAndView mv) {

		Member m = service.login(Member.builder().memberId(memberId).build());
		if (m != null) {
			return "true";
		} else
			return "false";

	}

	// 회원 가입
	@RequestMapping("/enrollMemberEnd.do")
	public String enrollMemberEnd(Member m, Model model, MultipartFile img, HttpServletRequest rs) {

		
		//로직 순서
		//1. MEMBER테이블에 회원 정보 저장하기
		//-> MEMBER테이블에 실패 시, ROLLBACK처리하기
		//2. (클라이언트가 입력한 MEMBER_ID 전달하기) PROFILEIMG테이블에 회원 프로필 사진 저장하기
		//테이블 간 관계 : 프로필 사진 관련 PROFILEIMG테이블은 회원 관련 TABLE, 'MEMBER'에 종속됨
		//-> MEMBER의 PK, 'MEMBER_ID'는 PROFILEIMG의 FK임
		
		//1. MEMBER테이블에 회원 정보 저장하기 (+ '단방향 암호화'작업)
		m.setMemberPwd(pwEncoder.encode(m.getMemberPwd())); //BcryptPasswordEncoder로 암호화하기

			
			//2. 프로필 사진(PROFILEIMG) 저장 관련
			
			// 프로필 사진 관련
			System.out.println("파일 이름 :" + img.getOriginalFilename());
			System.out.println("파일 크기 : " + img.getSize());
	
			// 첨부파일 저장 경로 설정하기
			String path = rs.getServletContext().getRealPath("/resources/member/profile/");
			File uploadDir = new File(path);
			// 폴더가 없는 경우에는 생성하기
			if (!uploadDir.exists())
				uploadDir.mkdirs();
	
			// 파일 리네임 처리 및 서버 업로드
			
			//Profileimg proImg = new Profileimg();
			
			  if(!img.isEmpty()) { //만약, 파일을 업로드했다면 //리네임 처리!
				  
				  String oriName = img.getOriginalFilename(); //원본 파일명 가져오기 
				  String ext = oriName.substring(oriName.lastIndexOf(".")); //파일명으로부터 확장자 추출 //리네임 작명 규칙 설정
				  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS"); 
				  int rndNum = (int)(Math.random()*10000); 
				  String rename = sdf.format(System.currentTimeMillis())+"_"+rndNum+ext;
				  
				  //서버 업로드 처리하기 
					try {
						
						img.transferTo(new File(path+rename));
						Profileimg proImg = Profileimg.builder().memberId(m.getMemberId()).oriName(oriName).renamedFileName(rename).build();
						m.setImage(proImg);
						
					} catch (IOException e) {
						e.printStackTrace();
					}
			  }

			  
			  //DB에 이미지 파일 저장하기
			  
			  String msg,loc="";
			  
			  
			  try {
			  
				  service.insertMember(m);
				  msg="회원 가입 성공! 로그인 해주세요!";
				  loc="/";

			  } catch (RuntimeException e) {
				  msg="회원 가입 실패. 다시 시도해주세요.";
				  loc="/member/enrollMember.do";

				  if(!img.isEmpty()) {
					  File deleteFile = new File(path+m.getImage().getRenamedFileName());
					  if(deleteFile.exists()) {
						  deleteFile.delete();
					  }
				  }

			  }
		  
		  
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		  
		return "common/msg";
	}
	
	@RequestMapping("/myInfo.do")
	public String myInfo() {
		return "member/myInfo";
	}
	
	//회원 정보 수정 > 전반적인 정보 수정
	@RequestMapping("/updateInfo.do")
	public String updateInfo(Member m, Model model, MultipartFile img, HttpServletRequest rs) {
		
		
			System.out.println("수정 정보 일체 "+m);			
			Member loginMember = service.login(m);
			//프로필 사진(PROFILEIMG) 저장 관련
			
			
			System.out.println("기존 : "+loginMember.getPhone());
			System.out.println("새로운 정보 : "+m.getPhone());
			System.out.println("수정 정보 일체 "+m);
			
			// 프로필 사진 관련
			System.out.println("파일 이름 :" + img.getOriginalFilename());
			System.out.println("파일 크기 : " + img.getSize());
	
			// 첨부파일 저장 경로 설정하기
			String path = rs.getServletContext().getRealPath("/resources/member/profile/");
			File uploadDir = new File(path);
			// 폴더가 없는 경우에는 생성하기
			if (!uploadDir.exists())
				uploadDir.mkdirs();
	
			
			String msg,loc=""; //클라이언트 대상 안내문, 경로 정보 설정하기
			
			// 파일 리네임 처리 및 서버 업로드
			
			  if(!img.isEmpty()) { //만약, 파일을 업로드했다면~ 
			  //기존 파일 존재 여부에 따라 UPDATE||INSERT 선택하기
			  //파일 리네임 처리하기
				  
				  
				  //기존 프로필 파일은 삭제하기
				  if(loginMember.getImage()!=null) {
					  
					  File deleteFile = new File(path+loginMember.getImage().getRenamedFileName());
					  if(deleteFile.exists()) {
						  deleteFile.delete();
						  
						  //테이블, PROFILEIMG에서 데이터 삭제하기
						  try {
							  service.deletePic(loginMember);
							  
						  } catch (RuntimeException e) {
							  msg = "프로필 사진 수정 실패! 다시 시도해주세요";
							  loc = "/member/myInfo.do";
						  }
						  
					  }
				  }
				  
				  //새로 업로드한 파일 등록하기
				  String oriName = img.getOriginalFilename(); //원본 파일명 가져오기 
				  String ext = oriName.substring(oriName.lastIndexOf(".")); //파일명으로부터 확장자 추출 //리네임 작명 규칙 설정
				  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS"); 
				  int rndNum = (int)(Math.random()*10000); 
				  String rename = sdf.format(System.currentTimeMillis())+"_"+rndNum+ext;
				  
				  //서버 업로드 처리하기 
					try {			
						img.transferTo(new File(path+rename));
						Profileimg proImg = Profileimg.builder().memberId(m.getMemberId()).oriName(oriName).renamedFileName(rename).build();
						m.setImage(proImg);
						System.out.println("이미지 객체 생성했다 "+m.getImage());
						
					} catch (IOException e) {
						e.printStackTrace();
					}
			  }
			  
			  //DB에 이미지 파일 저장하기
			  
			  
			  			  
			  try {
			  
				  service.updateMember(m);
				  msg="정보 수정 성공!";
				  loc="/";

			  } catch (RuntimeException e) {
				  msg="수정 실패. 다시 시도해주세요.";
				  loc="/member/myInfo.do";

				  if(!img.isEmpty()) {
					  File deleteFile = new File(path+m.getImage().getRenamedFileName());
					  if(deleteFile.exists()) {
						  deleteFile.delete();
					  }
				  }

			  }
		  
		model.addAttribute("loginMember", m);
		System.out.println("수정처리완료 : "+m);
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		  
		return "common/msg";
	}
	
	//회원 정보 수정 > 비밀번호 수정
	@RequestMapping("/updatePwd.do")
	public String updatePwd(Member m, Model model, String nowPwd, String memberPwd, SessionStatus status) {
		
		String viewName = "member/myInfo";
		
		System.out.println(m.getMemberId());
		
		
		  Member loginMember = service.login(m); // 1. 클라이언트 입력 아이디-DB 아이디 대조
		  m.setMemberPwd(nowPwd); //클라이언트가 입력한 "현재 비밀번호"
		  
		  String msg= "";
		  String loc = "/member/myInfo.do";
		  
		  if (loginMember != null && pwEncoder.matches(m.getMemberPwd(),loginMember.getMemberPwd())) {
		  
			  System.out.println("클라이언트 입력 값 : " + m.getMemberPwd());
			  System.out.println("DB에 저장된 값 : " + loginMember.getMemberPwd());
		  
			  //비밀번호 "수정" 관련 로직 수행하기
			  m.setMemberPwd(memberPwd); //클라이언트가 희망하는 수정 비밀번호 값
			  m.setMemberPwd(pwEncoder.encode(m.getMemberPwd())); //BcryptPasswordEncoder로 암호화하기
			  int res = service.updatePwd(m);
			  if(res>0) {
				  
				  msg="비밀번호 수정 성공! 다시 로그인해주세요";
				  
				  if (!status.isComplete()) { //로그아웃 처리 
					  status.setComplete(); } 
				  loc="/";
			  
			  } else {
				  msg="비밀번호 수정 실패! 다시 시도해주세요";
			  }
			
		  } else { //현재 비밀번호-DB에 저장된 비밀번호, 불일치할 경우
		  
			  msg = "현재 비밀번호를 다시 확인해주세요!";
		  
		  }
		 
		model.addAttribute("loginMember", loginMember);
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		return "common/msg";
	}
	
	//회원 탈퇴
	@RequestMapping("/deleteMember.do")
	public String deleteMember(Member member, Model m,  SessionStatus status, HttpServletRequest rs) {
		
		Member memberInfo = service.login(member);
		System.out.println(memberInfo.getImage().getImgNo()==null?"사진 없음":"사진 있음");
		
		//멤버 탈퇴 성공 여부 -> 프로필 사진 삭제하기
		
		
		  int res = service.deleteMember(member);
		  
		  String msg = ""; String loc = "/";
		  
		  if(res>0) { msg = "회원 탈퇴 완료. 안녕히 계세요.";
		  
		  
			  //1. 로그아웃 처리하기
				if (!status.isComplete()) {
					status.setComplete();
				}
				
			  //2. 프로필 사진을 저장했던 회원인 경우 -> 프로필 사진 삭제
			  String path = rs.getServletContext().getRealPath("/resources/member/profile/");
			  File deleteFile = new File(path+memberInfo.getImage().getRenamedFileName());
			  if(deleteFile.exists()) {
				  deleteFile.delete();
			  }
				
				
			  loc="/"; //메인화면으로 이동하기
		  
		  
			  if (!status.isComplete()) { //로그아웃 처리 
				  status.setComplete(); } 
		  
		  } else { 
			  
			  msg ="회원 탈퇴 실패. 다시 시도해주세요."; 
		 
		  }
		  
		  m.addAttribute("msg", msg); m.addAttribute("loc", loc); 
		  
		  return "common/msg";

	}
	
	//회원 수정 > 프로필 삭제
	@RequestMapping("/deletePic.do")
	public String deletePic(Member m, HttpServletRequest rs, Model model) {
		
		Member loginMember = service.login(m);
		
		String msg = "이미지 삭제 실패! 다시 시도해주세요";
		String loc = "/member/myInfo.do";
		
		  String path = rs.getServletContext().getRealPath("/resources/member/profile/");
		  File deleteFile = new File(path+loginMember.getImage().getRenamedFileName());
		  if(deleteFile.exists()) {
			  
			  deleteFile.delete();
			  
			  int res = service.deletePic(loginMember); //PROFILEIMG에서 삭제하기
			  if(res>0) {
				  msg = "이미지 삭제 성공!";
				  loginMember.setImage(null); //이미지 관련 인스턴스 삭제하기
			  }
			  
		  }
		  
		model.addAttribute("loginMember", loginMember);
		model.addAttribute("msg", msg);
		model.addAttribute("loc",loc);
		
		return "common/msg";
	}
	
	@RequestMapping("/memberList.do")
	public ModelAndView memberList(@RequestParam(value="cPage", defaultValue="1") int cPage,
								  @RequestParam(value="numPerPage", defaultValue="5") int numPerPage,
								  ModelAndView mv) 
	{ //전체 회원 조회 > 게시판 페이징 처리
		
		Map param = Map.of("cPage",cPage,"numPerPage",numPerPage);
		List<Member> list = service.selectMemberListPage(param);
		
		int totalMember = service.selectMemberCnt();
		mv.addObject("list",list);
		mv.addObject("totalMember", totalMember);
		mv.addObject("pageBar", PageFactory.getPageBar(totalMember, numPerPage, cPage, "memberList.do"));
		mv.setViewName("member/memberList");
	
		return mv;
	}
	
	@RequestMapping("/updateGrade.do")
	public String updateGrade(Member m, Model model) {
		System.out.println("외않되?");
		int res = service.updateGrade(m);
		String msg="";
		if(res>0) {
			msg="등급 변경 성공!";
		} else {
			msg="등급 변경 실패! 다시 시도해주세요!";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", "/member/memberList.do");
		return "common/msg";
	}

}
