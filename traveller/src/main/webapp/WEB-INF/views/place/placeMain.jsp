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
					<form>
						<div class="area-option-container">						
							<select class="custom-select custom-select-sm" name="areaCode" id="areacode_">
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
							<select class="custom-select custom-select-sm" name="sigunguCode" id="sigungucode_">
							  			<option selected value="0">-- 선택 --</option>
							</select>
							<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>					
						</div>
					</form>
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
						<li class="nav-item nav-link" data-toggle="modal" data-target="#areaFilter">지역별</li>
						<li class="nav-item nav-link" data-toggle="modal" data-target="#themeFilter">테마별</li>
						</li>
					</ul>
				</div>
				
				<!-- modal : 필터 > 지역별 -->
				<div class="modal fade" id="areaFilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLongTitle">지역별 보기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        ...
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        <button type="button" class="btn btn-primary">Save changes</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal : 필터 > 테마별 -->
				<div class="modal fade" id="themeFilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="exampleModalLongTitle">테마별 보기</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				        ...
				      </div>
				      <div class="modal-footer">
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
			  
				
				const mainContainer = document.getElementsByClassName("container")[0];
				//검색 결과 출력 영역
				const resultContainer = document.getElementsByClassName("search-result-container");
				resultContainer[0].innerHTML=""; //이전 검색 결과는 화면에서 제거
				
				const basicContentsContainer = document.getElementsByClassName("basic-contents-container");
				basicContentsContainer[0].innerHTML="";
				
				if(data==""){ //검색 결과가 없는 경우, 원한다면 장소를 추천할 수 있음
					
					console.log("없엉");
					
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
								
								//주소지는 감춤
		/* 						const cardText = document.createElement("p");
								cardText.classList.add("card-text");
								cardText.innerText= data[i].address;
								cardBody.append(cardText); */
								
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
		
			});
		
			


		}
		

	
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
