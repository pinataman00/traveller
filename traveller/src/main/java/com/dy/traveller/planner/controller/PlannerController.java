package com.dy.traveller.planner.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dy.traveller.planner.model.service.PlannerService;
import com.dy.traveller.planner.model.vo.Crew;
import com.dy.traveller.planner.model.vo.Friends;
import com.dy.traveller.planner.model.vo.Plan;
import com.dy.traveller.planner.model.vo.PlanTemp;
import com.dy.traveller.planner.model.vo.Planner;
import com.dy.traveller.planner.model.vo.Thumbnail;

@Controller
@RequestMapping("/planner")
public class PlannerController {
	
	@Autowired
	private PlannerService service;

	@RequestMapping("/startPlanner")
	public String startPlanner() {
		return "/planner/startPlanner";
	}
	
	@RequestMapping("/setting")
	public ModelAndView setting(Planner planner, Crew crew, @RequestParam(value="crewMember") String[]crewMember, ModelAndView mv) {

		//TODO 0825) 플래너 새로고침할 때마다 CREW테이블에 ROW가 추가되는 문제 해결해야 함...

		if(crewMember[0].equals("fakeData")) { //크루가 없는 경우
			//System.out.println("크루 입력 값이 존재하지 않습니다!");
			
			mv.addObject("tempPlanner", planner);
			//mv.addObject("tempCrew",crew);
			mv.setViewName("/planner/plannerEditor");
			
			return mv;
			
			
		} else { //crewMember 저장하기 -> (부모)Crew테이블에 저장하기 -> (자식)Friends에 저장하기 
			
			//클라이언트가 입력한 멤버들 list에 저장하기
			List<Friends> list = new ArrayList();
		    for(int i=0;i<crewMember.length;i++) { //입력했던 멤버들 전원 저장하기
		    	list.add(new Friends().builder().memberId(crewMember[i]).build());
		    }
		    
		    //클라이언트 본인도 멤버에 추가하기
		    list.add(new Friends().builder().memberId(planner.getMemberId()).build());
			System.out.println("멤버들 확인하기 : "+list);
			crew.setFriends(list);

			try {
				
				service.inputCrew(crew); //crew저장 성공 時
				mv.addObject("tempPlanner", planner);
				mv.addObject("tempCrew",crew);
				mv.addObject("crewMembers",list);
				mv.setViewName("/planner/plannerEditor");
				
				System.out.println("될까? "+planner);
				System.out.println("될까? "+crew);
				
				
				return mv;
				
			} catch (RuntimeException e) {
				
				System.out.println("저장 실패!!!!!!");
				mv.setViewName("/"); //실패 시 메인화면으로 이동
				return mv;
			}
			
			
		}
		


		
	}
	
	@RequestMapping("/basicSetting")
	@ResponseBody
	public ModelAndView basicSetting(@RequestBody Map<String,Object> map, ModelAndView mv) {

		
//		//System.out.println(map);
		String plannerTitle = String.valueOf(map.get("plannerTitle"));
		String theme = String.valueOf(map.get("theme"));
		String memberId = String.valueOf(map.get("memberId"));
		int areaCode = Integer.parseInt(String.valueOf(map.get("areaCode")));
		//String areaCode = String.valueOf(map.get("areaCode"));
		//String sigunguCode = String.valueOf(map.get("sigunguCode"));
		int sigunguCode = Integer.parseInt(String.valueOf(map.get("sigunguCode")));
		int travelDays = Integer.parseInt(String.valueOf(map.get("travelDays")));
		
		Planner p = new Planner().builder().memberId(memberId).plannerTitle(plannerTitle).travelDays(travelDays).theme(theme).areaCode(areaCode).sigunguCode(sigunguCode).build();
		System.out.println("//////////////"+p);
		mv.addObject("tempData", p);
		//return p;
		mv.setViewName("/");
		return mv;
		
	}
	
	@RequestMapping("/plannerEditor")
	public String plannerEditor() {
		return "/planner/plannerEditor";
	}
	
	@RequestMapping("/savePlanner")
	@ResponseBody
	public void savePlanner(Plan[] plans, Planner p, Model model, MultipartFile img, HttpServletRequest rs) {
		
		
		System.out.println(p);
		System.out.println(plans);
		
		/* 로직 순서
		 * 
		 * 1. Planner 테이블에 플래너 정보 저장하기 (plannerTitle, sumamry, crewId)
		 * -> PLANNER테이블에 저장 실패 시, ROLLBACK처리하기
		 * 2. PLANNER테이블에서 자동 생성된 PLANNER_NO 전달 > THUMBNAIL테이블에 플래너 대표 이미지 저장하기
		 * ※ 테이블 간 관계 : 대표 이미지 관련 THUMBNAIL테이블은 PLANNER테이블에 종속됨
		 * -> PLANNER의 PK, 'PLANNER_NO'는 PLANNER의 FK임
		 * 
		 * */
		
		//1. 멀티 미디어 파일 받아오기
		//썸네일 이미지 관련 기본 정보
		System.out.println("파일 이름 : "+img.getOriginalFilename());
		System.out.println("파일 크기 : "+img.getSize());
		
		//첨부파일 저장 경로 설정하기
		String path = rs.getServletContext().getRealPath("/resources/planner/thumbnail/");
		File uploadDir = new File(path);
		//폴더가 없는 경우, 생성하기
		if(!uploadDir.exists()) uploadDir.mkdirs();
		
		
		  if(!img.isEmpty()) { //만약, 파일을 업로드했다면 //리네임 처리!
			  
			  String oriName = img.getOriginalFilename(); //원본 파일명 가져오기 
			  String ext = oriName.substring(oriName.lastIndexOf(".")); //파일명으로부터 확장자 추출 //리네임 작명 규칙 설정
			  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS"); 
			  int rndNum = (int)(Math.random()*10000); 
			  String rename = sdf.format(System.currentTimeMillis())+"_"+rndNum+ext;
			  
			  //서버 업로드 처리하기 
				try {
					
					img.transferTo(new File(path+rename));

					Thumbnail t = Thumbnail.builder().oriName(oriName).renamedFileName(rename).build();
					p.setImgage(t);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
		  }
	
	}
	
	//TODO 0906) FormData객체 활용해 form태그 대신 데이터 서버로 전송받기
	@RequestMapping("/savePlanner2")
	@ResponseBody
	public void savePlanner2(MultipartFile thumbNail, Planner planner, PlanTemp temp) {
		System.out.println("FormData테스트!!!! 파일 이름 : "+thumbNail.getOriginalFilename());
		System.out.println("제목도 가져올 수 있나? "+planner);
		System.out.println("객체 배열은 ? "+temp.toString());
		System.out.println("객체 배열은 ? "+temp.getPlanList());
		System.out.println("객체 배열은 ? "+temp.getPlanList().get(0).toString());
		
		//일자별 여행지 정보를 저장할 ArrayList
		List<Plan[]> list = temp.getPlanList();
		
		
		for(int i=0;i<list.size();i++) {
			
			System.out.println(i+1+"일자의 여행 계획");
			System.out.println("방문 장소는 몇 군데? "+list.get(i).length);
			//System.out.println(Arrays.toString(list.get(i)));
			System.out.println(Arrays.toString(list.get(i)));
			
			
		}

	}
	
	
}
