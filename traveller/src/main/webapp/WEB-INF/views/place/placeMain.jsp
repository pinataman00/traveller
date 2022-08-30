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
.cursorEffect{
	cursor:pointer;
}
img.heart{
	width:15px;
	height:15px;
	border-radius:0px;
	margin-bottom:10px;
	margin-right:5px;
	float:right;
}
div.likes-main-container{
	width: 400px;
    align-items: initial;
}

button#addCat{
    float: right;
    margin-top: 10px;
    margin-bottom: 10px;
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
							<input type="hidden" id="hiddenTheme">
									<div class="btn-group">
										<button type="button" class="btn btn-info">자연</button>
										<button type="button"
											class="btn btn-info dropdown-toggle dropdown-toggle-split"
											data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
											<span class="sr-only">Toggle Dropdown</span>
										</button>
										<div class="dropdown-menu">
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0101')">자연 관광지</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0102')">관광 자원</p>
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
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0201')">역사</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0202')">휴양</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0203')">체험</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0204')">산업</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0205')">건축/조형</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0206')">문화시설</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0207')">축제</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0208')">공연/행사</p> 
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
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('C0112')">가족</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('C0113')">나홀로</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('C0114')">힐링</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('C0115')">도보</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('C0116')">캠핑</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('C0117')">맛</p> 
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
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0301')">일반</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0302')">육상</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0303')">수상</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0304')">항공</p> 
											<p class="dropdown-item cursorEffect" onclick="fn_searchTheme('A0305')">복합</p> 
										</div>
									</div>
									
									<div class="btn-group">
										<button type="button" class="btn btn-info" onclick="fn_searchTheme('B0201')">숙박</button>
									</div>
									
									<div class="btn-group">
										<button type="button" class="btn btn-info" onclick="fn_searchTheme('A0401')">쇼핑</button>
									</div>
									
									<div class="btn-group">
										<button type="button" class="btn btn-info" onclick="fn_searchTheme('A0502')">음식</button>
									</div>

									<!-- <div class="btn-container"> -->
											<button class="btn btn-outline-success my-2 my-sm-0" style="margin-left:10px;" type="submit" onclick="fn_searchTheme();">검색</button>	
									<!-- </div> -->


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
						<li class="nav-item"><a class="nav-link disabled" href="#">결과 내 재검색</a>
						<li class="nav-item nav-link">
							<input type="text" id="reSearch" placeholder="키워드" style="margin-right:10px;">
							<button type="button" class="btn btn-outline-primary btn-sm" style="margin-top:-5px;" onclick="fn_research();">검색</button>
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
				
				<div class="best-choice-title">
				<hr>
					<h5>인기 여행지 TOP3</h5>
 					<c:if test="${loginMember!=null}">
						<p>${loginMember.memberId}님이 관심 있는 지역의 인기 여행지</p>
 					</c:if>
				</div>
			<!-- 클라이언트의 관심사 > 조회수||좋아요 순 베스트 장소 출력하기 -->
				<div class="basic-contents-container">


						<div class="result-card card" style="width: 18rem;">
							<img class="card-img-top" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
							<div class="card-body">							
								<h5 class="card-title">Card title</h5>
								<p class="card-text">인기 여행지 1순위</p>
								<img class="heart" src="${path}/resources/img/icons/heart.svg" onclick="alert('좋아요!');">				
								
							</div>
							
						</div>
						
						<div class="result-card card" style="width: 18rem;">
							<img class="card-img-top" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">인기 여행지 2순위</p>
								<img class="heart" src="${path}/resources/img/icons/heart.svg" onclick="alert('좋아요!');">
							</div>
						</div>
						<div class="result-card card" style="width: 18rem;">
							<img class="card-img-top" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
							<div class="card-body">
								<h5 class="card-title">Card title</h5>
								<p class="card-text">인기 여행지 3순위</p>
								<img class="heart" src="${path}/resources/img/icons/heart.svg" onclick="alert('좋아요!');">
							</div>
						</div>					
				 </div> 
	
				
				
				
