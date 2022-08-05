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
</style>

	<section>
		<div class="container">
			<div class="main-title-container">
				<h3>여행지 탐색하기</h3>
				<p>직접 검색하거나, 지역별 멋진 장소를 선택해 보세요!</p>
			</div>
			<div class="search-container">
				<br>
				<form class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2" style="width:444px;" type="search" placeholder="장소명 검색하기" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
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
				
				
				<!-- 검색 결과 화면 예시 -->
				<div class="search-result-contents">
					검색 결과 썸네일 출력될 곳
				</div>
				
				
				
				
				
				
				
	
	</div>
			


	</div>
	

	

	
	</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
