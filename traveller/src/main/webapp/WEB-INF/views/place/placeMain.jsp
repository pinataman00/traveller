<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
.container {
	margin-top: 80px;
/*  	border: 1px solid red; */
}


.container div {
/*  	border: 1px solid blue;  */
	align-items: center;
}

.search-container {
	justify-content: center;
	display: flex;
	margin-top: 30px;
	margin-bottom: 30px;
}
.search-result-container{
	margin-top:40px;
}

.main-title-container {
	margin-top: 50px;
}

.btn-container {
	margin: 20px;
}

.area-option-container {
	display: flex;
	width: 527px;
	margin-top: 30px;
	margin-bottom: 30px;
}

.search-container {
	display: flex;
}
.promotion-container {
	margin-top:30px;
	margin-bottom:30px;
}
.jumbotron{
	background-image:url("${path}/resources/img/background.jpg");
	border-radius:25px;
}
.search-result-contents{
	display:flex;
	justify-content:center;
}
.result-card{
	margin:10px;
	width:300px;
	height:340px;
}
.result-card img{
    
    width: 100%;
    height: 100%;
    overflow: hidden;
    width: 280px;
    height: 200px;
    object-fit: cover;
    border-radius:10px;
    margin-top:10px;
 
}

.card-body{
	width:300px;
	height:120px;
}

.card-title{
	font-size:20px;
}

.basic-contents-container{
	justify-content:center;
	display:flex;
}

.recommend-container{
	text-align:center;
}


</style>

	<section>

		<div class="container">
			<div class="main-title-container">
<!-- 				<h3>여행지 탐색하기</h3>
				<p>직접 검색하거나, 지역별 멋진 장소를 선택해 보세요!</p> -->

<!-- 			<div class="jumbotron jumbotron-fluid">
				<div class="container">
					<h1 class="display-4">여행지 탐색하기</h1>
					<p class="lead">여행의 시작은 검색! 마음껏 탐색해볼까요?</p>
				</div>
			</div> -->
						<!-- 검색 前 기본 화면 출력 -->
			<div class="promotion-container">
				<!-- 프로모션 -->
				<div class="jumbotron" onclick="alert('여름!');">
					  <h1 class="display-4">Hello! Travellers!</h1>
					  <p class="lead">어디로 갈까요? 먼저 검색해보세요</p>
					  <hr class="my-4">
					  <p>검색 창에 키워드를 검색하거나, 지역/테마 옵션을 선택해보세요!</p>
