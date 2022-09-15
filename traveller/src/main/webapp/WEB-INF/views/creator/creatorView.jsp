<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
div#container {
	margin-top: 100px;
	text-align: center;
}

.title-container {
	text-align: left;
}

.jumbotron {
	/* background-image:url("${path}/resources/img/pink.jpg"); */
	background-color: white;
	/* border: 1px solid red; */
	height: 300px;
	padding-left: 30px;
	display: inline-flex;
}

#profileImg {
	width: 100px;
	height: 100px;
}

select#catList {
	width: 300px;
	float: right;
	margin-right: 10px;
	margin-bottom: 30px;
}

.cards-container {
	/* border: 1px solid blue; */
	
}

/* 카드 관련 설정 */
.search-result-contents {
	display: flex;
	justify-content: center;
}

.result-card {
	margin: 10px;
	width: 300px;
	height: 340px;
}

.result-card img {
	width: 100%;
	height: 100%;
	overflow: hidden;
	/*     width: 280px; */
	height: 200px;
	object-fit: cover;
	border-radius: 10px;
	margin-top: 10px;
}

.card-body {
	width: 300px;
	height: 120px;
}

.card-title {
	font-size: 20px;
}

/* 사용자 프로필 이미지 출력 관련 */
img.profileImg {
	margin-top: -70px;
	margin-bottom: 10px;
	width: 100%;
	height: 100%;
	max-width: 200px;
	max-height: 200px;
	border-radius: 30px;
}

div#myPic-container {
	text-align: center;
}

.option-container {
	display: flex;
	float: right;
	align-items: baseline;
	margin-right: 30px;
}

/* 결과 내 검색 관련 */
.search-container {
	/* margin-top:50px; */
	margin-left: 30px;
	float: right;
	display: flex;
}

.my-btn {
	float: right;
	margin-top: 10px;
	margin-bottom: 10px;
}

p#contentTitle {
	text-align: right;
	margin-top: 10px;
	margin-right: 30px;
}

/* 플래너 출력 카드 */
.my-planner-card {
	display: flex;
}

.card-title {
	font-weight: 600;
}

.my-pic-container {
	text-align: center;
}

.my-planner-theme {
	font-size: 13px;
	margin-top: 3px;
}

.my-planner-summary {
	margin-bottom: 0px;
}

.planner-result-card {
	width: 500px;
	height: 150px;
	display: inline-block;
	margin-top: 10px;
}

.my-planner-card {
	display: flex;
}

.planner-card-img {
	width: 130px;
	height: 130px;
	margin-top: 10px;
	margin-left: 10px;
	padding: 6px;
	max-width: 130px;
	max-height: 130px;
	object-fit: cover;
	over-flow: hidden;
	border-radius: 10px;
}

.planner-info-container {
	width: 300px;
	text-align: left;
	margin-top: 10px;
	margin-left: 10px;
}

.planner-btn-container {
	display: flex;
	margin-top: 103px;
	margin-right: 20px;
}

.planner-info-btn {
	margin-right: 5px;
}

.planner-container {
	margin-left: 30px;
	display: inline-grid;
	/* height:500px; */
	overflow-y: scroll;
}

.planner-container::-webkit-scrollbar {
	display: none;
}

.content-body {
	margin-bottom: 30px;
	/*  border:1px solid red;  */
	margin-top: 10px;
}
</style>

<section>
	<div id="container">

		<div class="jumbotron jumbotron-fluid">
			<div class="container title-container">
			
				<!-- 프로필 이미지 출력 -->
				<div id="myPic-container">
					<c:choose>					
						<c:when test="${not empty creator.image.oriName}">						
						</c:when>
						<c:when test="${empty creator.image.oriName}">
							<img id="profileImg" src="${path}/resources/img/icons/person-fill.svg">
						</c:when>
					</c:choose>
				</div>
				
				<!-- <p class="display-4" style="font-size:30px;font-weight:400;">나의 여행</p> -->
				<p class="lead" style="text-align:center;margin-bottom:5px;">크리에이터, ${creator.memberId}님의 BLOG</p>
				<p class="my-introduce" style="text-align:center">${creator.introduce}</p>
			</div>
		</div>


		<div class="card text-center" style="margin-top:40px;">
			<div class="card-header">
				<ul class="nav nav-tabs card-header-tabs">

					<li class="nav-item">
						<a id="plannerMenu" class="nav-link active" href="#" onclick="openPlanner();">플래너</a>
					</li>
					<li class="nav-item">
						<a id="requestMenu" class="nav-link" href="#" onclick="openRequest();">의뢰하기</a>
					</li>
					
				</ul>
			</div>
			
			<div class="content-body">
				<!-- 콘텐츠가 담길 곳~
				 -->
				
					<div class="planner-main-container" display="none;">
							<!-- 0907) 플래너 불러오기 -->
							<div class="planner-container">
		
									<!-- 0908) 카드 출력 예시 -->
