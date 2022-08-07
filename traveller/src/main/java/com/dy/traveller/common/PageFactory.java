package com.dy.traveller.common;

public class PageFactory { //페이징 처리 관련
	
	//유동적으로 페이지 바가 구현될 것이므로, "매개변수"를 받는다
	public static String getPageBar(int totalData, int numPerPage, int cPage, String url) { //반복적으로 사용될 수 있는 기능이므로, template化함
		
		String pageBar = "";
		
		//TODO totalPage가 0일 때 예외가 발생할 수 있으니, 더미 데이터를 넣는 식으로 처리할 것
		int totalPage = (int)Math.ceil((double)totalData/numPerPage);
		int pageBarSize = 5; //이것도 유동적으로 처리하고 싶거든, 매개변수로 관련 데이터를 받아오면 됨
		int pageNo = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageNo+pageBarSize-1;
		
		//pageBar : bootstrap (※ 라이브러리에서 pagination검색)
		pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
		
		//navigator 구성 > "이전" 버튼 ================================================================
		if(pageNo==1) { //navigator상 페이지 넘버가 1일 때는, "이전"버튼을 클릭할 수 없음
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#'>이전</a>"; //href="#" -> 현재 페이지
			pageBar += "</li>"; 
		} else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging("+(pageNo-1)+")'>이전</a>"; //javascript의 함수를 호출함
			pageBar += "</li>"; 
		}
		//navigator 구성 > "숫자" 버튼 =================================================================
		while(!(pageNo>pageEnd||pageNo>totalPage)) { //navigator의 pageNo를 클릭하면, 해당 페이지로 이동
			
			if(pageNo==cPage) { //navigator상 페이지 넘버와, 현재 보고 있는 페이지가 동일할 때는 클릭X
				pageBar += "<li class='page-item disabled'>";
				pageBar += "<a class='page-link' href='#'>"+pageNo+"</a>";
				pageBar += "</li>"; 
			} else {
				pageBar += "<li class='page-item'>";
				pageBar += "<a class='page-link' href='javascript:fn_paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar += "</li>"; 
			}
			
			pageNo++;
		}
		
		//다음 ---------------------------------------------------------------------------------------------------------------
		if(pageNo>totalPage) {
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>"; 
		} else {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='javascript:fn_paging("+(pageNo)+")'>다음</a>";
			//※ pageNo+1이 아니라, pageNo인 이유? : while()반복문을 빠져나올 수 있는 조건이, pageNo>pageEnd임!
			//navigator한 세트가 1~5라면, 반복문을 빠져나올 때 pageNo는 6이고, 
			//따라서 상기 세트에서 "다음"버튼 클릭 時, 6으로 페이지가 전환될 수 있는 것임
			pageBar += "</li>"; 
		}
		pageBar += "</ul>";
		
		pageBar += "<script>"; //함수 : 호출 時 실행될 함수...
		pageBar += "function fn_paging(pageNo){"; //function예약어 사용하기. const로 하지 말고...
		pageBar += "location.assign('"+url+"?cPage='+pageNo)";
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;
	}
	
}
