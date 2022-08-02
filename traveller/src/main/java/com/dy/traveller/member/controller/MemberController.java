package com.dy.traveller.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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

		System.out.println(loginMember);
		System.out.println("클라이언트 입력 값 : " + m.getMemberPwd());
		System.out.println("DB에 저장된 값 : " + loginMember.getMemberPwd());

		String viewName = "redirect:/";

		//회원 가입 기능 구현 前(=BcryptPasswordEncoder로 클라이언트의 비밀번호를 암호화하기 前) 
		//... DB에 저장된 암호 값은, 암호화되어 있지 않다고 인식함 : Encoded password does not look like BCrypt
		//: 회원가입 로직 구현 후 재시도할 것 -> 기존 저장된 회원 정보 (x) 신규 가입 회원으로는 다음 로직으로 로그인 성공!
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

				  File deleteFile = new File(path+m.getImage().getRenamedFileName());
				  if(deleteFile.exists()) {
					  deleteFile.delete();
				  }

			  }
		  
		  
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		  
		return "common/msg";
	}

}