<!-- 					  <p class="lead">
					    <a class="btn btn-primary btn-sm" href="#" role="button">더 알아보기</a>
					  </p> -->
				</div>
			</div>
	
 		<div id="search-option-container" style="text-align:right;">
		
			<p>
			  <a class="btn btn-primary" data-toggle="collapse" href="#keywordSearch" role="button" aria-expanded="false" aria-controls="collapseExample">
			    키워드
			  </a>
			  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#areaSearch" aria-expanded="false" aria-controls="collapseExample">
			    지역별 검색
			  </button>
			  <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#themeSearch" aria-expanded="false" aria-controls="collapseExample">
			    테마별 검색
			  </button>
			</p>
			
			<!-- 키워드 검색 -->
			<div class="collapse" id="keywordSearch">
			  <div class="card">
					<div class="search-container">
		 					<input id="keyword" name="keyword" class="form-control mr-sm-2" style="width:444px;" type="search" placeholder="장소명 검색하기" aria-label="Search"> 
		 					<button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="searchPlaces();">검색</button>
					</div>
			  </div>
			</div>
			<!-- 지역별 검색 -->
			<div class="collapse" id="areaSearch">
			  <div class="card">		    
			    <div class="area-search-container">

						<div class="area-option-container">						
							<select class="custom-select custom-select-sm area-class" name="areaCode" id="areacode_" onclick="createAreaOption(0);">
										<option value="0">-- 선택 --</option>
										<option value="1">서울</option>
										<option value="2">인천</option>
										<option value="3">대전</option>
										<option value="4">대구</option>
										<option value="5">광주</option>
										<option value="6">부산</option>
										<option value="7">울산</option>
										<option value="8">세종특별자치시</option>
										<option value="31">경기도</option>
										<option value="32">강원도</option>
										<option value="33">충청북도</option>
										<option value="34">충청남도</option>
										<option value="35">경상북도</option>
										<option value="36">경상남도</option>
										<option value="37">전라북도</option>
										<option value="38">전라남도</option>
										<option value="39">제주도</option>	
							</select>
							<select class="custom-select custom-select-sm sigungu-class" name="sigunguCode" id="sigungucode_">
							  			<option selected value="0">-- 선택 --</option>
							</select>
							<button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="fn_searchArea();">검색</button>					
						</div>

			</div>
			    
			<!-- 테마별 검색 -->    
			  </div>
			</div>
			<div class="collapse" id="themeSearch">
			  <div class="card">
			    
			    					<div class="theme-search-container">
							<div class="btn-container">
	
							<div class="btn-group">
								<button type="button" class="btn btn-info">자연</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">자연 관광지</a> 
									<a class="dropdown-item" href="#">관광 자원</a>
								</div>
							</div>
							
							<div class="btn-group">
								<button type="button" class="btn btn-info">인문</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">역사</a> 
									<a class="dropdown-item" href="#">휴양</a>
									<a class="dropdown-item" href="#">체험</a>
									<a class="dropdown-item" href="#">산업</a>
									<a class="dropdown-item" href="#">건축/조형</a>
									<a class="dropdown-item" href="#">문화시설</a>
									<a class="dropdown-item" href="#">축제</a>
									<a class="dropdown-item" href="#">공연/행사</a>
								</div>
							</div>
							
							<div class="btn-group">
								<button type="button" class="btn btn-info">추천코스</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">가족</a> 
									<a class="dropdown-item" href="#">나홀로</a>
									<a class="dropdown-item" href="#">힐링</a>
									<a class="dropdown-item" href="#">도보</a>
									<a class="dropdown-item" href="#">캠핑</a>
									<a class="dropdown-item" href="#">맛</a>
								</div>
							</div>
							
							<div class="btn-group">
								<button type="button" class="btn btn-info">레포츠</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">일반</a> 
									<a class="dropdown-item" href="#">육상</a>
									<a class="dropdown-item" href="#">수상</a>
									<a class="dropdown-item" href="#">항공</a>
									<a class="dropdown-item" href="#">복합</a>
								</div>
							</div>
							
							<div class="btn-group">
								<button type="button" class="btn btn-info">숙박</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">숙박 시설</a>
								</div>
							</div>
							
							<div class="btn-group">
								<button type="button" class="btn btn-info">쇼핑</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">쇼핑</a>
								</div>
							</div>
							
							<div class="btn-group">
								<button type="button" class="btn btn-info">음식</button>
								<button type="button"
									class="btn btn-info dropdown-toggle dropdown-toggle-split"
									data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<div class="dropdown-menu">
									<a class="dropdown-item" href="#">음식점</a> 
									<a class="dropdown-item" href="#">숙박 시설</a>
								</div>
							</div>

							</div>
			    
			    
			    
			  </div>
			</div>
	
		</div> 

		</div>
	
			<div class="popular-places-container">
				<!-- 인기 순위 -->
			</div>

			<!-- 검색 결과 영역 -->
				<div class="result-filter-container" style="display:none;margin-top:50px;">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link active">검색 결과</a>
						</li>
						<li class="nav-item"><a class="nav-link disabled" href="#">필터</a>
						<li class="nav-item nav-link" id="areaTab" data-toggle="modal" data-target="#areaFilter">지역별</li>
						<li class="nav-item nav-link" id="themeTab" data-toggle="modal" data-target="#themeFilter">테마별</li>
						</li>
					</ul>
				</div>
				
				<!-- modal : 필터 > 지역별 -->
				<div class="modal fade" id="areaFilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header" style="width:100%;">
				        <h5 class="modal-title" id="exampleModalLongTitle">지역별 보기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>	
				      <div class="modal-body">

							<!-- 지역별 필터 옵션 -->
							<div class="area-container">
								
								<select class="custom-select custom-select-sm area-class" name="areaCode"
									id="areacode_" onclick="createAreaOption(1);">
									<option value="0">-- 선택 --</option>
									<option value="1">서울</option>
									<option value="2">인천</option>
									<option value="3">대전</option>
									<option value="4">대구</option>
									<option value="5">광주</option>
									<option value="6">부산</option>
									<option value="7">울산</option>
									<option value="8">세종특별자치시</option>
									<option value="31">경기도</option>
									<option value="32">강원도</option>
									<option value="33">충청북도</option>
									<option value="34">충청남도</option>
									<option value="35">경상북도</option>
									<option value="36">경상남도</option>
									<option value="37">전라북도</option>
									<option value="38">전라남도</option>
									<option value="39">제주도</option>
								</select> <select class="custom-select custom-select-sm sigungu-class"
									name="sigunguCode" id="sigungucode_">
									<option selected value="0">-- 선택 --</option>
								</select>
								<input type="hidden" id="areaWord">
							</div>
						</div>
					     <div class="modal-footer" style="width:100%;">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					        <button type="button" class="btn btn-primary" onclick="fn_areaFilter();">필터 적용하기</button>
					     </div>
				    </div>
				  </div>
				</div>
				<!-- modal : 필터 > 테마별 -->
				<div class="modal fade" id="themeFilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header" style="width:100%;">
				        <h5 class="modal-title" id="exampleModalLongTitle">테마별 보기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        ...
				        <input type="hidden" id="themeWord">
				      </div>
				      <div class="modal-footer" style="width:100%;">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="button" class="btn btn-primary">Save changes</button>
				      </div>
				    </div>
				  </div>
				</div>
				
				
			<div class="search-result-container">
					<!-- 검색 결과가 출력될 곳 -->
			</div>
				
				
				<!-- 검색 결과 화면 예시 : 1행에 카드 3장씩 출력하기 -->

				<div class="basic-contents-container">

						<div class="result-card card" style="width: 18rem;">
							<img class="card-img-top" src="${path}/resources/img/testPic/dimitri.png" alt="Card image cap">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">Some quick example text to build on the
									card title and make up the bulk of the card's content.</p>
							</div>
						</div>
						<div class="result-card card" style="width: 18rem;">
							<img class="card-img-top" src="${path}/resources/img/testPic/dimitri.png" alt="Card image cap">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">Some quick example text to build on the
									card title and make up the bulk of the card's content.</p>
							</div>
						</div>
						<div class="result-card card" style="width: 18rem;">
							<img class="card-img-top" src="${path}/resources/img/testPic/dimitri.png" alt="Card image cap">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">Some quick example text to build on the
									card title and make up the bulk of the card's content.</p>
							</div>
						</div>					
				 </div> 
				

				
				
				<!-- TODO : 클라이언트의 키워드 검색 결과를 페이징 처리할 수 없어서 주석 처리함 -->