<%-- 		 							<div class="planner-result-card card">								
										<div class="my-planner-card">
											<img class="planner-card-img" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
											<div class="planner-info-container">
												<!-- 장소명  -->							
												<h5 class="card-title">Card title</h5>
												<!-- 0907) cat2를 기준으로 pasring해야 함 -->
												<p class="my-planner-summary">요약</p>
												<p class="my-planner-theme">테마</p>		
											</div>											
												<div class="planner-btn-container">
													<button type="button" class="btn btn-outline-primary btn-sm planner-info-btn">상세보기</button>												
												</div>												
										</div>								
									</div>  --%>
							</div>
					</div>
		
			<!-- content-body종료 시점 -->			
			</div>


			<!-- 의뢰하기 form페이지가 출력될 곳 -->			
			<!-- <div id="tempContainer"> -->
			<div class="request-container">

				<div class="request-title-container container">
					<p>${creator.memberId}님께 의뢰하기</p>
				</div>
				<form action="" method="post">
					
				</form>
			
			</div>

		</div>
	</div>
	
</section>

<script>

//프로필 이미지 출력 관련

		if(${creator.image.renamedFileName!=null}){

			async function getImg(){
				let response = await fetch("${path}/resources/member/profile/${creator.image.renamedFileName}");
				let blob = await response.blob(); //응답을 blob형태로 가져옴
				let img = document.createElement("img");
				const container = document.getElementById("myPic-container");
				container.append(img);
				container.append(document.createElement("hr"));
				img.className = "profileImg";
				img.src = URL.createObjectURL(blob);

			}
			
			getImg();
	
		}