<!-- Modal : 좋아요 목록 추가 관련 -->
<div class="modal fade" id="addLikesList" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content likes-main-container">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle" style="float:left;">
        	<p class="likedPlace"></p>   
        	<p id="savedPlace" style="font-size:10pt; color:green; display:none;">이미 좋아요 목록에 추가된 장소입니다</p>
        	<!-- 이미 목록에 추가된 장소라면, lcode정보 확인할 수 있어야 함! -->
        	<input type="hidden" id="lcode_" name="lcode">     
        </h5>
                	
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
     		 <!-- 이미 "좋아요"리스트에 추가된 경우에는 "좋아요 취소하기"버튼 활성화하기 -->	
		      <div class="modal-body">
		      		<!-- mybatis : LikesInfo객체와 연결하기 -->
		        	<input type="hidden" name="contentId" id="placeCode"> 
		        	<select name="likesId" id="catList" class="custom-select custom-select-sm" required>
						<option value="notOpt" selected disabled>-- 선택 --</option>
						<!-- 출력 예시 -->
						<!-- 0823) 좋아요 카테고리 추가함 
							 : LIKES테이블에서 불러오기 -->
<!-- 						<option value="basicLikes">좋아요</option> -->
					</select>
					
					<p id="addAlarm" style="color:red; display:none;">좋아요 카테고리를 먼저 추가해주세요!</p>
					<button id="addCat" type="button" class="btn btn-outline-primary btn-sm" onclick="addCat();">카테고리 +</button>
					
					<span class="guide ok">
						<div class="input-group input-group-sm mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-sm">제목</span>
							</div>
							<input id="catTitle" type="text" class="form-control" aria-label="Small"
								aria-describedby="inputGroup-sizing-sm" placeholder="카테고리 제목을 작성하세요" required>
						</div>
						<button type="button" class="btn btn-outline-primary btn-sm" style="float:right;" onclick="addCatagory();">'좋아요' 항목에 추가하기</button>
					</span> 
					
			  </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button id="delHeart" type="button" class="btn btn-primary" style="display:block;">취소하기</button>
		        <button id="liked-btn" type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveLikes()">추가하기</button>
		      </div>
      
    </div>
  </div>
</div>		
				
				
<script>


	//카테고리 추가 관련
	const addCatagory = () =>{
		
		//alert("?");
		let title = document.getElementById("catTitle").value;
		console.log(title);
		
		let memberId = "${loginMember.memberId}";
		console.log("지금 접속 중인 아이디 확인 : ",memberId," 제목 : ",title);
		
		//새로운 카테고리 항목 DB에 저장하기
		  fetch('${path}/place/addCat.do', {
		  method: 'POST', 
		  headers: {
		    'Content-Type': 'application/json',
		  },
		  body: JSON.stringify({"memberId":memberId,"title":title}),
		})
		.then((response) => response.json())
		.then((data) => {
		  		
			alert("카테고리 추가 완료!");
			document.getElementById("addAlarm").style.display="none"; //카테고리 없음 안내 끄기
			console.log(data);
			//DB에 저장된 '좋아요'항목이 있다면, 불러오기
			//const list = document.getElementById("catList");
			//document.createElement("");
			
			//DB에 저장하고 화면에 반영하기까지
			//select의 option에 추가하기
			const select = document.getElementById("catList");
			let newOpt = document.createElement("option");
			newOpt.innerText= data.likesTitle;
			newOpt.value= data.likesId;
			select.append(newOpt);
			
			//collapse 다시 접기
			document.getElementById("catTitle").value=""; //입력창 초기화
			const block = document.getElementsByClassName("ok")[0];
			console.log("/////////////",block);
			block.style.display="none"; //접기
			
			
			
		});

		
	}
	