<%--  			<div class="list-container">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">title</th>					
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty list}">
							<c:forEach var="m" items="${list}">
								<tr>
									<td>${m.title}</td>						
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty list }">
							<td colspan="11">검색 결과가 없습니다</td>
						</c:if>
					</tbody>
				</table>
				<div id="pageBar">
					${pageBar }
				</div>
			</div> --%>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
			
				
			
			
			
	</div>
	</div>
	
	<div id="printImg">
		
	</div>
	
	</section>
	
	<script>
	
		//공통 function : 검색 결과 화면에 출력해주는 기능
		const createCards = (data, keyword)=>{
			
			const mainContainer = document.getElementsByClassName("container")[0];
			//검색 결과 출력 영역
			const resultContainer = document.getElementsByClassName("search-result-container");
			resultContainer[0].innerHTML=""; //이전 검색 결과는 화면에서 제거
			
			const basicContentsContainer = document.getElementsByClassName("basic-contents-container");
			basicContentsContainer[0].innerHTML="";
			
			if(data==""){ //검색 결과가 없는 경우, 원한다면 장소를 추천할 수 있음
				
				const recommendBox = document.createElement("div");
				recommendBox.classList.add("recommend-container");
				
				
				const infoText = document.createElement("h4");
				infoText.innerText = keyword+"에 대한 검색 결과가 없습니다 :(";
				
				const suggestText = document.createElement("p");
				suggestText.innerText = "함께 알고 싶은 좋은 장소가 있다면, 우리에게 추천해주세요";

				recommendBox.append(infoText);
				recommendBox.append(suggestText);

				const recommendBtn = document.createElement("button");
				recommendBtn.classList.add("btn");
				recommendBtn.classList.add("btn-primary");
				recommendBtn.classList.add("btn-lg");
				recommendBtn.classList.add("btn-block");
				recommendBtn.innerText = "추천하기";
				
				recommendBox.append(recommendBtn);
				
				resultContainer[0].append(recommendBox);
				mainContainer.append(resultContainer[0]);
			
			
			} else { //검색 결과가 존재하는 경우, 화면에 카드 출력
			
			
	 				console.log('성공 :', data);
					
					//필터 탭 활성화하기
					const filterMenu = document.getElementsByClassName("result-filter-container");
					console.dir(filterMenu[0]);
					filterMenu[0].style.display="";
					//필터 > 모달에 키워드 값 전달하기
					//"지역별 키워드"
					document.getElementById("areaWord").value=keyword;
					document.getElementById("themeWord").value=keyword;
			
	 				const resultSummary = document.createElement("div");
	 				resultSummary.classList.add("result-summary-container");
	 				const summaryText = document.createElement("p");
	 				summaryText.innerText = "검색 결과 : 총 "+data.length+"건";
	 				//resultSummary.innerText = "검색 결과 : 총 "+data.length+"건";		 				
	 				resultSummary.append(summaryText);
	 				resultContainer[0].append(resultSummary);

									
					for(let i=0;i<data.length;++i){
						
						const container = document.createElement("div"); //1행에 콘텐츠 3개씩 담김
						container.classList.add("search-result-contents");
						
						for(let j=0;j<3;j++){ //3개씩 끊어서 출력하기
							
							//1개 콘텐츠 구성
							//1. div > card
							const card = document.createElement("div");
							card.classList.add("result-card");
							card.classList.add("card");
							//card.style.width="18rem";
							const img = document.createElement("img");
							if(data[i].firstImage!=null){
								
								img.src=data[i].firstImage;
								
							} else { //기본 이미지 출력
								img.src= "${path}/resources/img/testPic/dorothea.png";
							} 
							card.append(img);
							
							const cardBody = document.createElement("div");
							cardBody.classList.add("card-body");
							const cardTitle = document.createElement("h5");
							cardTitle.classList.add("card-title");
							cardTitle.innerText = data[i].title;
							cardBody.append(cardTitle);

							card.append(cardBody);
							container.append(card);
							resultContainer[0].append(container);
	
								i++;													
						}
						
						i--;
							
					}
						
					
					mainContainer.append(resultContainer[0]);
					
					console.log(resultContainer);
					console.log(resultContainer.nextElementSibling);
		
				  
				}
			
			
		}
	
		//검색 기능 > 키워드, 지역별, 테마별
		const searchPlaces = ()=>{ //키워드 검색 기능
			
		//fetch를 사용해서 검색 결과 가져오기
		const keyword = document.getElementById("keyword").value;
			
		
		fetch('${path}/place/keywordSearch.do?keyword='+keyword, {
			  method: 'POST', 
			  headers: {
			    'Content-Type': 'application/json',
			  },
			  body: JSON.stringify({"keyword":keyword}),
			})
			.then((response) => response.json())
			.then((data) => {
			  
				
				//비활성화됐었다면, 다시 활성화하기
				const areaTabSetting = document.getElementById("areaTab")
				//console.log("있니? ",areaTabSetting.classList);
				console.log(areaTabSetting)
				areaTabSetting.classList.remove("disabled");		
				
				createCards(data,keyword);

						
			});

		}
		
		const fn_searchArea = () => {
			
			const areaOpt = document.getElementsByClassName("area-class")[0].value;
			const sigunguOpt = document.getElementsByClassName("sigungu-class")[0].value;
			
			console.log("area : ",areaOpt," sigungu : ",sigunguOpt);
			
			fetch('${path}/place/areaFilter.do', {
				  method: 'POST', 
				  headers: {
				    'Content-Type': 'application/json',
				  },
				  body: JSON.stringify({"areacode":areaOpt,"sigungucode":sigunguOpt}),
				})
				.then((response) => response.json())
				.then((data) => {
				  
					console.log("성공했니? ", data);
					createCards(data);
					
					//결과 내 재검색 > '장소' 관련 필터 비활성화하기
					document.getElementById("areaTab").classList.add("disabled");		
					
					
				});
			
			
		}
		
		
		//결과 內 재검색 : 지역별 필터
		const fn_areaFilter = ()=>{
			
			const keyword = document.getElementById("areaWord").value; //클라이언트가 입력한 텍스트 값
			//const keyword = document.getElementById("keyword").value;
			console.log("검색어 : ",keyword);
			const areaCode = document.getElementsByClassName("area-class")[1].value;
			const sigunguCode = document.getElementsByClassName("sigungu-class")[1].value;
			console.log("필터 area : ",areaCode);
			console.log("필터 sigungu : ",sigunguCode);
			
			
			//DB 검색 : 필터 적용하기
			fetch('${path}/place/areaFilter.do', {
				  method: 'POST', 
				  headers: {
				    'Content-Type': 'application/json',
				  },
				  body: JSON.stringify({"title":keyword,"areacode":areaCode,"sigungucode":sigunguCode}),
				})
				.then((response) => response.json())
				.then((data) => {
				  
					console.log("성공했니? ", data);
					createCards(data, keyword);
							
				});
			
			
		}
		

		//-----------------------------------------------------------------------------------------------------------------------		
		const createAreaOption = (idx)=>{ //class名으로 지역별 옵션 생성하기
			
			
			//-------------------------------------------------------------------------------------------
			//관심 지역 옵션 *생성 관련
			const area = document.getElementsByClassName("area-class");
			const sigungu = document.getElementsByClassName("sigungu-class");

	 		area[idx].addEventListener("change", e=>{
				
				if(e.target.value==1){ //서울
					
					let seoul = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구",
						         "금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구",
						         "서초구","성동구","성북구","송파구","양천구","영등포구","용산구",
						         "은평구","종로구","중구","중랑구"]
				
					insertInfo(seoul);
	
					 
				} else if (e.target.value==2){ //인천
					
					let incheon = ["강화군","계양구","미추홀구","남동구","동구","부평구","서구","연수구","옹진군","중구"];
					insertInfo(incheon);
				
				} else if (e.target.value==3){ //대전
					
					let daejeon = ["대덕구","동구","서구","유성구","중구"];
					insertInfo(daejeon);

				} else if (e.target.value==4){ //대구
					
					let daegu = ["남구","달서구","달성군","동구","북구","서구","수성구","중구"];
					insertInfo(daegu);
					
				} else if (e.target.value==5){ //광주
					
					let gwangju = ["광산구","남구","동구","북구","서구"];
					insertInfo(gwangju);
				
	 			} else if (e.target.value==6){ //부산
	 				
	 				let busan = ["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"]
	 				insertInfo(busan);
	 				
				} else if (e.target.value==7){ //울산
					
	 				let ulsan = ["중구","남구","동구","북구","울주군"]
	 				insertInfo(ulsan);
				
				} else if (e.target.value==8){ //세종
					
						sigungu[idx].innerHTML = "";
				
						let option = document.createElement("option");
						option.innerText = "세종특별자치시";
						option.value = 1;
						sigungu[idx].appendChild(option);
					
				} else if (e.target.value==31){ //경기
					
	 				let gyeonggi = ["가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시",
	 								"동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시",
	 								"양평군","여주시","연천군","오산시","용인시","의왕시","의정부시","이천시","파주시",
	 								"평택시","포천시","하남시","화성시"];
					
					insertInfo(gyeonggi);
				
				} else if (e.target.value==32){ //강원도
					
					let gangwon = ["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군",
								   "정선군","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"]
					insertInfo(gangwon);
					
				} else if (e.target.value==33){ //충북
					
					let chungbuk = ["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","진천군","청원군","청주시","충주시","증평군"]
					insertInfo(chungbuk);
					
				} else if (e.target.value==34){ //충남
					
					let chungnam = ["공주시","금산군","논산시","당진시","보령시",
									"부여군","서산시","서천군","아산시","예산군",
									"천안시","청양군","태안군","홍성군","계룡시"]
					insertInfo(chungnam);
				
				} else if (e.target.value==35){ //경북
					
					let gyeongbuk = ["경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군",
									"영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시"]
					insertInfo(gyeongbuk);				
					
				} else if (e.target.value==36){ //경남
					
					
					sigungu[idx].innerHTML = "";
					let gyeongnam = ["거제시","거창군","고성군","김해시","남해군","마산시","밀양시","사천시","산청군","양산시",
									"의령군","진주시","진해시","창녕군","창원시",
									"통영시","하동군","함안군","함양군","합천군"]
				
					let code = 1;
					for(let i=0;i<10;i++){
						
						let option = document.createElement("option");
						option.innerText = gyeongnam[i];
						option.value = code++;
						sigungu[idx].appendChild(option);					
					}
				
					//지역코드가 ~양산:10, 의령:12~임
					let codeFrom = 12;
					for(let i=10;i<gyeongnam.length;i++){
						
						let option = document.createElement("option");
						option.innerText = gyeongnam[i];
						option.value = codeFrom++;
						sigungu[idx].appendChild(option);					
					}
					
				} else if (e.target.value==37){ //전북
					
					
					let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
								    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]
					insertInfo(jeonbuk);
					
					
				} else if (e.target.value==38){ //전남
					
					sigungu[idx].innerHTML = "";
					//~여수시까지는 순차적임 (~13)
					//영광군부터 16~
					let jeonnam = ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시",
									"영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]

					let code = 1;
					for(let i=0;i<13;i++){
						
						let option = document.createElement("option");
						option.innerText = jeonnam[i];
						option.value = code++;
						sigungu[idx].appendChild(option);					
					}
				
					//지역코드가 영광부터 16~임
					let codeFrom = 16;
					for(let i=13;i<jeonnam.length;i++){
						
						let option = document.createElement("option");
						option.innerText = jeonnam[i];
						option.value = codeFrom++;
						sigungu[idx].appendChild(option);					
					}
					
				} else if (e.target.value==39){ //제주
					
					let jeju = ["남제주군","북제주군","서귀포시","제주시"]
					insertInfo(jeju);

				} else sigungu[idx].innerHTML = "";
				
		}); 
			
			console.log(sigungu);

			function insertInfo(city){ //지역 정보 대입 함수
				
				sigungu[idx].innerHTML = "";
				let code = 1;
				
				city.forEach(e=>{
					
					let option = document.createElement("option");
					option.innerText = e;
					option.value = code++;
					sigungu[idx].appendChild(option);
					
				});
				
			}

		}
	
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