//===================================================================================================================
//0912) PLANNER 불러오기	


			const openPlanner = ()=>{
				
				document.getElementsByClassName("request-container")[0].style.display="none";
				document.getElementsByClassName("content-body")[0].style.display="";
				document.getElementById("plannerMenu").classList.add("active");
				document.getElementById("requestMenu").classList.remove("active");
			}

			//1. 플래너 목록 불러오기
					
			const id = "${creator.memberId}";
			const contentBody = document.getElementsByClassName("content-body")[0];
			const plannerContainer = document.getElementsByClassName("planner-container")[0];  
			document.getElementsByClassName("request-container")[0].style.display="none";
			
				fetch('${path}/planner/loadPlanner.do', {
				  method: 'POST', 
				  headers: {
				    'Content-Type': 'application/json',
				  },
				  body: JSON.stringify({"memberId":id}),
				})
				.then((response) => response.json())
				.then((data) => {
				  		
					console.log("저장된 플래너 목록이 있습니까? ",data);
					
					if(data.length!=0){
						
						document.getElementsByClassName("planner-main-container")[0].style.display="";
						//document.getElementsByClassName("search-container")[0].style.display="flex";
						
					} else {
						document.getElementsByClassName("planner-main-container")[0].style.display="none";
						contentBody.innerText = "저장된 플랜이 없습니다 :(";
					}
					
					//플랜 출력하기 --------------------------------------------------------------------
					
					
						for(let i=0;i<data.length;i++){
						
								const plannerCard = document.createElement("div");
								plannerCard.classList.add("planner-result-card");
								plannerCard.classList.add("card");
								
								const myPlannerCard = document.createElement("div");
								myPlannerCard.classList.add("my-planner-card");
								
								//TODO이미지
								const plannerImg = document.createElement("img");
								plannerImg.classList.add("planner-card-img");
								
								if(data[i].img!=null){
									//저장된 썸네일이 존재하는 경우
									plannerImg.src= "${path}/resources/planner/thumbnail/"+data[i].img;
									
								} else { //없는 경우, 기본 이미지 출력
									plannerImg.src= "${path}/resources/img/traveller/traveller_noImg.png";
								}
								
		
								
								const plannerInfo = document.createElement("div");
								plannerInfo.classList.add("planner-info-container");
								
								const planTitle = document.createElement("h5");
								planTitle.classList.add("card-title");
								planTitle.innerText=data[i].plannerTitle;
								
								const plannerSummary = document.createElement("p");
								plannerSummary.classList.add("my-planner-summary");
								plannerSummary.innerText=data[i].summary;
								
								const theme = document.createElement("p");
								theme.classList.add("my-planner-theme");
								let themeData = data[i].theme;
								
								switch(themeData){
								
								case 'A0101' : theme.innerText="자연 관광지";break;
								case 'A0102' : theme.innerText="관광 자원";break;
								
								case 'A0201' : theme.innerText="역사";break;
								case 'A0202' : theme.innerText="휴양";break;
								case 'A0203' : theme.innerText="체험";break;
								case 'A0204' : theme.innerText="산업";break;
								case 'A0205' : theme.innerText="건축/조형";break;
								case 'A0206' : theme.innerText="문화시설";break;
								case 'A0207' : theme.innerText="축제";break;
								case 'A0208' : theme.innerText="공연/행사";break;
								
								case 'C0112' : theme.innerText="가족";break;
								case 'C0113' : theme.innerText="나홀로";break;
								case 'C0114' : theme.innerText="힐링";break;
								case 'C0115' : theme.innerText="도보";break;
								case 'C0116' : theme.innerText="캠핑";break;
								case 'C0117' : theme.innerText="맛";break;
								
								case 'A0301' : theme.innerText="레포츠 > 일반";break;
								case 'A0302' : theme.innerText="레포츠 > 육상";break;
								case 'A0303' : theme.innerText="레포츠 > 수상";break;
								case 'A0304' : theme.innerText="레포츠 > 항공";break;
								case 'A0305' : theme.innerText="레포츠 > 복합";break;
								
								case 'B0201' : theme.innerText="숙박";break;
								case 'A0401' : theme.innerText="쇼핑";break;
								case 'A0502' : theme.innerText="음식";break;
							
							
							}
								
								//구조 맞추기
								plannerInfo.append(planTitle);
								plannerInfo.append(plannerSummary);
								plannerInfo.append(theme);
								
								myPlannerCard.append(plannerImg);
								myPlannerCard.append(plannerInfo);
				
								//버튼 영역 > my-planner-card의 하위 태그 ----------------------------
								const plannerBtnContainer= document.createElement("div");
								plannerBtnContainer.classList.add("planner-btn-container");
								
								const infoBtn = document.createElement("button");
								infoBtn.classList.add("btn");
								infoBtn.classList.add("btn-outline-primary");
								infoBtn.classList.add("btn-sm");
								infoBtn.classList.add("planner-info-btn");
								infoBtn.innerText = "상세보기";
								
								//"상세보기" 버튼 클릭 시, 플랜 데이터 조회 가능
								const plannerNo = data[i].plannerNo;
								infoBtn.addEventListener("click",e=>{
									//alert("클릭! "+data[i].plannerTitle);
		
									location.assign("${path}/planner/plannerView/"+plannerNo);
									
								})
								
								plannerBtnContainer.append(infoBtn);						
								myPlannerCard.append(plannerBtnContainer);
								
								//----------------------------------------------------------------------
								plannerCard.append(myPlannerCard);
								
								
								plannerContainer.append(plannerCard);
						
											
					}				

					
					
					
					
					
					
					//-------------------------------------------------------------------------------
				});
						
						
				const openRequest = ()=>{
					
					document.getElementsByClassName("request-container")[0].style.display="";
					document.getElementsByClassName("content-body")[0].style.display="none";
					document.getElementById("plannerMenu").classList.remove("active");
					document.getElementById("requestMenu").classList.add("active");
				
				
				}		
			
			
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>