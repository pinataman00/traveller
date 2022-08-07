<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
.container {
	margin-top: 80px;
 	border: 1px solid red;
}


.container div {
 	border: 1px solid blue; 
	align-items: center;
}

.search-container {
	justify-content: center;
	display: flex;
	margin-top: 50px;
	margin-bottom: 30px;
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
	margin: auto;
}

.search-container {
	display: flex;
}
.promotion-container {
	margin-top:30px;
	margin-bottom:30px;
}
.jumbotron{
	background-image:url("${path}/resources/img/ocean.jpg");
	border-radius:25px;
}
.search-result-contents{
	display:flex;
	justify-content:center;
}
.card{
	margin:10px;
}
.card img{
/*     border-radius: 10px; */
    width: auto;
    height: auto;
    max-width: 242px;
    max-height: 200px;
}
</style>

	<section>
		<div class="container">
			<div class="main-title-container">
				<h3>여행지 탐색하기</h3>
				<p>직접 검색하거나, 지역별 멋진 장소를 선택해 보세요!</p>

<!-- 			<div class="jumbotron jumbotron-fluid">
				<div class="container">
					<h1 class="display-4">여행지 탐색하기</h1>
					<p class="lead">여행의 시작은 검색! 마음껏 탐색해볼까요?</p>
				</div>
			</div> -->

		</div>
			<div class="search-container">
				<br>
<%--   				<form class="form-inline my-2 my-lg-0" action="${path}/place/searchList.do" method="get"> --%>
 					<input id="keyword" name="keyword" class="form-control mr-sm-2" style="width:444px;" type="search" placeholder="장소명 검색하기" aria-label="Search"
					> 
 					<button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="searchPlaces();">Search</button>
<!--  					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button> -->
  				</form>
				
				
				
			</div>
			
			<div class="area-search-container">
			
				<p>지역별 추천 여행지</p>
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
						<button class="btn btn-outline-success my-2 my-sm-0" type="submit">필터 적용</button>					
					</div>
				</form>
			</div>

			<!-- 검색 前 기본 화면 출력 -->
			<div class="promotion-container">
				<!-- 프로모션 -->
				<div class="jumbotron" onclick="alert('여름!');">
					  <h1 class="display-4">Hello! Travellers!</h1>
					  <p class="lead">올 여름 최고의 여행지를 추천해드릴게요</p>
					  <hr class="my-4">
					  <p>영화 속 여름처럼, 꿈결 속 여행처럼</p>
<!-- 					  <p class="lead">
					    <a class="btn btn-primary btn-sm" href="#" role="button">더 알아보기</a>
					  </p> -->
				</div>

			</div>
			
			<div class="popular-places-container">
				<!-- 인기 순위 -->
			</div>


			<!-- 검색 결과 영역 -->
			<div class="search-result-container">
	
							<!-- ※ 결과 내 재검색 -->
					<div class="theme-search-container">
							<p style="float:left">결과 내 재검색 : 테마별 추천 여행지</p>
							<br>
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
			
			<!-- 				<button type="button" class="btn btn-outline-info" value="A01">자연</button>
								<button type="button" class="btn btn-outline-info" value="">인문</button>
								<button type="button" class="btn btn-outline-info" value="">추천코스</button>
								<button type="button" class="btn btn-outline-info" value="">레포츠</button>
								<button type="button" class="btn btn-outline-info" value="">숙박</button>
								<button type="button" class="btn btn-outline-info" value="">쇼핑</button>
								<button type="button" class="btn btn-outline-info" value="">음식</button> -->
							</div>
					
				</div>
				
				
				<!-- 검색 결과 화면 예시 : 1행에 카드 3장씩 출력하기 -->
				<p>검색 결과 썸네일 출력될 곳</p>
				<div class="search-result-contents">

					<div class="card" style="width: 18rem;">
						<img class="card-img-top" src="${path}/resources/img/testPic/dimitri.png" alt="Card image cap">
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
						</div>
					</div>
					<div class="card" style="width: 18rem;">
						<img class="card-img-top" src="${path}/resources/img/testPic/dimitri.png" alt="Card image cap">
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
						</div>
					</div>
					<div class="card" style="width: 18rem;">
						<img class="card-img-top" src="${path}/resources/img/testPic/dimitri.png" alt="Card image cap">
						<div class="card-body">
							<h5 class="card-title">Card title</h5>
							<p class="card-text">Some quick example text to build on the
								card title and make up the bulk of the card's content.</p>
						</div>
					</div>
					
					
				</div>
				
<!-- 				<div style="display:flex;">
					<p>안녕 1</p>
					<p>안녕 1</p>
					<p>안녕 1</p>
				</div> -->
				
				
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
			  
 				console.log('성공:', data);
				
				const mainContainer = document.getElementsByClassName("container")[0];
				console.log(mainContainer[0]);
				const resultContainer = document.getElementsByClassName("search-result-container");
				resultContainer[0].innerHTML=""; //이전 검색 결과는 화면에서 제거
				
				
				for(let i=0;i<data.length;++i){
					
					const container = document.createElement("div");
					container.classList.add("search-result-contents");
					console.log("만들어 졌나? ",container);
					
					for(let j=0;j<3;j++){ //3개씩 끊어서 출력하기
						
								
						const test = document.createElement("p");
						if(data[i].title!=""){
							test.innerText= data[i].title;
						} else if(data[i].title=null) {
							data[i].title="이름 없음!";
						}
						container.append(test);
						if(resultContainer[0]!=null){
							resultContainer[0].append(container);
						}
						i++;													
					}
					i--;
						
				}
					
				
					mainContainer[0].append(resultContainer);
				
				console.log(resultContainer);
				console.log(resultContainer.nextElementSibling);
				
				
				
				
				
				
				
				
			  
			});
		
		
		
		
		


		}
		

	
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