</script>				
				
				
				
				
				
				
				
				
				
				
				
				
			
				
			
			
			
	</div>
	</div>
	
	<div id="printImg">
		
	</div>
	
	</section>
	
	<script>
	

		
		
		//----------------------------------------------------------------------------------------
	
		//공통 function : 검색 결과 화면에 출력해주는 기능
		const createCards = (data, keyword)=>{
			
			const mainContainer = document.getElementsByClassName("container")[0];
			//검색 결과 출력 영역
			const resultContainer = document.getElementsByClassName("search-result-container");
			resultContainer[0].innerHTML=""; //이전 검색 결과는 화면에서 제거
			const bestContainer = document.getElementsByClassName("best-choice-title");
			bestContainer[0].innerHTML="";
			
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
				recommendBox.addEventListener("click",e=>{
					location.assign('${path}/place/propose');
				});
				
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
	 				
	 				
	 				//"좋아요"체크한 것은 검은 하트로 표시하기 > 좋아요 데이터 가져오기 ==============================================
	 				
	 				let hearts = [];
	 				//물론 로그인된 상태여야 데이터 조회가 가능함
 				
	 				//async활용하기
	 				
	 				function getHearts(){
	 					
	 					let memberId = "${loginMember.memberId}";
	 					
	 					const res = fetch('${path}/place/searchHeart.do', {
							  			method: 'POST', 
							  			headers: {
							    		'Content-Type': 'application/json',
							  			},
							  			body: JSON.stringify({"memberId":memberId}),
										});
	 					
	 					return res.then(res=>res.json());
	 					
	 					
	 				}


					//결과 화면 구성하기 > 카드 형태로 데이터 출력하기 ============================================================				
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
								img.src="${path}/resources/img/testPic/doraemon.png";
							}
							const contentId = data[i].contentId;
							img.addEventListener("click",e=>{
								location.assign("${path}/place/placeView/"+contentId);
							});
							card.append(img);
							
							const cardBody = document.createElement("div");
							cardBody.classList.add("card-body");
							const cardTitle = document.createElement("h5");
							cardTitle.classList.add("card-title");
							cardTitle.innerText = data[i].title;
							cardBody.append(cardTitle);
							
							//===========================================================
							//TODO0829) "좋아요"정보를 바탕으로 하트의 색상 바꾸기
							const heart = document.createElement("img");
				
							//
							
							if(${loginMember.memberId==null}){
								
								//로그인되어 있지 않다면, 보통의 하트 출력하기
								heart.src = "${path}/resources/img/icons/heart.svg";
								
							} else { //로그인되어 있다면, DB에서 contentId와 memberId를 기준으로 좋아요 목록 포함 여부 조회하기
								//-> 포함된 경우, 색상 변경하기

								//TODO0829) 구현은 했으나 너무 비효율적임... 개선해야 함
			 	 				async function exec(contentId){
				 					
				 					let hearts;
				 					
				 					try{
				 						
				 						hearts = await getHearts();
				 						//console.log(hearts);
				 						
				 						hearts.forEach(e=>{
				 							if(e==contentId){
				 								
				 								heart.src = "${path}/resources/img/icons/heart-fill.svg";
				 								//document.getElementById("savedPlace").style.display="block";
				 							} 
				 						});
				 						
				 						
				 					} catch(error){
				 						console.log(error);
				 					}
				 					
				 				} 
								
								exec(contentId);
								

								
							}
								
						
							heart.src = "${path}/resources/img/icons/heart.svg";
							
							heart.classList.add("heart");
							cardBody.append(heart);
							addLikes(heart,data[i]);
							
							//===========================================================
							
							card.append(cardBody);
							container.append(card);
							resultContainer[0].append(container);
	
								i++;													
						}
						
						i--;
							
					}
						
					
					mainContainer.append(resultContainer[0]);
					
		
				  
				}
			
			
		}
		
		//'좋아요' 리스트에 추가하기 > modal창 관련
		const addLikes = (heart,data) => {
			
			heart.addEventListener("click",e=>{
				
				if(${loginMember!=null}){ //로그인 여부 확인 > 회원 전용 기능
					
					let id = "${loginMember.memberId}";
					
					//1. 좋아요 목록 불러오기
					fetch('${path}/place/loadLikesList.do', {
					  method: 'POST', 
					  headers: {
					    'Content-Type': 'application/json',
					  },
					  body: JSON.stringify({"memberId":id}),
					})
					.then((response) => response.json())
					.then((data) => {
					  		
						console.log("저장된 좋아요 목록이 있습니까? ",data);
						
						if(data.length==0){
							
							console.log("좋아요 리스트가 없습니다!");
							//0830) 좋아요 리스트가 부재하는 경우, '카테고리+' 버튼으로 사용자 정의 항목을 추가할 수 있음을 안내할 것
							document.getElementById("addAlarm").style.display="block";
							
							
						} else {
							
							const select = document.getElementById("catList");
							//존재하는 경우, select의 option으로서 저장된 리스트의 '항목'들 가져오기
							
							select.innerHTML = "";
							let basicOpt = document.createElement("option");
							basicOpt.innerText = "-- 선택 --";
							basicOpt.value="notOpt";
							basicOpt.selected="true";
							basicOpt.disabled="true";
							select.append(basicOpt);
							
							data.forEach(e=>{
								
								//0824) 아직은 데이터가 없음. 보류
								//0829) DB서버 재연결함. 작업 재개
								console.log("좋아요 리스트 : ",e);
								
								let opt = document.createElement("option");
								opt.innerText = e.likesTitle;
								opt.value= e.likesId;
								select.append(opt);
								
							});
						}
						
					});
					

					//--------------------------------------------------------------
					//사용자가 선택한 좋아요 항목에 *장소 정보 추가하기
										
					heart.setAttribute('data-toggle','modal');
					heart.setAttribute('data-target','#addLikesList');
					
					document.getElementsByClassName("likedPlace")[0].innerText=data.title;
					document.getElementById("placeCode").value=data.contentId;
					
					//---------------------------------------------------------------
					//TODO0830) 사용자가 이미 "좋아요"항목에 추가한 경우 *알림 및 취소하기 버튼 활성화하기
					//-> 어떤 카테고리에 추가된 장소인지 확인할 수 있으면 좋은데...
					//searchHeart.do에서 contentId만 List형태로 가져올 수 있도록 설정함
					//likes_title도 받아오는 메소드를 따로 만들어야 함
					
 	 				function getHearts(){
	 					
	 					let memberId = "${loginMember.memberId}";
	 					
	 					const res = fetch('${path}/place/heartInfo.do', {
							  			method: 'POST', 
							  			headers: {
							    		'Content-Type': 'application/json',
							  			},
							  			body: JSON.stringify({"memberId":memberId}),
										});
	 					
	 					return res.then(res=>res.json());
	 					
	 					
	 				} 
					
					//기본 : "이미 추가된 장소" 안내 문구, "취소하기" 버튼은 숨기기
	 				document.getElementById("savedPlace").style.display="none";
	 				document.getElementById("delHeart").style.display="none";
	 				
					let placeId = document.getElementById("placeCode").value;
					console.log("장소 코드 확인 : ",placeId);
					
 	 				async function exec(placeId){
	 					
	 					let hearts;
	 					
	 					
	 					try{
	 						
	 						hearts = await getHearts();
	 						
	 						console.log("ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ",hearts);
	 						
	 						const values = Object.values(hearts); //객체의 value값들을 하나의 배열로 묶어주는 함수
	 						console.log("values : ",values);
	 						
	 						const entries = Object.entries(hearts); //객체의 [key,value]를 한 벌의 이중 배열 형태로 반환해주는 함수
	 						console.log("entries : ",entries);
	 						
	 						//
	 						
	 						values.forEach(e=>{
	 							
	 							//2685274
	 							console.log("순회 가능? ",e);
	 							
	 							if(e==placeId){
	 								
	 								console.log("e: ",e," placeId : ",placeId);
	 								document.getElementById("savedPlace").style.display="block";
									document.getElementById("delHeart").style.display="block";
	 								
	 							} 
	 							
/* 	 							else if(e!=placeId){
	 								document.getElementById("savedPlace").style.display="";
	 								//document.getElementById("delHeart").style.display="none";
	 							} */
	 							
	 							
	 						});
	 						
	 						
	 					} catch(error){
	 						console.log(error);
	 					}
	 					
	 				} 
					
					exec(placeId);

					
					//좋아요 추가하기 -> 선택한 항목에 장소 정보 저장하기
					document.getElementById("liked-btn").onclick = ()=>{
						
				 		let contentId = document.getElementById("placeCode").value;
						let likesId = document.getElementById("catList").value;
						
						if(likesId=="notOpt"){
							
							alert("옵션을 선택해주세요!");
								
						} else {
							
							fetch('${path}/place/saveLikes.do', {
								  method: 'POST', 
								  headers: {
								    'Content-Type': 'application/json',
								  },
								  body: JSON.stringify({"contentId":contentId,"likesId":likesId}),
								})
								.then((response) => response.json())
								.then((data) => {
									
									console.log("좋아요 추가 완료? ",data);
									
								});
											
							//"좋아요" 표시 변경 -> 하트 색상 변경하기
							heart.src =  "${path}/resources/img/icons/heart-fill.svg";
							
							
						}

					}
					
					//TODO0830)
					//'좋아요 취소하기' 로직 구현하기
					document.getElementById("delHeart").addEventListener("click",e=>{
						
						//alert("삭제?"); 
						
						let contentId = document.getElementById("placeCode").value;
						
 						fetch('${path}/place/deleteLikes.do', {
							  method: 'POST', 
							  headers: {
							    'Content-Type': 'application/json',
							  },
							  body: JSON.stringify({"contentId":contentId,"likesId":likesId}),
							})
							.then((response) => response.json())
							.then((data) => {
								
								console.log("좋아요 삭제 완료? ",data);
								
							});
						
						//하트 색상 변경하기
						heart.src =  "${path}/resources/img/icons/heart.svg";
					});
					

										
				} else alert('로그인 먼저!');
			
			});
			
		}


		//좋아요 카테고리 추가 관련
		
		const addCat = (()=>{
			
			const ok = document.getElementsByClassName("ok");
			
 			let cnt = 1;
			
			return ()=>{
				
 				if(++cnt%2!=0){
					ok[0].style.display="none";
				} else {
					ok[0].style.display="block";
				} 
			
			} 
			
			
			//분기처리 다른 버전
/* 			if(ok[0].style.display=="none"){
				ok[0].style.display="block";
			} else {
				ok[0].style.display=="none";
			} */
			
	
		})();


		
		
		
		
	
		//검색 기능 > 키워드, 지역별, 테마별 ------------------------------------------------------------------------------------
		const searchPlaces = ()=>{ //1. 키워드 검색 기능
		
			
		//선행 작업 : 결과 내 재검색 > 재검색 조건 단일화하기
		//지역 조건 초기화
		document.getElementsByClassName("area-class")[0].value=0;
		document.getElementsByClassName("sigungu-class")[0].value=0;
		//테마 조건 초기화
		document.getElementById("hiddenTheme").value='';
		
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
			  				
				//결과 내 재검색 필터 비활성화됐었다면, 다시 활성화하기
				const areaTabSetting = document.getElementById("areaTab");
				areaTabSetting.classList.remove("disabled");
				document.getElementById("themeTab").classList.remove("disabled");
				
				//검색 결과 화면에 출력하기
				createCards(data,keyword);

			});

		}
		
		const fn_searchArea = () => {//2. 지역별 검색 기능
		
			//다른 검색 조건 초기화하기
			document.getElementById("keyword").value='';
			document.getElementById("areaWord").value='';
			document.getElementById("hiddenTheme").value='';
		
			const areaOpt = document.getElementsByClassName("area-class")[0].value;
			const sigunguOpt = document.getElementsByClassName("sigungu-class")[0].value;
			
			console.log("area : ",areaOpt," sigungu : ",sigunguOpt);
			
			fetch('${path}/place/searchFilter.do', {
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
		
		const fn_searchTheme = (condition)=>{//3. 테마별 검색 기능
			
			//다른 검색 조건 초기화
			document.getElementById("keyword").value='';
			document.getElementById("areaWord").value='';
			document.getElementsByClassName("area-class")[0].value=0;
			document.getElementsByClassName("sigungu-class")[0].value=0;			
		
			//alert(condition);
			const theme = condition;
			fetch('${path}/place/searchFilter.do', {
				  method: 'POST', 
				  headers: {
				    'Content-Type': 'application/json',
				  },
				  body: JSON.stringify({"theme":theme}),
				})
				.then((response) => response.json())
				.then((data) => {
				  
					console.log("성공했니? ", data);

					//결과 내 재검색 > '테마' 관련 필터 비활성화하기		
					document.getElementById("themeTab").classList.add("disabled");
					
					//결과 내 재검색 > '지역별 필터 검색'을 위해서 input hidden값으로 theme를 저장해둬야 함
					document.getElementById("hiddenTheme").value=theme;
					
					createCards(data);
					
				});
			
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		//결과 內 재검색 : 지역/키워드/테마 필터
		//TODO : 키워드 재검색은 기존 검색 조건에 대해, 경우 따라 유지||리셋하는 로직을 추가해야 함! 
		//결과 內 재검색 : 지역별 필터
		const fn_areaFilter = ()=>{
			
			const keyword = document.getElementById("areaWord").value; //클라이언트가 입력한 텍스트 값
			//const keyword = document.getElementById("keyword").value;
			console.log("검색어 : ",keyword);
			const areaCode = document.getElementsByClassName("area-class")[1].value;
			const sigunguCode = document.getElementsByClassName("sigungu-class")[1].value;
			console.log("필터 area : ",areaCode);
			console.log("필터 sigungu : ",sigunguCode);
			const theme= document.getElementById("hiddenTheme").value;
			console.log("필터 theme : ",theme);
			
			//DB 검색 : 필터 적용하기
			
			fetch('${path}/place/searchFilter.do', {
				  method: 'POST', 
				  headers: {
				    'Content-Type': 'application/json',
				  },
				  body: JSON.stringify({"title":keyword,"areacode":areaCode,"sigungucode":sigunguCode,"theme":theme}),
				})
				.then((response) => response.json())
				.then((data) => {
				  
					console.log("성공했니? ", data);
					createCards(data, keyword);
							
				});
			
		
		}
		
		//결과 內 재검색 : 키워드 재검색
		const fn_research = ()=>{
			
			const researchKeyword = document.getElementById("reSearch").value;
			console.log("결과 내 재검색 검색어 : ",researchKeyword);
			
			//본래 검색 조건들
			//1. 키워드
			const keyword = document.getElementById("areaWord").value; //클라이언트가 입력한 텍스트 값
			console.log("원래 검색어 : ",keyword);
			//2. 지역
			const areaCode = document.getElementsByClassName("area-class")[0].value;
			const sigunguCode = document.getElementsByClassName("sigungu-class")[0].value;
			console.log("지역 검색 후 재검색이라면? ",areaCode, sigunguCode);
			
			//3. 테마 (보류)
			
			
			//DB 검색 : 필터 적용하기
			fetch('${path}/place/searchFilter.do', {
				  method: 'POST', 
				  headers: {
				    'Content-Type': 'application/json',
				  },
				  body: JSON.stringify({"title":keyword,"areacode":areaCode,"sigungucode":sigunguCode,"research":researchKeyword}),
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
