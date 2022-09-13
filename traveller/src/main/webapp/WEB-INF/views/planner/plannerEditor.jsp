<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />



<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>traveller</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link
	href="https://fonts.googleapis.com/css2?family=Work+Sans&display=swap"
	rel="stylesheet">
<!-- bootstrap css -->
<link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="${path}/resources/css/headerStyle.css" />
<link rel="stylesheet" type="text/css"
	href="${path }/resources/css/mapStyle.css" />
<link
	href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@1,800&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<%-- <script src="${path}/resources/js/bootstrap.js"></script> --%>
<script src="${path}/resources/js/jquery-3.6.0.min.js"></script>

<!-- 지도 관련 스크립트 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=LIBRARY"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services,clusterer,drawing"></script>

</head>

<body>
	<style>
.main-container {
	/* border:1px solid red; */
	/* margin-top : 50px; */
	display: flex;
	overflow: hidden;
	height: 100vh;
}

.editor-container {
	float: left;
	/* border: 1px solid blue; */
	width: 300px;
	background-color: #E6F0F8;
	padding: 10px;
	text-align: center;
}

.map-container {
	float: right;
	/* border:1px solid red; */
	width: 100%;
	margin-right: -300px;
	padding-right: 300px;
}

div.title-container {
	margin: 10px;
	margin-top: 10px;
	text-align: left;
}

.planner-container {
	/* border:1px solid red; */
	height: 75vh;
	overflow-y: scroll;
}

.planner-container::-webkit-scrollbar {
	display: none;
}

.btn-container {
	margin-top: 15px;
}

div#dropZone {
	/* border:1px solid blue; */
	padding: 25px;
}

.btn-controller {
	/* position:absolute; */
	left: 10px;
	display: flex;
	padding: 10px;
	background-color: rgba(255, 255, 255, 0.5);
}

.btn-controller button {
	margin: 2px;
}

.title-container {
	font-weight: 300;
}

.box_drag {
	background-color: rgba(255, 255, 255, 0.7);
	width: 248px;
	height: 30px;
	border-radius: 5px;
	margin-top: 3px;
	margin-bottom: 3px;
	margin-left: -12px;
	font-size: 13px;
	line-height: 30px;
	text-indent: 8px;
	text-align: left;
	display:flex;
}

.add-btn-container button{

	margin-left : 30px;

}

.add-btn-container{
	margin-bottom : 10px;
}
.weather-table th{
	vertical-align:middle;
	text-align:center;
}
.weather-table td{
	vertical-align:middle;
	text-align:center;
}
.daysColumn th{
	background-color:black;
	color:white;
}
.timeColumn td{
	background-color:#a0a0a0;
	color:black;
}
.my-likes-container{
	height:480px;
}

.my-likes-body{
	overflow:scroll;
}

.my-likes-body::-webkit-scrollbar {
	display: none;
}
.card-img{

	margin-right:30px;
	width:150px;
	height:150px;
/* 	border:1px solid red; */
	border-radius:10px;
}
.my-likes-card{
	display:flex;
}

.result-card{
	margin-top:10px;
}
.no-saved-place{
	margin-top:30px;
	text-align:center;
}
.card-title{
	font-weight:600;
}
.my-likes-address{
	margin-bottom:0px;
	font-size:13px;
}
.my-likes-theme{
	font-size:13px;
	margin-top:3px;
}
.my-likes-btn-container{
	display:flex;
	margin-top:30px;
	margin-left:90px;
}



</style>

	<section>
	
		<input type="hidden" id="tempAddrContainer">

		<div class="main-container">
			<div class="editor-container">
				<div class="title-container">${tempPlanner.plannerTitle}</div>
				<div class="planner-container">
					<div class="daysOpt input-group mb-3">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">여행일자</label>
						</div>
						<select class="custom-select" id="travelDaysOpt">
						</select>
					</div>

					<div id="dropZone">
					
					
<!-- 						<div id="p1" class="box_drag" draggable="true">
							<button id="forInfoBtn" type="button" class="btn btn-secondary btn-sm">+</button>	
							plan 1				
						</div>
						
						<div id="p1" class="box_drag" draggable="true">
							<button id="forInfoBtn" type="button" class="btn btn-secondary btn-sm">+</button>	
							plan 2				
						</div> -->


						
						<!-- 						

						드래그 앤 드롭 카드 출력 예시 

						<div id="p1" class="box_drag" draggable="true" >plan 1</div>
				        <div id="p2" class="box_drag" draggable="true" >plan 2</div>
				        <div id="p3" class="box_drag" draggable="true" >plan 3</div>
				        <div id="p4" class="box_drag" draggable="true" >plan 4</div>
				        <div id="p5" class="box_drag" draggable="true" >plan 5</div>
				        <div id="p6" class="box_drag" draggable="true" >plan 6</div>
				        <div id="p7" class="box_drag" draggable="true" >plan 7</div>  
				        
				        -->
				        
					</div>
				</div>
				<div class="btn-container">
					<button class="btn btn-primary" type="button" data-toggle="modal" data-target="#saveSchedule">작성 완료</button>
					<button class="btn btn-primary" type="button" data-toggle="modal" data-target="#deleteSchedule">작성 취소</button>
				</div>
			</div>
			<!-- 지도 영역 -->
			<div id="map" class="map-container">
				<!-- 이 영역에 지도가 출력될 것임 -->
			</div>


			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div>
						<h1 id="listTitle"
							style="text-align: left; padding: 10px; margin-bottom: 0px; margin-left: 5px; font-family: Rubik;">SEARCH!</h1>
						<form onsubmit="searchPlaces(); return false;" id="searchBox">
							<input type="text" value="" id="keyword" size="40"
								placeholder="검색어를 입력하세요">
							<button id="searchBtn" type="submit">검색하기</button>
						</form>
					</div>
				</div>
				<hr id="listLine">
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>

			<!-- 지도 관련 컨트롤러 -->
			<div class="btn-controller" style="left: 10px;">
				<button id="searchListBtn" class="btn btn-primary btn-sm"
					type="button" onclick="showList();">검색하기</button>
				<button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">나의 도구들</button>

				<!-- dropdown : 사용자 아이템 드롭다운 -->
				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					<a class="dropdown-item" onclick="myLikes();">나의 좋아요</a> 
 					<a class="dropdown-item" href="#">나의 그룹</a> 
					<a class="dropdown-item" href="#" onclick="showCkList();">나의 체크 리스트</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#" onclick="ckWeather();">날씨</a> 
<!-- 				<a class="dropdown-item" href="#">길 찾기</a> -->
				</div>
			</div>

		</div>
		<!-- 컨트롤러 관련 div 끝 -->


		<script>
			const showCkList = ()=>{
				
				//e.preventDefault();
				$("#ckList").modal('show');
				
			}
		</script>

		<!-- Modal : 체크 리스트 -->
		<div class="modal fade" id="ckList" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLongTitle">나의 체크 리스트</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					
						<div class="ck-title-container">
							나만의 여행 체크리스트를 확인해보세요
						</div>
						<div class="ck-content-container" style="margin-top:30px;">
							<button class="btn btn-primary" type="button"
								data-toggle="collapse" data-target="#collapseExample"
								aria-expanded="false" aria-controls="collapseExample">
								준비물
							</button>
							<div class="collapse" id="collapseExample">
								<div class="ckbox-main-container card card-body">
									<div class="add-btn-container" style="display:flex;">
									이번 여행에 필요한 준비물은 무엇이 있나요?
									<button type="button" class="btn btn-primary btn-sm" onclick="addCkBox();">추가하기</button>
									</div>
									<div class="ckbox-container input-group mb-3">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<input class="check-ck" type="checkbox" aria-label="Checkbox for following text input">
											</div>
										</div>
										<input type="text" class="form-control"
											aria-label="Text input with checkbox">
									</div>
								</div>
							</div>
						</div>
					
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary">저장하기</button>
						<button type="button" class="btn btn-primary">엑셀로 다운받기</button>
					</div>
				</div>
			</div>
		</div>


		<!-- Modal : 좋아요 -->
		<div class="modal fade" id="myLikes" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-height:1000px;">
				<div class="modal-content my-likes-container">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">${loginMember.memberId}님의 좋아요</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body my-likes-body">
					
						<div class="likes-opt-container">
							<select name="likesId" id="catList" class="custom-select">
								<option value="notOpt" selected disabled>-- 선택 --</option>
							</select>
							<p id="addAlarm" style="color:red; display:none;">좋아요 카테고리를 먼저 추가해주세요!</p>
						</div>


						<!-- 저장된 장소 정보가 없는 경우, 다음 안내 문구와 버튼이 화면에 출력됨 -->
						<div class="no-saved-place" style="display:none;">
							<p class="info-text" style="color: red;">저장된 장소가 없습니다! 나만의 장소를 추가해보세요!</p>
							<button type="button" class="btn btn-primary btn-sm" onclick="window.open('${path}/place/placesMain')">
								여행지 탐색하기
							</button>
						</div>

						<div class="likes-content-container cards-container">
						
							<!-- 카드가 출력되는 영역 -->

							<!-- 기본 출력 내용 -->
							

							<!-- 카드 출력 예시 -->
 							<div class="result-card card">								
								<div class="card-body my-likes-card">
									<img class="card-img" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
									<div class="likes-info-container">
										<!-- 장소명  -->							
										<h5 class="card-title">Card title</h5>
										<p class="my-likes-address" style="margin-bottom:0px;">주소</p>
										<!-- TODO0905) cat2를 기준으로 pasring해야 함 -->
										<p class="my-likes-theme">테마</p>
										
										<!-- 좌표 정보 -->
										<input type="hidden" class="likesX">
										<input type="hidden" class="likesY">
										
										<!-- 리스트에 장소 추가하기 -->
										<!-- <button type="button" class="btn btn-outline-primary myLikes-btn">추가하기</button> -->
										<div class="my-likes-btn-container" style="display:flex; margin-top:30px; margin-left:90px;">
										<button type="button" class="btn btn-outline-primary btn-sm infoBtn" style="margin-right:5px;">상세보기</button>
										<button type="button" class="btn btn-outline-primary btn-sm myLikes-btn">추가하기</button>
										</div>
									</div>													
								</div>								
							</div> 
							
					
							
						</div>					
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
					</div>
				</div>
			</div>
		</div>
		
		<script>
		
		/* 오버레이하면 전체가 하얗게 변하는 오류 발생  */
		
		
			/* "좋아요" 관련 로직 */
		
			let id = "${loginMember.memberId}";

			//1. 좋아요 목록 불러오기 -----------------------------------------------------------------------
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
						
						let opt = document.createElement("option");
						opt.innerText = e.likesTitle;
						opt.value= e.likesId;
						select.append(opt);
						
					});
				}
				
			});
			
			//2. 좋아요 장소 정보 불러오기 -----------------------------------------------------------------			
			//catList의 select option에서 선택한 항목에 해당하는 장소 카드 출력하기
			const heartsList = document.getElementById("catList");
			heartsList.addEventListener("change",e=>{
				
				const likesId = e.target.value;
				console.log("/////////////////",likesId);
				
				fetch('${path}/place/savedHearts.do', {
					  method: 'POST', 
					  headers: {
					    'Content-Type': 'application/json',
					  },
					  body: JSON.stringify({"likesId":likesId}),
					})
					.then((response) => response.json())
					.then((data) => {
						
						//option에 해당하는 장소 정보 가져오기
						console.log(data);
						
						//카드 출력되는 영역
						const cardContainer = document.getElementsByClassName("cards-container")[0];
						cardContainer.innerHTML="";

						
						const noSavedPlace = document.getElementsByClassName("no-saved-place")[0];
						
						if(data.length!=0){ //						
							//document.getElementsByClassName("search-container")[0].style.display="flex";
							noSavedPlace.style.display="none";
							
						} else {
							//document.getElementsByClassName("search-container")[0].style.display="none";
							//document.getElementsByClassName("no-saved-place")[0].style.display="";
							noSavedPlace.style.display="";
						}
						
						createCards(data);
						

						

					});
				
				
				
			});
			
			//카드 생성 함수
			const createCards = (data)=>{
				
				//카드 생성하기
				
				//1. 메인 콘테이너
				const container = document.getElementsByClassName("likes-content-container")[0];
				
				for(let i=0;i<data.length;i++){
					
					const resCard = document.createElement("div");
					resCard.classList.add("result-card");
					resCard.classList.add("card");
					
					const cardBody = document.createElement("div");
					cardBody.classList.add("card-body");
					cardBody.classList.add("my-likes-card");
					
					//이미지 출력
					const cardImg = document.createElement("img");
					cardImg.classList.add("card-img");
					if(data[i].firstImage!=null){
						cardImg.src = data[i].firstImage;
					} else { //카드 정보 부재 시, 기본 이미지 출력
						cardImg.src="${path}/resources/img/testPic/pikachu.png";
					}
					
					
					//제목, 버튼이 포함된 div
					const likesDiv = document.createElement("div");
					likesDiv.classList.add("likes-info-container");
					
					//제목
					const title = document.createElement("h5");
					title.classList.add("card-title");
					title.innerText = data[i].title;
					
					//주소
					const addr = document.createElement("p");
					addr.classList.add("my-likes-address");
					addr.innerText = data[i].address;
					//테마
					const likesTheme = document.createElement("p");
					likesTheme.classList.add("my-likes-theme");
					const themeData = data[i].cat2;
					
					switch(themeData){
					
					case 'A0101' : likesTheme.innerText="자연 관광지";break;
					case 'A0102' : likesTheme.innerText="관광 자원";break;
					
					case 'A0201' : likesTheme.innerText="역사";break;
					case 'A0202' : likesTheme.innerText="휴양";break;
					case 'A0203' : likesTheme.innerText="체험";break;
					case 'A0204' : likesTheme.innerText="산업";break;
					case 'A0205' : likesTheme.innerText="건축/조형";break;
					case 'A0206' : likesTheme.innerText="문화시설";break;
					case 'A0207' : likesTheme.innerText="축제";break;
					case 'A0208' : likesTheme.innerText="공연/행사";break;
					
					case 'C0112' : likesTheme.innerText="가족";break;
					case 'C0113' : likesTheme.innerText="나홀로";break;
					case 'C0114' : likesTheme.innerText="힐링";break;
					case 'C0115' : likesTheme.innerText="도보";break;
					case 'C0116' : likesTheme.innerText="캠핑";break;
					case 'C0117' : likesTheme.innerText="맛";break;
					
					case 'A0301' : likesTheme.innerText="레포츠 > 일반";break;
					case 'A0302' : likesTheme.innerText="레포츠 > 육상";break;
					case 'A0303' : likesTheme.innerText="레포츠 > 수상";break;
					case 'A0304' : likesTheme.innerText="레포츠 > 항공";break;
					case 'A0305' : likesTheme.innerText="레포츠 > 복합";break;
					
					case 'B0201' : likesTheme.innerText="숙박";break;
					case 'A0401' : likesTheme.innerText="쇼핑";break;
					case 'A0502' : likesTheme.innerText="음식";break;
				
				
				}

					//좌표
					const likesX = document.createElement("div");
					likesX.type="hidden";
					likesX.classList.add("likesX");
					likesX.value=data[i].mapx;
					
					const likesY = document.createElement("div");
					likesY.type="hidden";
					likesY.classList.add("likesY");
					likesY.value=data[i].mapy;
					
					cardBody.append(cardImg);
					
					likesDiv.append(title);
					likesDiv.append(addr);
					likesDiv.append(likesTheme);
					likesDiv.append(likesX);
					likesDiv.append(likesY);
					
					
					//버튼
					const likesBtnContainer = document.createElement("div");
					likesBtnContainer.classList.add("my-likes-btn-container");
					
					const likesBtn = document.createElement("button");
					likesBtn.classList.add("btn");
					likesBtn.classList.add("btn-outline-primary");
					likesBtn.classList.add("btn-sm");
					likesBtn.classList.add("myLikes-btn");
					likesBtn.innerText = "추가하기";
					
					
					//"추가하기" 클릭 시, 플래너 에디터 리스트에 장소 카드 추가
					likesBtn.addEventListener("click",e=>{
						
						//0906) 리스트에 추가하기
						addLikesToList(data[i].mapy,data[i].mapx,data[i].title);
						
					});
					
					
					const infoBtn = document.createElement("button");
					infoBtn.classList.add("btn");
					infoBtn.classList.add("btn-outline-primary");
					infoBtn.classList.add("btn-sm");
					infoBtn.classList.add("infoBtn");
					infoBtn.innerText = "상세보기";
					
					
					//"상세보기" 클릭 시, 장소 상세 페이지가 열리도록
					const contentId = data[i].contentId;
					infoBtn.addEventListener("click",e=>{
						
						window.open("${path}/place/placeView/"+contentId);
						
						
						
						
					});
					
					
					likesBtnContainer.append(infoBtn);
					likesBtnContainer.append(likesBtn);
					
					likesDiv.append(likesBtnContainer);
					
					
					cardBody.append(likesDiv);
					resCard.append(cardBody);
					container.append(resCard);
					
					
					
				}
				
				
				
				
			}
			
			
			
			
			
			/* 0906 "좋아요" 리스트에 추가하기! */
			
			
			
			const addLikesToList = (latitude,longitude,title)=>{
				
				//alert(lat,lng);
				//===================================================================================
					
					
				clearDragEvent();
				       	
				const lat = latitude;
				const lng = longitude;
			 	const placeName = title;
			 	
			 	//const memo = document.getElementById("memo").value;			 	
				//console.log("위도 : ",lat,"경도 : ",lng,"타이틀 : ",placeName,"메모 : ",memo);
			
				//장소 카드 생성해, 플랜 리스트에 추가하기 -----------------------------------
				const dropZone = document.getElementById("dropZone");
				
				const addPlan = document.createElement("div"); //div생성하기
				addPlan.classList.add("box_drag");
				addPlan.setAttribute("draggable",true);
				
			
				//index를 식별하기 위해, 현재 dropZone에 자식 태그들이 몇 개 있는지 확인하기	
				
				const cards = document.querySelectorAll("div#dropZone div");
				console.log("현재 카드 개수 : ",cards.length);
				let tempNo = cards.length+1;
				addPlan.id="p"+tempNo;
				
				dropZone.insertAdjacentElement("beforeend",addPlan);
				addDragEvent();
				
				console.log(addPlan);
				//dropZone.append(document.createElement("button"));
				
				addPlan.innerText = placeName;
				//-------------------------------------------------------------------
			
				//장소 카드의 "속성"을 새로 생성해, 해당 장소의 정보를 저장하기--------------------
				
				addPlan.setAttribute("id",addPlan.id);
				addPlan.setAttribute("placeName",placeName);
				addPlan.setAttribute("latitude",lat);
				addPlan.setAttribute("longitude",lng);
				addPlan.setAttribute("memo",""); //memo는 없음
		
				//deletePlace(addPlan); //더블클릭 시, 편집 시점에 생성된 마커와 카드가 삭제됨
				//deletePlaceMarker(addPlan);
				moveMap(addPlan);
				printInfo(addPlan);	
				
				//====================================================================================
				
				//0906 ) 마커 추가하기
				//1. addMarkerFunc()
				addMarkerFunc(latitude,longitude,title);
				
				//=====================================================================================
				//TODO 0912) lat, lng정보 토대로 "주소"정보 가져오기
				
				
				
			}
			

/* 			function getAddress(lat,lng){
				
			    let geocoder = new kakao.maps.services.Geocoder();
			    let coord = new kakao.maps.LatLng(lat, lng);
			    let addrTemp = "";
			    let arr = [];
			    
				    let callback = function(result, status,addressArr) {
				        if (status === kakao.maps.services.Status.OK) {
				            //console.log(result);
				            addrTemp = result[0]['address']['address_name'];
				            console.log("주소 확인 : ", addrTemp);
				            arr.push(addrTemp);
				            
				        }
				    };

			    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
				return arr;
			}
			
			let hypeboy = "";
			hypeboy = getAddress('35.62423567800049','126.46606410122298')[0];
			console.log("hypeboy : ",hypeboy); */
			
			
			
			

		
			
			
		
		
		
		
		
		
		</script> 
		
		
		


		<!-- Modal : 리스트 카드 클릭 시 출력될 것 -->
		<div id="addedPlace" class="modal fade" id="exampleModalCenter"
			tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content" style="">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLongTitle">리스트에 추가된 장소</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="container">
							<div id="placeTitle" style="font-size: 25px; margin-bottom: 2px;">장소명</div>
							<div id="placeAddr" style="margin-bottom: 25px;">주소</div>
							<input id="placeLat" type="hidden">
							<input id="placeLng" type="hidden">
							<input id="cardId" type="hidden">
							<div style="align-items: center;">
								<input id="placeMemo" style="width: 259px; border-radius: 7px;">
								<button id="updateMemo" type="button"
									class="btn btn-primary btn-sm"
									style="margin-left: 10px; margin-bottom: 4px;">메모 수정하기</button>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">닫기</button>
						<button id="delPlace" type="button" class="btn btn-outline-danger">삭제하기</button>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- Modal 지도에 클릭해서 생성한 마커 관련 설정하기 -->
		<div class="modal fade" id="plusMarker" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">나만의 장소 추가하기</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
							<input id="myTitle" style="font-size: 25px; margin-bottom: 2px; border-radius: 7px; " placeholder="장소명을 입력하세요" required>
							<div id="myAddr" style="margin-bottom: 25px;">주소</div>
							<input id="myLat" type="hidden">
							<input id="myLng" type="hidden">
							<input id="myId" type="hidden">
							<div style="align-items: center;">
								<input id="myMemo" style="font-size: 15px; margin-bottom: 2px; width:295px; border-radius: 7px; " placeholder="메모를 입력하세요">
								<!-- <input id="placeMemo" style="width: 259px; border-radius: 7px;" placeholder="메모를 입력하세요"> -->
							</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button id="addListBtn" type="button" class="btn btn-primary" onclick="addMyPlace()">리스트에 추가하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal : 날씨 관련 -->
		<div class="modal fade" id="checkWeather" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width:1200px;">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle" style="font-weight:500">날씨 예보</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        ※ 기상청 제공 : 중기 예보 <br> (금일로부터 최대 10일 이후까지의 날씨 예보를 확인해보세요)
		        <br>
		        <div class="weather-title-container" style="display:flex; float:right;">
			        <p style="margin-bottom:0px;">기상예보 발표일시 : </p>
			        <div id="todayDate">
			        	<!-- 오늘의 날씨가 출력될 영역 -->
			        </div>		        
		        </div>
		        <div class="weather-info-container">

					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<label class="input-group-text" for="inputGroupSelect01">지역</label>
						</div>
						<select class="custom-select" id="weatherArea" onclick="createAreaOption();">
							<option selected disabled>-- 선택 --</option>
							<option value="11B00000">서울/인천/경기도</option>
							<option value="11H20000">부산.울산.경상남도</option>
							<option value="11H10000">대구.경상북도</option>
							<option value="11F20000">광주.전라남도</option>
							<option value="11F10000">전라북도</option>
							<option value="11C20000">대전.세종.충청남도</option>
							<option value="11C10000">충청북도</option>
							<option value="11D10000">강원도 영서</option>
							<option value="11D20000">강원도 영동</option>
							<option value="11G00000">제주도</option>
						</select> 
						<!-- 0828 중기육상예보 관련 지역 옵션이 다음과 같이 세분화되지 않음을 확인 -->
<!-- 						<select class="custom-select" id="weatherArea" onclick="createAreaOption();">
							<option selected disabled>-- 선택 --</option>
							<option value="1">서울/인천/경기도</option>
							<option value="2">부산.울산.경상남도</option>
							<option value="3">대구.경상북도</option>
							<option value="4">광주.전라남도</option>
							<option value="5">전라북도</option>
							<option value="6">대전.세종.충청남도</option>
							<option value="7">충청북도</option>
							<option value="8">강원도</option>
							<option value="9">제주도</option>
						</select>  -->
						<select
							class="custom-select sigungu-class"
							name="sigunguCode" id="weatherArea2" required>
							<option value="0" selected disabled>-- 선택 --</option>
						</select>
					</div>
					<div class="weathet-btn-container" style="float:right;margin-bottom:10px;">
						<button type="button" class="btn btn-primary btn-sm" onclick="weatherInfo();">선택한 지역의 날씨 확인하기</button>
					</div>
				</div>
				<!-- 표 형식으로 구성하기 -->
		        <div class="weather-table-container" style="display:none;">


					<table class="weather-table table table-bordered">
						<tbody>
							<tr class="daysColumn">
								<th id="day3" scope="col" colspan=2 style="text-align:center;vertical-align:middle;">3일 후</th>
								<th id="day4"  scope="col" colspan=2 style="text-align:center;vertical-align:middle;">4일 후</th>
								<th id="day5"  scope="col" colspan=2 style="text-align:center;vertical-align:middle;">5일 후</th>
								<th id="day6"  scope="col" colspan=2>6일 후</th>
								<th id="day7"  scope="col" colspan=2>7일 후</th>
								<th id="day8"  scope="col" rowspan=2>8일 후</th>
								<th id="day9"  scope="col" rowspan=2>9일 후</th>
								<th id="day10"  scope="col" rowspan=2>10일 후</th>
							</tr>
							<tr class="timeColumn">
							    <td>오전</td>
							    <td>오후</td>
							    <td>오전</td>
							    <td>오후</td>
							    <td>오전</td>
							    <td>오후</td>
							    <td>오전</td>
							    <td>오후</td>
							    <td>오전</td>
							    <td>오후</td>
							</tr>
							<!-- 중기육상예보조회 -->
							<tr>
							    <td id="wf3Am">오전날씨</td>
							    <td id="wf3Pm">오후날씨</td>
							    <td id="wf4Am">오전날씨</td>
							    <td id="wf4Pm">오후날씨</td>
							    <td id="wf5Am">오전날씨</td>
							    <td id="wf5Pm">오후날씨</td>
							    <td id="wf6Am">오전날씨</td>
							    <td id="wf6Pm">오후날씨</td>
							    <td id="wf7Am">오전날씨</td>
							    <td id="wf7Pm">오후날씨</td>
							    <td id="wf8">날씨</td>
							    <td id ="wf9">날씨</td>
							    <td id="wf10">날씨</td>
						    </tr>
						    
						    <tr>
						    	<td colspan=20 style="text-align:left;">최저/최고기온(℃)</td>
						    </tr>
						    
						    <!-- 중기기온조회 -->
						    <tr>
						    	<td id="ta3" colspan=2></td>			    
						    	<td id="ta4" colspan=2></td>			    
						    	<td id="ta5" colspan=2></td>			    
						    	<td id="ta6" colspan=2></td>			    
						    	<td id="ta7" colspan=2></td>			    
						    	<td id="ta8" ></td>			    
						    	<td id="ta9" ></td>			    
						    	<td id="ta10" ></td>			    
						    </tr>
						    
							</tbody>
					</table>
							
				</div>
		        
		        
		      </div>
<!-- 		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		      </div> 
		    </div> -->
		  </div>
		</div>



	</section>
	


	<script>
	
	//나의 도구들 > 날씨 정보 ====================================
	
	function getToday(){ //오늘 날짜 yyyyMMdd0600 형식으로 가져오기
		
		let date = new Date();
		let year = date.getFullYear();
		let month = ("0"+(1+date.getMonth())).slice(-2);
		let day = ("0"+date.getDate()).slice(-2);
		
		return year+month+day+'0600'; //중기 예보 파악을 위해 06시로 시간 대를 고정함
		
	}
	

	
	//지역구성하기, 날씨 정보 출력하기
	const createAreaOption=()=>{
		
		//지역옵션생성관련로직
		const cat1=document.getElementById("weatherArea");
		const cat2=document.getElementById("weatherArea2");
		
		cat1.addEventListener("change",e=>{
			
			if(e.target.value=='11B00000'){//서울,인천,경기도
				
				let sudo=["서울","인천","수원","성남","안양","광명","과천","평택","오산","의왕","용인",
						"군포","안성","화성","양평","구리","남양주","하남","이천","여주","광주","의정부"
						,"고양","파주","양주","동두천","연천","포천","가평","강화","김포","시흥","부천",
						"안산","백령도"];
				let sudoCode=["11B10101","11B20201","11B20601","11B20605","11B20602","11B10103","11B10102","11B20606","11B20603","11B20609","11B20612",
							"11B20610","11B20611","11B20604","11B20503","11B20501","11B20502","11B20504","11B20701","11B20703","11B20702","11B20301"
							,"11B20302","11B20305","11B20304","11B20401","11B20402","11B20403","11B20404","11B20101","11B20102","11B20202","11B20204",
							"11B20203","11A00101"];
				createOpt(sudo,sudoCode);
	
			}
			
			if(e.target.value=='11H20000'){//부산.울산.경상남도
				
				let kn=["부산","울산","김해","양산","창원","밀양","함안","창녕","의령","진주","하동","사천",
						"거창","합천","산청","함양","통영","거제","고성","남해"];
				let knCode=["11H20201","11H20101","11H20304","11H20102","11H20301","11H20601","11H20603","11H20604","11H20602","11H20701","11H20704","11H20402"
							,"11H20502","11H20503","11H20703","11H20501","11H20401","11H20403","11H20404","11H20405"];
				createOpt(kn,knCode);
			}
			
			if(e.target.value=='11H10000'){//대구.경북
				
				let kb=["대구","영천","경산","청도","칠곡","김천","구미","군위","고령","성주","안동","의성","청송","상주","문경","예천","영주","봉화","영양","울진","영덕","포항","경주","울릉도","독도"];
				let kbCode=["11H10701","11H10702","11H10703","11H10704","11H10705","11H10601","11H10602","11H10603","11H10604","11H10605","11H10501","11H10502","11H10503","11H10302","11H10301","11H10303","11H10401","11H10402","11H10403","11H10101","11H10102","11H10201","11H10202","11E00101","11E00102"];
				createOpt(kb,kbCode);
			}
			
			if(e.target.value=='11F20000'){//광주.전남
				
				let jn=["광주","나주","장성","담양","화순","영광","함평","목포","무안","영암","진도","신안","흑산도	","순천","광양	"
					  ,"구례","곡성","완도","강진","장흥","해남","여수","고흥","보성"];
				let jnCode=["11F20501","11F20503","11F20502","11F20504","11F20505","21F20102","21F20101","21F20801","21F20804","21F20802","21F20201","21F20803","11F20701","11F20603","11F20402"
						,"11F20601","11F20602","11F20301","11F20303","11F20304","11F20302","11F20401","11F20403","11F20404"];
				createOpt(jn,jnCode);
			}
			if(e.target.value=='11F10000'){ //전북
				let jb = ["전주","익산","군산","정읍","김제","남원","고창","무주","부안","순창","완주","임실","장수","진안"];
				let jbCode = ["11F10201","11F10202","21F10501","11F10203","21F10502","11F10401","21F10601","11F10302","21F10602","11F10403","11F10204","11F10402","11F10301","11F10303"]; 
				createOpt(jb,jbCode);
			}
			if(e.target.value=='11C20000'){ //대전.세종.충남
				let cn = ["대전","세종","공주","논산","계룡","금산","천안","아산","예산","서산","태안","당진","홍성","보령","서천","청양","부여"];
				let cnCode = ["11C20401","11C20404","11C20402","11C20602","11C20403","11C20601","11C20301","11C20302","11C20303","11C20101","11C20102","11C20103","11C20104","11C20201","11C20202","11C20502","11C20501"];
				createOpt(cn,cnCode);
			}
			if(e.target.value=='11C10000'){ //충북
				let cb = ["청주","증평","괴산","진천","충주","음성","제천","단양","보은","옥천","영동","추풍령"];
				let cbCode = ["11C10301","11C10304","11C10303","11C10102","11C10101","11C10103","11C10201","11C10202","11C10302","11C10403","11C10402","11C10401"];
				createOpt(cb,cbCode);
			}
			if(e.target.value=='11D10000'||e.target.value=='11D20000'){ //강원
				let gw = ["철원","화천","인제","양구","춘천","홍천","원주","횡성","영월","정선","평창","대관령","속초","고성","양양","강릉","동해","삼척","태백"];
				let gwCode = ["11D10101","11D10102","11D10201","11D10202","11D10301","11D10302","11D10401","11D10402","11D10501","11D10502","11D10503","11D20201","11D20401","11D20402","11D20403","11D20501","11D20601","11D20602","11D20301"]; 
				createOpt(gw,gwCode);
			}
			if(e.target.value=='11G00000'){ //제주
				let jj = ["제주","서귀포","성산","고산","성판악","이어도","추자도"];
				let jjCode = ["11G00201","11G00401","11G00101","11G00501","11G00302","11G00601","11G00800"];
				createOpt(jj,jjCode);
			}
			
			
		});
		
		
		function createOpt(cat, catCode){
			
			cat2.innerHTML = ""; //select 옵션 영역 초기화
			
			for(let i=0;i<cat.length;i++){ //option 생성하기
				
				let opt = document.createElement("option");
				opt.innerText = cat[i];
				opt.value = catCode[i];
				cat2.appendChild(opt);
				
			}
			
			
		}
	
	}
	
	const weatherInfo = () => {
		
		
		//선택하지 않은 경우, 알림창!
		let flag = document.getElementById("weatherArea").value;
		console.log("flag? ",flag);
		if(flag=='-- 선택 --'){
			alert('먼저 지역을 선택해주세요');
			table.style.display="none";
		}
		

		//일자 출력하기
		for(let i=3;i<=10;i++){
			
			let todayDate = new Date();
			let addDay = new Date();
			
			todayDate.setDate(addDay.getDate()+i);
			
			document.getElementById("day"+i).innerText 
			//= todayDate.toLocaleString();
			= todayDate.getMonth()+1+"/"+todayDate.getDate();
			
		}
		
		
		//---------------------------------------------------------------------------
		
		const table = document.getElementsByClassName("weather-table-container")[0];
		
		if(table.style.display="none"){
			table.style.display="block";
		} else {
			table.style.display="none";
		}
		
		//선택한 지역 코드 가져오기
		let areaCode = document.getElementById("weatherArea").value;
		
		//오늘 날짜 가져오기
		//TODO 0826) 만약에 클라이언트가 당일 오전 6시 이전에 날씨를 확인할 경우... 예외 처리하기
		let today = getToday();
		console.log("날짜 확인하기 : ",getToday());
		
		//기상청API 활용하기
		//1. 중기육상예보 조회
/* 		const url = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst"
			        +"?serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D"
					+"&pageNo=1"
					+"&numOfRows=10"
					+"&dataType=JSON"
					+"&regId="+areaCode
					+"&tmFc="+today; */
		
		console.log("지역 ",areaCode);
					
					
		const url = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst?"
				    +"serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D"
				    +"&pageNo=1&numOfRows=10&dataType=json"
				    +"&regId="+areaCode
				    +"&tmFc="+today;			
					
					
			
		fetch(url)
		.then(res=>res.json())
		.then(myJson=>{
			console.log("날씨",myJson.response.body.items.item[0]); //유효한 정보 가져오기
			//console.log("날씨",myJson); //유효한 정보 가져오기
			
			//3일 후
			document.getElementById("wf3Am").innerText = myJson.response.body.items.item[0].wf3Am;
			document.getElementById("wf3Am").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt3Am+"%";
			document.getElementById("wf3Pm").innerText = myJson.response.body.items.item[0].wf3Pm;
			document.getElementById("wf3Pm").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt3Pm+"%";
			//4일 후
			document.getElementById("wf4Am").innerText = myJson.response.body.items.item[0].wf4Am;
			document.getElementById("wf4Am").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt4Am+"%";
			document.getElementById("wf4Pm").innerText = myJson.response.body.items.item[0].wf4Pm;
			document.getElementById("wf4Pm").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt4Pm+"%";
			//5일 후
			document.getElementById("wf5Am").innerText = myJson.response.body.items.item[0].wf5Am;
			document.getElementById("wf5Am").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt5Am+"%";
			document.getElementById("wf5Pm").innerText = myJson.response.body.items.item[0].wf5Pm;
			document.getElementById("wf5Pm").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt5Pm+"%";
			//6일 후
			document.getElementById("wf6Am").innerText = myJson.response.body.items.item[0].wf6Am;
			document.getElementById("wf6Am").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt6Am+"%";
			document.getElementById("wf6Pm").innerText = myJson.response.body.items.item[0].wf6Pm;
			document.getElementById("wf6Pm").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt6Pm+"%";
			//7일 후
			document.getElementById("wf7Am").innerText = myJson.response.body.items.item[0].wf7Am;
			document.getElementById("wf7Am").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt7Am+"%";
			document.getElementById("wf7Pm").innerText = myJson.response.body.items.item[0].wf7Pm;
			document.getElementById("wf7Pm").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt7Pm+"%";
			//8일 후
			document.getElementById("wf8").innerText = myJson.response.body.items.item[0].wf8;
			document.getElementById("wf8").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt8+"%";
			//9일 후
			document.getElementById("wf9").innerText = myJson.response.body.items.item[0].wf9;
			document.getElementById("wf9").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt9+"%";
			//10일 후
			document.getElementById("wf10").innerText = myJson.response.body.items.item[0].wf9;
			document.getElementById("wf10").innerHTML += "<br>"+myJson.response.body.items.item[0].rnSt9+"%";

			
			
			
		});
		
		//2. 중기기온조회 (세분화된 범주 필요) ---------------------------------------------------------------------
		
		let areaCode2 = document.getElementById("weatherArea2").value;
		
/* 		const urlforTemp = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?"
							+"serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D"
							+"&pageNo=1&numOfRows=10&dataType=JSON"
							+"&regId="+areaCode2;
							+"&tmFc="+today; */
		
		const urlforTemp = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&"
						   +"regId="+areaCode2
						   +"&tmFc="+today;
		
		fetch(urlforTemp)
		.then(res=>res.json())
		.then(data=>{
			
			console.log("중기기온조회 : ",data.response.body.items.item[0]);
			
			for(let i=3;i<=10;i++){
				
				let temp = data.response.body.items.item[0];
				document.getElementById("ta"+i).innerHTML = "<span style='color:blue;'>"+temp[("taMin"+i)]+"</span> / <span style='color:red;'>"+temp[("taMax"+i)]+"</span>";
				
			}
			
		});
		
		
		
	}
	
	
		
	const ckWeather = ()=>{ //기상청 중기예보 API 활용하기
		
		//모달 열기
		$('#checkWeather').modal('show');
	
		//오늘의 날짜
		const today = document.getElementById("todayDate");
		console.log("오늘 날짜 : ",getToday());
		today.innerText = getToday();

	}
	
	//나의 도구들 > "좋아요" ===============================================================
	const myLikes = ()=>{
		
		//모달 열기
		$("#myLikes").modal("show");
		
		
	}
	
	
	//나의 도구들 > 체크 리스트 구성하기 ====================================================================================================================
	
	const addCkBox = ()=>{
		
		const mainContainer = document.getElementsByClassName("ckbox-main-container")[0];
		
		//0. 체크박스 세트 컨테이너 만들기
		const container = document.createElement("div");
		container.classList.add("ckbox-container");
		container.classList.add("input-group");
		container.classList.add("mb-3");
		
		//1. 체크박스 만들기
		const divBox = document.createElement("div");
		divBox.classList.add("input-group-prepend");
		
		const grayBox = document.createElement("div");
		grayBox.classList.add("input-group-text");
		
		
		const ckBox = document.createElement("input");
		ckBox.classList.add("check-ck");
		ckBox.setAttribute("type","checkbox");
		ckBox.setAttribute("aria-label","Checkbox for following text input");
		
		divBox.append(grayBox);
		grayBox.append(ckBox);
		container.append(divBox);
		
		//2. input박스 만들기
		const inputBox = document.createElement("input");
		inputBox.setAttribute("type","text");
		inputBox.classList.add("form-control");
		inputBox.setAttribute("aria-label","Text input with checkbox");
		
		container.append(inputBox);
		mainContainer.append(container);


		
	}
	
	//체크박스 체크 시 글자에 선 긋기
	//TODO0825) 저장 관련 작업은 데이터베이스 서버 재배정되면 재개할 것
	const ckBoxSet = document.getElementsByClassName("check-ck");
	console.log("체크 박스 몇 개? : ",ckBoxSet.length);
	
	for(let i=0;i<ckBoxSet.length;i++){
		
		ckBoxSet[i].addEventListener("change",e=>{
			
			let targetText = e.target.parentElement.parentElement.nextElementSibling;
			
			if(e.target.checked){ //체크된다면
				
				targetText.style.textDecorationLine='line-through'; //취소선 그리기
				
			} else {
				targetText.style.textDecorationLine=''; //취소선 삭제하기
			}

		})
	
	}
	

	
	
	//플래너 기본 구성 관련 함수들 ===========================================================================================================================
		
		(()=>{
			
			//● 사용자 입력 값 토대로 기본 검색창 결과 구성하기
			const tempItem = ${tempPlanner.areaCode};
			let searchItem = "";
			
			switch(tempItem){
			
			case 1 : searchItem="서울";break;
			case 2 : searchItem="인천";break;
			case 3 : searchItem="대전";break;
			case 4 : searchItem="대구";break;
			case 5 : searchItem="광주";break;
			case 6 : searchItem="부산";break;
			case 7 : searchItem="울산";break;
			case 8 : searchItem="세종특별자치시";break;
			case 31 : searchItem="경기도";break;
			case 32 : searchItem="강원도";break;
			case 33 : searchItem="충청북도";break;
			case 34 : searchItem="충청남도";break;
			case 35 : searchItem="경상북도";break;
			case 36 : searchItem="경상남도";break;
			case 37 : searchItem="전라북도";break;
			case 38 : searchItem="전라남도";break;
			case 39 : searchItem="제주도";break;
			
			}
			
			document.getElementById("keyword").value= searchItem;
			
		})();
	

		//● 사용자 입력 값 토대로 옵션 구성하기
		const daysOption = document.getElementById("travelDaysOpt");
		
		const inputDays = ${tempPlanner.travelDays};
		
		for(let i=1;i<=inputDays;i++){
			const opt = document.createElement("option");
			opt.value=i;
			opt.innerText=i;
			daysOption.append(opt);
		}
		
	
		//● "사용자 편의 콘테이너" 기능 관련 함수들
		const showList = (()=>{ //"검색하기" 버튼 클릭 時, "검색 리스트"가 보이거나, 보이지 않도록 구현함
	
		const searchList = document.getElementById("menu_wrap");
	
	 	let cnt = 1;
		return()=>{
			
			if(++cnt%2!=0){
				searchList.style.display="";
			} else {
				searchList.style.display="none";
			}
			
		}
		
		})();
		
		//기타 오류 대처 ----------------------------------------------------------------------------------------
		window.onbeforeunload = (e)=>{
			
			//TODO0815 화면이 전환될 경우에는...
			localStorage.clear(); //로컬 스토리지에 저장된 내용 제거하기
		
		}
	
	//플래너 리스트 관련 함수들 ==============================================================================================================================
	//옵션 변경 관련 기능

	/*
		○ 저장 내용 불러오기
		1. 카드, 선 불러오기
		2. 저장 내용을 편집할 경우에는, 해당 선을 토대로 실시간으로 이어주는 함수 새로 만들어야 함
		
		○ (해당 옵션에 저장된 데이터가 없다면) 새로운 편집 페이지 열어주기
		1. 카드, 선 리셋하기
	
	*/
	
	
	//1. 불러오기 관련 로직 -------------------------------------------------------------------------------------------
	
	

	let myMarkers = []; //편집 중에 클라이언트가 리스트에 추가할 마커 관련 배열 (전역에서 사용하기 위해서 여기에 선언함...)
	
	//● 공통함수 : printMyLog() => 옵션 변경으로 선택한 일자에 저장된 이정이 존재한다면, 해당 정보 불러오기!
	const thisDay = document.querySelector("#travelDaysOpt>option").value;
	let markersArr = []; //* (저장된 내용을 기반으로) 앞으로 생성될 마커들을 저장할 배열
	
	function printMyLog(myLog, logArr){ //공통 function : 저장 이력 출력하기
	//매개변수?
	//myLog : localStorage에 JS객체로서 일자별 일정이 저장된 데이터의 배열
	//logArr : localStorage로부터 추출한 좌표 정보 (printMyLog함수에서 가공해서 저장할 것임)
		
		for(let i=0;i<myLog.length;i++){ //card의 개수 만큼 반복
			
			//1. 마커 출력하기
			//마커 생성부터
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(36, 37); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: new kakao.maps.LatLng(myLog[i].latitude, myLog[i].longitude), //사용자의 저장 기록을 토대로 마커 위치를 설정함
		        title : myLog[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다 (TODO0815 표시 안 됨)
		        image : markerImage // 마커 이미지 
		    });
		    

		    
		    infoOverlay(marker); //마커 클릭 시, 커스텀 오버레이 출력할 것임
		    
		    //마커 간 선으로 연결하기 위해, 각 배열 (logArr, markersArr에 저장하기)
		    //logArr : 
		    //markersArr : 
			logArr.push(new kakao.maps.LatLng(myLog[i].latitude, myLog[i].longitude));
		    markersArr.push(marker); //이전에 저장됐던 마커들을 저장함. 이를 기반으로 쭉쭉 새로운 마커들을 추가해 나갈 수도 있음!
	
		}
	
		
	
		//마커 간 선 연결하기
	    // 지도에 표시할 선을 생성합니다
	    var polyline = new kakao.maps.Polyline({
	        path: logArr, //logArr을 기준으로 출력할 것임 (logArr : 이전에 저장한 마커의 배열 !=markersArr : 이전에 저장한 마커+앞으로 편집을 통해 추가할 마커들이 저장될 배열)
	        strokeWeight: 5, 
	        strokeColor: '#e61919',
	        strokeOpacity: 0.7, 
	        strokeStyle: 'solid', 
	        endArrow:'true' //화살표 표시할 것임
	    });

	    // 지도에 선을 표시합니다 
	    polyline.setMap(map);
    	markersArr.forEach(e=>{
    		e.setMap(map);
    	})
	    
	    daysOption.addEventListener("change",e=>{
	    	    	
	    	polyline.setMap(null);
	    	markersArr.forEach(e=>{
	    		e.setMap(null);
	    	})

	    });
	    
	    
	    changeRed(polyline,logArr,myMarkers); //변동상황 발생 시, poly라인 재조정하기

	} //printMyLog함수 종료
	
	//let flag = false;
	function changeRed(line,arr,myMarkers){
	//매개변수
	//line, arr : (삭제/수정)내용 반영해 빨간 선 그리기 관련
	//myMarkers : drawLines()관련, 차후 편집 내용 적용될 배열 또한 수정해야 함
		
		let cards = document.querySelectorAll("div#dropZone>div");
		console.log("변경 전! : 이벤트 적용 대상 : ",cards);
		
		
		//1. 카드 삭제 (더블 클릭) ========================================================================================================================
		
		[].forEach.call(cards,function(card){
			card.addEventListener("dblclick",click,false);
		});
		
		function click(e){
			
			let changedCards = document.querySelectorAll("div#dropZone>div"); //이벤트 적용 대상 설정하기
		
			let tempArr = [];	
			let forStorage = [];
			
			
			changedCards.forEach(v=>{ //더블 클릭-> 삭제되어 재구성된 카드 토대로 path[] 내용 재구성하기
				
				console.log("카드 리스트 구성 확인하기 ",v);
				let lat = v.getAttribute('latitude');
				let lng = v.getAttribute('longitude');
				let key = v.getAttribute('day');
				console.log("key확인 : ",key);
				
				tempArr.push(new kakao.maps.LatLng(lat,lng));
				
				//-------------------------------------------------------------------------
				//localStorage에 수정 내용 저장하기...
				
				//생성자 함수로 "장소"객체 생성 후, 배열arr에 저장하기
				function Places(day,id,placeName,latitude,longitude,memo){ //생성자 함수 : 장소 정보 저장 객체
					
					this.day = day;
					this.id = id;
					this.placeName = placeName;
					this.latitude = latitude;
					this.longitude = longitude;
					this.memo = memo;			
					
				}
				
				forStorage.push(new Places(							
											

											v.getAttribute("day"),
											
											v.getAttribute("id"),
											v.getAttribute("placeName"),
								            v.getAttribute("latitude"),
								            v.getAttribute("longitude"),
								            v.getAttribute("memo")));
	
				console.log("카드 리스트 확인하기 : ",forStorage);
				
				
					localStorage.removeItem(key); //기존 저장 값은 삭제
					localStorage.setItem(key,JSON.stringify(forStorage));
				
				
				//--------------------------------------------------------------------------
			
			});
		
				arr = tempArr.slice();		

				line.setMap(null); //기존의 선은 없애기
				
	    		line = new kakao.maps.Polyline({ //새로운 선 구성하기
	            path: arr, //새로운 내용 반영한 배열 적용하기
	            strokeWeight: 5, 
	            strokeColor: '#e61919',
	            strokeOpacity: 0.7, 
	            strokeStyle: 'solid', 
	            endArrow:'true'
	    	    });
	        	
	    		line.setMap(map); //수정 내용 반영하여 최종적으로 선 다시 그리기

	    	
		}
		
		//0817) 모달에서 "삭제하기" 버튼 클릭 시 삭제하는 로직으로 변경함 --------------------------------------------------------
		const delPlaceBtn = document.getElementById("delPlace");
		delPlaceBtn.addEventListener("click",e=>{

			
			let oriCards = document.querySelectorAll("div#dropZone>div"); //이벤트 적용 대상 설정하기
			
			//카드가 아직 삭제되지 않은 상태에서 소환됨...
			let lat = document.getElementById("placeLat").value;
			let lng = document.getElementById("placeLng").value;
			let id = document.getElementById("cardId").value;
			//console.log("??????????????????",lat,lng,id);
			
			//console.log("////////////////////////", oriCards);
			
			oriCards.forEach(v=>{
				if(id==v.id){
					v.remove();
				}
			});
			
			//TODO0819) 수정 중... 저장 前 전환시킨 일자 옵션 값 또한 localStorage에 저장된 데이터 기준으로 선을 편집하는 로직이 적용됨...
			//해당 부분은 다음 flag변수와, if(flag.length>0)조건문으로 처리하긴 했지만... 여전히 에러가 감지됨...
			//console.log("저장된 게 있다고?????????????????????",oriCards.length);
			const flag = JSON.parse(localStorage.getItem(nowCho));
			console.log("/////////////////////////////////////////",flag);
			
			
			let changedCards = document.querySelectorAll("div#dropZone>div");
			console.log("변경됐니????????????", changedCards);

			if(flag.length>0){
			let tempArr = [];	
			let forStorage = [];
			
			changedCards.forEach(v=>{ //더블 클릭-> 삭제되어 재구성된 카드 토대로 path[] 내용 재구성하기
				
				let lat = v.getAttribute('latitude');
				let lng = v.getAttribute('longitude');
				let key = v.getAttribute('day');
				console.log("key확인 : ",key);
				
				tempArr.push(new kakao.maps.LatLng(lat,lng));
				
				//-------------------------------------------------------------------------
				//localStorage에 수정 내용 저장하기...
				
				//생성자 함수로 "장소"객체 생성 후, 배열arr에 저장하기
				function Places(day,id,placeName,latitude,longitude,memo){ //생성자 함수 : 장소 정보 저장 객체
					
					this.day = day;
					this.id = id;
					this.placeName = placeName;
					this.latitude = latitude;
					this.longitude = longitude;
					this.memo = memo;			
					
				}
				
				forStorage.push(new Places(							
											//cards[i].getAttribute("day"),
											v.getAttribute('day'), //일자 정보 : 선택 일자로 저장하기
											v.getAttribute("id"),
											v.getAttribute("placeName"),
								            v.getAttribute("latitude"),
								            v.getAttribute("longitude"),
								            v.getAttribute("memo")));
	
				console.log("카드 리스트 확인하기 : ",forStorage);
				
				localStorage.removeItem(key); //기존 저장 값은 삭제
				localStorage.setItem(key,JSON.stringify(forStorage));
	
				//--------------------------------------------------------------------------
			
			});
		
				arr = tempArr.slice();		

				line.setMap(null); //기존의 선은 없애기
				
	    		line = new kakao.maps.Polyline({ //새로운 선 구성하기
	            path: arr, //새로운 내용 반영한 배열 적용하기
	            strokeWeight: 5, 
	            strokeColor: '#e61919',
	            strokeOpacity: 0.7, 
	            strokeStyle: 'solid', 
	            endArrow:'true'
	    	    });
	        	
	    		line.setMap(map); //수정 내용 반영하여 최종적으로 선 다시 그리기

			}
			
			
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
    	//2. 카드 순서 변경 (drag) ==================================================================================================================
  			[].forEach.call(cards,function(card){
 				card.addEventListener("dragend",drag,false);
 			});
 		
    		
  			function drag(e){
  				
					let cards = document.querySelectorAll("div#dropZone>div"); //순서 변경 이후 카드 구성 확인하기
 					console.log("순서 어떻게 바뀌었지??????????????", cards);
					let tempArr = [];	
					let forStorage = [];
					
					cards.forEach(v=>{ //더블 클릭-> 삭제되어 재구성된 카드 토대로 path[] 내용 재구성하기
						
						let lat = v.getAttribute('latitude');
						let lng = v.getAttribute('longitude');
						let key = v.getAttribute('day');
						console.log("key확인 : ",key);
						
						tempArr.push(new kakao.maps.LatLng(lat,lng));
						
						//-------------------------------------------------------------------------
						//localStorage에 수정 내용 저장하기...
						
						//생성자 함수로 "장소"객체 생성 후, 배열arr에 저장하기
						function Places(day,id,placeName,latitude,longitude,memo){ //생성자 함수 : 장소 정보 저장 객체
							
							this.day = day;
							this.id = id;
							this.placeName = placeName;
							this.latitude = latitude;
							this.longitude = longitude;
							this.memo = memo;			
							
						}
						
						forStorage.push(new Places(							
													//cards[i].getAttribute("day"),
													v.getAttribute('day'), //일자 정보 : 선택 일자로 저장하기
													v.getAttribute("id"),
													v.getAttribute("placeName"),
										            v.getAttribute("latitude"),
										            v.getAttribute("longitude"),
										            v.getAttribute("memo")));
			
						console.log("카드 리스트 확인하기 : ",forStorage);
						
						localStorage.removeItem(key); //기존 저장 값은 삭제
						localStorage.setItem(key,JSON.stringify(forStorage));
			
						//--------------------------------------------------------------------------
					
					});
				
						arr = tempArr.slice();		

						line.setMap(null); //기존의 선은 없애기
						
			    		line = new kakao.maps.Polyline({ //새로운 선 구성하기
			            path: arr, //새로운 내용 반영한 배열 적용하기
			            strokeWeight: 5, 
			            strokeColor: '#e61919',
			            strokeOpacity: 0.7, 
			            strokeStyle: 'solid', 
			            endArrow:'true'
			    	    });
			        	
			    		line.setMap(map); //수정 내용 반영하여 최종적으로 선 다시 그리기
			    		
			    		
			    		const daysOption = document.getElementById("travelDaysOpt");
			    		daysOption.addEventListener("change",e=>{

			    			line.setMap(null);
			    	    	markersArr.forEach(e=>{
			    	    		e.setMap(null);
			    	    	})
			    			
			    		});
  				
  				
  			}
		
		
		
		
		

    	//일자 옵션 변경 시, 갓 생성한 라인은 숨기기! ----------------------------------------------------------------------------------
		const daysOption = document.getElementById("travelDaysOpt");
		daysOption.addEventListener("change",e=>{

			line.setMap(null);
	    	markersArr.forEach(e=>{
	    		e.setMap(null);
	    	})
			
		});
		
/* 	    daysOption.addEventListener("change",e=>{
	    	
	    	polyline.setMap(null);
	    	markersArr.forEach(e=>{
	    		e.setMap(null);
	    	})

	    }); */
		
	
	}
	
	
	
	
	//여행의 첫 번째 일자에 저장된 정보 불러오기
	const dayOnePlan = JSON.parse(localStorage.getItem(1)); //JS객체를 JSON문자열로 변환 후 localStorage에 저장했었으므로, 저장 데이터를 불러올 때는 다시 JS객체로 parsing함
	var imageSrc = 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-256.png'; //마커 이미지
	var linePath = []; //"선"을 이어주기 위해 배열을 만듦		

	if(dayOnePlan!=null&&thisDay==1){ //만약, 1일자 관련 여행 일정 데이터가 존재한다면!
		
		console.log("1일차 데이터 있어", dayOnePlan);
		
		//1. 리스트 > 장소 카드 관련
		//> 데이터가 있다면, 새로고침 시에도 해당 장소 데이터가 출력되도록 로직 구현하기
		
		document.getElementById("dropZone").innerHTML=""; //계속 appendChild하면 카드가 무한히 누적되므로, 먼저 해당 영역을 비워주기
		
		for(let i=0;i<dayOnePlan.length;i++){				
		
			const div = document.createElement("div"); //태그 만들기
			
			div.setAttribute("day", 1);
			div.setAttribute("id", dayOnePlan[i].id);
			div.setAttribute("placeName", dayOnePlan[i].placeName);
			div.setAttribute("latitude", dayOnePlan[i].latitude);
			div.setAttribute("longitude", dayOnePlan[i].longitude);
			div.setAttribute("memo", dayOnePlan[i].memo);
			
			div.innerText = dayOnePlan[i].placeName;
			div.classList.add("box_drag");
			div.setAttribute("draggable",true);
			document.getElementById("dropZone").appendChild(div); 
												
			deletePlace(div);
			moveMap(div);
			printInfo(div);
			 
		}
		
		printMyLog(dayOnePlan,linePath);

	}
	
	
	
	

	
	
	//2. 클라이언트가 선택한 일자 정보 가져오기 : select > option
	let preCho = ""; //선택 前 일자
	let nowCho = ""; //선택한 일자 (열람||편집 희망 일자)
	
	//const daysOption = document.getElementById("travelDaysOpt");
	
	daysOption.addEventListener("focus",e=>{
		daysOption.blur();
		preCho = daysOption.value; //옵션 영역 선택 당시의 일자 값
		
	});
	
	daysOption.addEventListener("change",e=>{ //옵션 전환 시
		

	
		//선택한 일자에 해당하는 일정 편집 및 저장 관련 로직 ▼ ---------------------------------------------------------------------------------
		nowCho = daysOption.value;

		const cards = document.querySelectorAll("div#dropZone>div");
		console.log("현재 dropZone에 추가된 장소 카드 : (현재 선택 일자에 해당하는 저장 데이터가 없는 경우에는, 존재하지 않을 수도 있음!)", cards);
		
		//-> 따라서, card의 존재 여부에 따라서 *데이터savedPlan 불러오기, 로직을 구현할 수도 있음
		const savedPlan = JSON.parse(localStorage.getItem(nowCho)); //현재 선택한 일자로 저장된 데이터가 있을까?
		let lineArr = []; //저장된 데이터 기준으로 경로를 그려주기 위해서, 마커가 저장될 배열을 만듦
		
		if(savedPlan!=null&&savedPlan.length!=0){ //저장된 데이터가 존재한다면!
			console.log("배열로 받아온, ",nowCho,"의 일정 : ",savedPlan);
			
			//1. 작성 기록이 존재한다면, 리스트에 출력해주기
			//먼저, 리스트 깨끗이 비워주기
			document.getElementById("dropZone").innerHTML="";
				
			for(let i=0;i<savedPlan.length;i++){
				
				const div = document.createElement("div");
				
				//div에 플래너 관련 *속성 생성하고 저장하기
				if(nowCho!=null){
					div.setAttribute("day",nowCho);					
				} else {
					div.setAttribute("day",1);
				}
				
				div.setAttribute("id", savedPlan[i].id);
				div.setAttribute("placeName", savedPlan[i].placeName);
				div.setAttribute("latitude", savedPlan[i].latitude);
				div.setAttribute("longitude", savedPlan[i].longitude);
				div.setAttribute("memo", savedPlan[i].memo);
				
				div.innerText = savedPlan[i].placeName;
				div.classList.add("box_drag");
				div.setAttribute("draggable",true);
				document.getElementById("dropZone").appendChild(div); 
				
				deletePlace(div); 
				moveMap(div);
				printInfo(div);
	
			}
			
			printMyLog(savedPlan,lineArr); //리스트에 로그 출력하기
			//TODO 0816) 저장 내용 토대로 마커를 출력하긴 해야할 거 같기도...
			clearDragEvent();
			addDragEvent();
			
		} else { //선택한 일자에 해당하는 여행 일정이 부재하는 경우
			document.getElementById("dropZone").innerHTML=""; //편집을 새로 시작하는 것이므로, 영역 비워주기
		}
		
		
		
		//플래너 내용 작성 -> 장소 방문 순서 편집 관련 로직
		let arr = []; //card에 저장된 정보 일체 (아이디, 장소명, 위도, 경도 등을 *객체화함) arr배열에 저장하기
		
		function Places(day,id,placeName,latitude,longitude,memo){ //생성자 함수 : 장소 정보 저장 객체
			
			this.day = day;
			this.id = id;
			this.placeName = placeName;
			this.latitude = latitude;
			this.longitude = longitude;
			this.memo = memo;			
			
		}
		
		for(let i=0;i<cards.length;i++){	
			
			//생성자 함수로 "장소"객체 생성 후, 배열arr에 저장하기
				arr.push(new Places(
						
									//cards[i].getAttribute("day"),
									preCho, //일자 정보 : 선택 일자로 저장하기
									cards[i].getAttribute("id"),
									cards[i].getAttribute("placeName"),
						            cards[i].getAttribute("latitude"),
						            cards[i].getAttribute("longitude"),
						            cards[i].getAttribute("memo")));
			
		}
		
		console.log("카드 리스트 확인하기 : ",arr);
		
		//다음 option으로 전환되기 前 마무리 작업
		localStorage.setItem(preCho,JSON.stringify(arr)); //일자 별로 해당 일정을 확인할 수 있도록, arr객체를 JSON문자열로 저장함
		console.log("현재 편집한 일정이 잘 저장됐는지 확인하기 : ", JSON.parse(localStorage.getItem(preCho)));
		

		
	});
	
	//다음 option으로 전환되기 전, 당해 option에서 저장했던 마커 삭제 및 myMarkers[] 리셋
	//-> myMarkers[] 리셋해야, 옵션 무관하게 해당 배열을 기준으로 선이 그어지는 현상을 막을 수 있음!!!
	daysOption.addEventListener("change",e=>{
 		
 		for(let i=0;i<myMarkers.length;i++){			
 			myMarkers[i].setMap(null); //마커 전체 삭제 			
 		}
		myMarkers = [];
		console.log("삭제 잘 됐는가? ", myMarkers);

	
	});
	
	//플래너 지도 관련 함수들 ==================================================================================================================================
	//마커 클릭 시 출력될 커스텀 오버레이
	var customContent = '<div class="wrap">' + 
            '    	 <div class="info">' + 
            '        <div class="title">' + 
            '            여기 괜찮아요?' + 
            '            <div class="close" id="exitBtn" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="desc">' + 
            '                <div class="ellipsis" style="margin-top:30px;margin-bottom:8px;"><p style="font-size:18px;">장소를 플랜에 추가할까요?</p></div>' +
            '                <input type="text" id="memo" style="width:225px; "placeholder="메모를 작성해주세요">'+ //☆ 해당 장소에 대한 정보를 이미 사용자가 작성했다면, value에 값을 넣어도 되지 않을까
            '                <div style="margin-top:10px;margin-left:125px;"><button id="addBtn" onclick="addList();" class="addToList" style="font-size:12px;margin-left:20px;width:80px;">추가하기</button></div>' + 
            '        	 </div>' + 
            '    </div>' +    
            '</div>'+
            '<div style="display:none", id="hiddenLat"></div>' //마커의 위도
            +'<div style="display:none", id="hiddenLng"></div>' //마커의 경도
            +'<div style="display:none", id="hiddenTitle"></div>' //마커의 장소명
            +'<div style="display:none", id="mfgDate"></div>'; //0616 마커 관련 전반적인 정보 확인
	
	
            
     //커스텀 오버레이 > "추가하기"버튼 클릭 시, 클라이언트의 장소 리스트에 해당 장소가 카드 형식으로 추가될 것임
     function addList(){ //특정 장소를 사용자의 플랜 리스트에 추가하는 인터페이스
    	 
		clearDragEvent();
		       	
		const lat = document.getElementById("hiddenLat").innerText;
		const lng = document.getElementById("hiddenLng").innerText;
	 	const placeName = document.getElementById("hiddenTitle").innerText;
	 	const memo = document.getElementById("memo").value;
	 	
		console.log("위도 : ",lat,"경도 : ",lng,"타이틀 : ",placeName,"메모 : ",memo);
	
		//장소 카드 생성해, 플랜 리스트에 추가하기 -----------------------------------
		const dropZone = document.getElementById("dropZone");
		
		const addPlan = document.createElement("div"); //div생성하기
		addPlan.classList.add("box_drag");
		addPlan.setAttribute("draggable",true);
		
	
		//index를 식별하기 위해, 현재 dropZone에 자식 태그들이 몇 개 있는지 확인하기	
		
		const cards = document.querySelectorAll("div#dropZone div");
		console.log("현재 카드 개수 : ",cards.length);
		let tempNo = cards.length+1;
		addPlan.id="p"+tempNo;
		
		dropZone.insertAdjacentElement("beforeend",addPlan);
		addDragEvent();
		
		console.log(addPlan);
		//dropZone.append(document.createElement("button"));
		
		addPlan.innerText = placeName;
		//-------------------------------------------------------------------
	
		//장소 카드의 "속성"을 새로 생성해, 해당 장소의 정보를 저장하기--------------------
		
		addPlan.setAttribute("id",addPlan.id);
		addPlan.setAttribute("placeName",placeName);
		addPlan.setAttribute("latitude",lat);
		addPlan.setAttribute("longitude",lng);
		addPlan.setAttribute("memo",memo);

		//deletePlace(addPlan); //더블클릭 시, 편집 시점에 생성된 마커와 카드가 삭제됨
		//deletePlaceMarker(addPlan);
		moveMap(addPlan);
		printInfo(addPlan);
		
	}


     
     
     function printInfo(e){ //리스트에서 특정 장소 삭제 시 구현될 이벤트
    	 
     
  		
      	let dropZone = document.getElementById("dropZone");
     
     	console.log("////////////////", document.getElementById("addedPlace"));
     	//document.getElementById("addedPlace").getAttribute('aria-hidden') = 'false';
     	let addrContainer = document.getElementById("placeAddr");
     	let titleContainer = document.getElementById("placeTitle");
     	let memoContainer = document.getElementById("placeMemo");
     	let updateMemoBtn = document.getElementById("updateMemo");
     	let idContainer = document.getElementById("cardId");
     	let target //메모 수정||삭제 대상 카드 (리스트에서 클릭한 카드)
     	let delPlaceBtn = document.getElementById("delPlace");
     	
      	e.addEventListener("click",e=>{ //삭제 대상 카드 클릭 시 카드에 저장된 내용이 출력됨
      	
			
      		$('#addedPlace').modal('show');
      		console.log("구성 확인 : ", e.target);
      		let placeLat = e.target.getAttribute("latitude"); //위도
      		let placeLng = e.target.getAttribute("longitude"); //경도
      		let placeName = e.target.getAttribute("placename"); //장소명
      		let memo = e.target.getAttribute("memo"); //메모
      		
     		document.getElementById("placeLng").value = placeLng;
     		document.getElementById("placeLat").value = placeLat;
      		
      		
      		titleContainer.innerText = placeName;
      		getAddress(placeLat,placeLng, addrContainer);
      		memoContainer.value = memo;
      		idContainer.value = e.target.getAttribute("id");
      		target = e.target;
      		
      		//메모 수정하기 ----------------------------------------------------------------------
      		updateMemoBtn.addEventListener("click", e=>{
      			//alert(memoContainer.value);
      			
      			console.log("////////", target);
      			target.setAttribute("memo", memoContainer.value);
      			console.log("수정 잘 됐나?",target.getAttribute('memo'));
      			$('#addedPlace').modal('hide'); //모달창 닫기

      		});
      		
      		
      		
      		
      		
      		//카드 삭제하기 -----------------------------------------------------------------------
      		delPlaceBtn.addEventListener("click",e=>{
 		
         		

    			//------------------------------------------------------------------------------------------------
          		
    			console.log("카드 삭제하고 싶으니까 dropZone구성 : ", dropZone);
    			//const targetCards = document.querySelectorAll("div#dropZone div");
    			console.log("타겟은 뭘까...",target);

         		//dropZone.removeChild(e); //방문 리스트에서 선택한 장소 카드 삭제
				target.remove();
         		
         		$('#addedPlace').modal('hide'); //모달창 닫기

         	});
      			

      		
      	});
	
      	
     }
     
    function updateMemo(memoContainer){
    	
    }
     
     
	function getAddress(lat,lng,container){ //카드에 "주소" 정보 추가
		
	    let geocoder = new kakao.maps.services.Geocoder();
	    let coord = new kakao.maps.LatLng(lat, lng);
	    let addrTemp = "";
	    
	    let callback = function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            console.log(result);
	            addrTemp = result[0]['address']['address_name'];
	            console.log("주소정보 확인하기 : ",addrTemp);
	            //TODO 0911) localStorage에 추가할 수 있나?
	            container.innerText = addrTemp;
	            
	        }
	    };

	    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
 
	} 
     
     
     
     function deletePlace(e){ //리스트에서 특정 장소 삭제 시 구현될 이벤트
 		
     	let dropZone = document.getElementById("dropZone");

     	e.addEventListener("dblclick",e=>{ //삭제 대상 카드 더블 클릭 시 (카드 및 마커가 삭제됨)	
     	
     		alert("삭제!");

     		let placeLat = e.target.getAttribute("latitude"); //카드의 위도
     		let placeLng = e.target.getAttribute("longitude"); //카드의 경도
     		
     		
     		//마커 삭제 1) (localStorage에 저장되지 않은 내용, 사람 모양 마커)작성 中, 내가 생성한 마커 지우기
     		for(let i=0;i<myMarkers.length;i++){
     			
     			let mkLat = myMarkers[i].getPosition().getLat();
     			let mkLng = myMarkers[i].getPosition().getLng();
     			console.log(mkLat, mkLng);
     			console.log(placeLat, placeLng);
     			
 				if(mkLat==placeLat&&mkLng==placeLng){
 					myMarkers[i].setMap(null);
 					break;
 				}    			
     		}
     		
     		//마커 삭제 2) printMyLog()메소드로부터 생성된 마커(=localStorage에 저장된 마커, 빨간 마커) 지우기
     		for(let i=0;i<markersArr.length;i++){
     			
     			//myMarkers[i].setMap(null); //마커 전체 삭제
     			let mkLat2 = markersArr[i].getPosition().getLat();
     			let mkLng2 = markersArr[i].getPosition().getLng();
     			console.log(mkLat2, mkLng2);
     			
 				if(mkLat2==placeLat&&mkLng2==placeLng){
 					markersArr[i].setMap(null);
 					break;
 					
 				}    			
     		}
     		
     		//TODO 0816 마커에 대응되는 선 또한 삭제해야 함 (0815 사람모양 마커-파란 선은 수정 완료)
     		//지도에 표시된 폴리 라인 일체를 삭제한 다음에, 남은 마커들을 기준으로 선을 다시 그리면 됨
			
     		
     		dropZone.removeChild(e.target); //방문 리스트에서 선택한 장소 카드 삭제

     	});
  	
     };
     
     function moveMap(e){ //카드에 마우스 오버 시, 지도가 이동하도록 구현
    	    
     	//let dropZones = document.querySelectorAll("div#dropZone>div");
     	var thisMarker = "";
 		
 	     	e.addEventListener("mouseover",e=>{
 	 		
 	    		const lat = e.target.getAttribute("latitude");
 	    		const lng = e.target.getAttribute("longitude");
 	    		
 	    		console.log("0906확인",lat,",",lng);
 	    		
 	    		//0618) 마커가 생성됨 (선만으로는 확인하기 어려우니까)
 	    		var markerPosition  = new kakao.maps.LatLng(lat, lng); 
 	     		// 마커를 생성합니다
 	     		thisMarker = new kakao.maps.Marker({
 	     		    position: markerPosition
 	     		});
      		
      			panTo(lat,lng); //지도 이동 메소드

 	     		thisMarker.setMap(map); //마커 표시하는 메소드
 		
 	    	});
 	     	
 	     	//마우스 오버 시, 해당 일자에 마커가 생성됨. 마우스 아웃 시, 마커는 사라짐!
 	     	e.addEventListener("mouseout",e=>{
 	     		thisMarker.setMap(null);
 	     	})
 	     	
 	     	//카드를 더블클릭하면 해당 장소는 삭제되므로, 이때 마커도 삭제됨
 	     	e.addEventListener("dblclick",e=>{
 	     		thisMarker.setMap(null);
 	     	})

     } 
     
     
 	function panTo(lat,lng) { //지도 이동 관련 카카오 제공 기본 함수
 		    // 이동할 위도 경도 위치를 생성합니다 
 		    var moveLatLon = new kakao.maps.LatLng(lat, lng);
 		    
 		    // 지도 중심을 부드럽게 이동시킵니다
 		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
 		    map.panTo(moveLatLon);            
 		}   
   
            

	
	
		//● "지도" 기능 관련 함수들
		//1. 지도 출력 -----------------------------------------------------------------------------------------
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		//2. 지도에 컨트롤러 올리기 ---------------------------------------------------------------------------------
		const btnController = document.getElementsByClassName("btn-controller");
		map.addControl(btnController[0], kakao.maps.ControlPosition.TOPLEFT);
		
		//3. 0817) 클릭 시, 해당 위치에 마커 꽂기 ---------------------------------------------------------------------------
		
		// 지도를 클릭한 위치에 표출할 마커입니다
 		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		
		// 지도에 마커를 표시합니다
		marker.setMap(map); 
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'dblclick', function(mouseEvent) {  
			
			document.getElementById("myTitle").value="";
			document.getElementById("myLng").value="";
		 	document.getElementById("myLat").value="";
		 	document.getElementById("myMemo").value="";
			
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 클릭한 마커의 위도, 경도 정보를 변수에 저장하기
		    let lat = latlng.getLat(); //위도
		    let lng = latlng.getLng(); //경도
		    
		    document.getElementById("myLat").value = lat;
		    document.getElementById("myLng").value = lng;
		    
		    
		    //장소 정보 받아오기
		    let addr = document.getElementById("myAddr");
		    getAddress(lat,lng,addr);
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    //"나만의 장소 추가하기" 설정 모달창 띄워주기
		    $('#plusMarker').modal('show');
		    
		    document.getElementById("addListBtn").addEventListener("click",e=>{
		    
		    	marker.setMap(null);
			    
		    });
		    
		    
		});
		
		//bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
		//"나만의 장소", 리스트에 추가하기!
		function addMyPlace(){
		
			
			//alert("등록");
			
 			clearDragEvent();
	       	
			const placeName = document.getElementById("myTitle").value;
			const lng = document.getElementById("myLng").value;
		 	const lat = document.getElementById("myLat").value;
		 	const memo = document.getElementById("myMemo").value;
		 	
		 	
			console.log("위도 : ",lat,"경도 : ",lng,"타이틀 : ",placeName,"메모 : ",memo);
		
			//장소 카드 생성해, 플랜 리스트에 추가하기 -----------------------------------
			const dropZone = document.getElementById("dropZone");
			
			const addPlan = document.createElement("div"); //div생성하기
			addPlan.classList.add("box_drag");
			addPlan.setAttribute("draggable",true);
			
		
			//index를 식별하기 위해, 현재 dropZone에 자식 태그들이 몇 개 있는지 확인하기	
			
			const cards = document.querySelectorAll("div#dropZone div");
			console.log("현재 카드 개수 : ",cards.length);
			let tempNo = cards.length+1;
			addPlan.id="p"+tempNo;
			
			dropZone.insertAdjacentElement("beforeend",addPlan);
			addDragEvent();
			
			console.log(addPlan);
			//dropZone.append(document.createElement("button"));
			
			addPlan.innerText = placeName;
			//-------------------------------------------------------------------
		
			//장소 카드의 "속성"을 새로 생성해, 해당 장소의 정보를 저장하기--------------------
			
			addPlan.setAttribute("id",addPlan.id);
			addPlan.setAttribute("placeName",placeName);
			addPlan.setAttribute("latitude",lat);
			addPlan.setAttribute("longitude",lng);
			addPlan.setAttribute("memo",memo);

			//deletePlace(addPlan); //더블클릭 시, 편집 시점에 생성된 마커와 카드가 삭제됨
			//deletePlaceMarker(addPlan);
			moveMap(addPlan);
			printInfo(addPlan);
			
			addMarkerFunc(lat,lng,placeName);
			
			
			
			
			
			$('#plusMarker').modal('hide');
			
			
			
		}		
		//bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
		
		
		//4. 마커 및 검색 기능 ----------------------------------------------------------------------------------------
		

		// 마커를 담을 배열입니다
		var markers = [];
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 키워드로 장소를 검색합니다
		searchPlaces();
		
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
		
		    var keyword = document.getElementById('keyword').value;
		
		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);
		
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
		
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		
		    } else if (status === kakao.maps.services.Status.ERROR) {
		
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
		
		    }
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
		
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);
		
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);
		
		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        
		        
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });
		
		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
		            
		            
		            //● "마커" 관련 이벤트 =====================================================

		            	
		            //마커 관련 이벤트 > 1. 마커 클릭 시, 커스텀 오버레이를 출력할 것임
				  	var overlay = new kakao.maps.CustomOverlay({ //커스텀 오버레이 등록
					    content: customContent,
					    //content: savedInfo,
					    map: map,
					    position: marker.getPosition()       
					});
		          	
		          		overlay.setMap(null); //디폴트 : 출력 안 함
		          		
		          		
		          		kakao.maps.event.addListener(marker, 'click', function() { //마커 클릭 시 발생할 이벤트
		          			
		          			
		          			//커스텀 오버레이 관련 함수 시작 ------------------------------------------------------
		          			//alert('안녕? 나는 마커야!');
		          			overlay.setMap(map); //커스텀 오버레이를 출력함
		          			
		          			//개별 마크에 내포된 정보들을 오버레이에 저장 -> 출력하기
		          			//1-1. 정보 추출 > 마커에 포함된 위도, 경도 정보
		          			let lat = marker.getPosition().getLat(); //위도
							let lng = marker.getPosition().getLng(); //경도
		          			//1-2. 오버레이에 저장하기
							document.getElementById("hiddenLat").innerText=lat;
							document.getElementById("hiddenLng").innerText=lng;						
							document.getElementById("hiddenTitle").innerText=title;	

							
							//추가하기 버튼 클릭 時, 해당 마커의 이미지 변경
							const isAdded = document.getElementById("addBtn");
							isAdded.addEventListener("click",e=>{
								
								addMarkerFunc(lat,lng,title);
								
							});
							
							
							//● 커스텀 오버레이 > "닫기"
							//1. X 버튼 클릭 時
							const exitBtn = document.getElementById("exitBtn");
							exitBtn.addEventListener("click", e=>{
								overlay.setMap(null);
							})
							//2. "등록" 버튼 클릭 時
							//커스텀 오버레이창 *닫기
							const addBtnClose = document.getElementById("addBtn");
							addBtnClose.addEventListener("click",e=>{
								overlay.setMap(null);
							});
							//커스텀 오버레이 관련 함수 끝 --------------------------------------------------------
							
				
							
		          		});	//마커 클릭 이벤트 끝

		            	
		            //=======================================================================	
		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };
		
		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
		
		        fragment.appendChild(itemEl);
		    }
		
		    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
		
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
		

		 //"추가하기" 버튼 클릭을 눌렀을 때
		 //기능 리스트
		 /*
		 
		 	1. 마커 모양 차별화 : "사람"모양의 마커
		 	2. 커스텀 오버레이 차별화 : 해당 마커에 대한 간단한 설명과 더불어, 리스트로부터 마커를 삭제할 수 있음 (구현 예정)
		    3. 실시간 선 그리기 : 마커가 추가되는 대로 자동 선 그리기 (* setInterval())
		 
		 */
		 
		 
		 const addMarkerFunc = (lat,lng,placeName)=>{
			 
			 //1. 마커 이미지 변경 
			 //1-1. (아직은 저장되기 이전이므로, 사람 모양 마커)
			 var tempMarker = "https://cdn0.iconfinder.com/data/icons/zondicons/20/travel-walk-256.png";
			 //1-2. 마커 크기 변경
			 var tempMarkerSize = new kakao.maps.Size(36, 37); 
			    
			    // 마커 이미지를 생성합니다    
			    var tempMarkerImg = new kakao.maps.MarkerImage(tempMarker, tempMarkerSize); 
			    
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(lat,lng),
			        title : placeName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : tempMarkerImg // 마커 이미지 
			    });
					
			    
				infoOverlay(marker); //커스텀 오버레이 출력
				
				
				//myMarkers를 카카오 좌표 객체化해서 보내야 작업이 간단하겠다...
				myMarkers.push(marker); //배열에 저장하기!
				
				
				//장소 삭제 관련, 삭제 내용 반영해 myMarkers 재구성하기 ==============================================
				let cards = document.querySelectorAll("div#dropZone>div");

     			[].forEach.call(cards,function(card){
     				card.addEventListener("dblclick",click,false);
     			});
     			
     			function click(e){ //deletePlace()와 같이, 리스트 카드 클릭 시 파란 선과 사람 모양 마커 삭제하기
     				
     				
     				let lat = e.target.getAttribute('latitude');
     				let lng = e.target.getAttribute('longitude');
     				let target = new kakao.maps.LatLng(lat,lng);
				
     				//----------------------------------------------------------------------------------------
     				//myMarkers에서도 해당 좌표 값은 삭제해야 함

					console.log(target.Ma); //latitude
					console.log(target.La); //longitude
					
      				let tempArr = myMarkers.filter(function(v,i,ori){
     					return (v.getPosition().getLat()!=target.Ma&&v.getPosition().getLng()!=target.La);
     				});
     				
					console.log("tempArr의 유형 /////////////////////",tempArr);
     				myMarkers = tempArr.slice();
     				
     			}
     			
     			//deletePlace 대신, delPlace버튼으로 삭제한 경우 myMarkers 재구성하기... -------------------------------
     			document.getElementById("delPlace").addEventListener("click",e=>{
     				

     				let lng = document.getElementById("placeLng").value;
     				let lat = document.getElementById("placeLat").value;
     				console.log("정보 잘 받아왔나??????",lng," , ",lng);
     				

             		console.log("############## 대상////////////",myMarkers);
             		
             		//마커 삭제 1) (localStorage에 저장되지 않은 내용, 사람 모양 마커)작성 中, 내가 생성한 마커 지우기
             		for(let i=0;i<myMarkers.length;i++){
             			
             			let mkLat = myMarkers[i].getPosition().getLat();
             			let mkLng = myMarkers[i].getPosition().getLng();
             			
             			console.log(mkLat, mkLng);
             			
         				if(mkLat==lat&&mkLng==lng){
         					myMarkers[i].setMap(null);
         					break;
         				}    			
             		}

     				
     				//---
     				
     				let target = new kakao.maps.LatLng(lat,lng);
     				
      				let tempArr = myMarkers.filter(function(v,i,ori){
     					return (v.getPosition().getLat()!=target.Ma&&v.getPosition().getLng()!=target.La);
     				});
     				
					console.log("tempArr의 유형 /////////////////////",tempArr);
     				myMarkers = tempArr.slice();

     				
     				console.log("##################### 제대로 삭제됐는가?", myMarkers);
     				
     				
     				
     				
				
     			});
	
     			
     			//장소 방문 순서 변경 관련, 수정 내용 반영해 myMarkers 재구성하기 ==========================================
      			[].forEach.call(cards,function(card){
     				card.addEventListener("dragend",drag,false);
     			});
				
 				function drag(e){ //드래그가 완료된 시점에, 카드에 저장된 내용을 바탕으로 myMarkers재구성하기!
 				
 					
 					let cards = document.querySelectorAll("div#dropZone>div");
 					let tempArr = [];	
 				
 					cards.forEach(v=>{ //순서 변경으로 재배열된 카드 토대로 path배열 재구성하기
 						
 						let lat = v.getAttribute('latitude');
 						let lng = v.getAttribute('longitude');
 						let name = v.getAttribute('placename');
 						
 					    var marker = new kakao.maps.Marker({
 					        map: map,
 					        position: new kakao.maps.LatLng(lat,lng),
 					        title : name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
 					        image : tempMarkerImg // 마커 이미지 
 					    });
 						
 						tempArr.push(marker);
 					
 					});
 				
 					console.log("////////////////////////",tempArr);
 					myMarkers = tempArr.slice();
 				} 
		
				drawLines(myMarkers); //마커 간 선 그리기
				
				
				
				
 			    daysOption.addEventListener("change",e=>{
	    	    	
 			    	markersArr.forEach(e=>{
 			    		e.setMap(null);
 			    	})

 			    });
				
				
				
				

			}  
		 
		 
		 	//리스트에 추가된 장소 대상 커스텀 오버레이 (공통 function)
		 	function infoOverlay(marker){
		 		
			 	//사람 모양의 마커 위로 출력될 커스텀 오버레이 만들기
				var content = '<div class="wrap">' + 
				            '    <div class="info">' + 
				            '        <div class="title">' + 
				            '            리스트에 추가된 장소' + 
				            '        </div>' + 
				            '        <div class="body">' + 
				    		'            <div style="position:relative;margin:10px;padding:10px;display:block">' + 
				    		'                <div id="listedName" style="font-size:15px;margin-right:30px;">장소명</div>' +
				    		'                <div id="listedMemo" style="font-size:15px;margin-right:30px;"><input style="margin-top:10px;margin-bottom:10px;" placeholder="메모"></div>' + 
				    		'                <input id="listedDay" style="font-size:15px;margin-right:30px;" placeholder="방문일자"></div>' +
/* 				   			'                <div style="float:right;margin-right:20px;"><button onclick="deleteThisMarker();">삭제하기</button></div>' +  */ 
				            '            </div>' + 
				            '        </div>' + 
				            '    </div>' +    
				            '</div>';
			    
			    
		        var overlay = new kakao.maps.CustomOverlay({
		            content: content,
		            map: map,
		            position: marker.getPosition()       
		        });
		        
		        overlay.setMap(null); //디폴트 : 출력 안 함

		        // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
		        kakao.maps.event.addListener(marker, 'click', function() {
		            
		        	showOverlay(); //오버레이 출력 관련 설정
		        });

			    
				const showOverlay = (()=>{ //마커 클릭 시 오버레이 출력, 재클릭 시 숨김
					
				 	let cnt = 1;
				
					return()=>{						
						if(++cnt%2!=0){
							overlay.setMap(null);
						} else {
							overlay.setMap(map); //오버레이 표시하기
							console.log(document.getElementById("listedName"));
							
							//마커에 저장된 정보 확인하기
							let lat = marker.getPosition().getLat();
							let lng = marker.getPosition().getLng();
							let title = marker.getTitle();
							
							document.getElementById("listedName").innerText = title;
						}						
					}
					
					})();
		 		
		 		
		 	}
		 

		    function deleteThisMarker(marker){
		    	alert(marker.getTitle());
		    }
		
			//실시간으로 선 그리기 ------------------------------------------------------------------------------
			
			

			
			function drawLines(myMarkers){

				
				var path =  []; 
				
				const savedPlan = JSON.parse(localStorage.getItem(nowCho));
				console.log("저장된 내용이 있습니까? ",savedPlan==null?'없어요':'있어요');
				
				let savedLat, savedLng = "";
				
 				if(savedPlan!=null&&savedPlan.length!=0) { //가장 최근에 저장된 장소 정보(마지막 index)
					
 					console.log("저장된 내용을 적용할 거예요")
 					savedLat = savedPlan[savedPlan.length-1].latitude;
 					savedLng = savedPlan[savedPlan.length-1].longitude;
 					path.push(new kakao.maps.LatLng(savedLat,savedLng));
				
 				} 
				
				console.log("lat : ", savedLat);				
				console.log("lat : ", savedLng);				

				
 				var clickLine = new kakao.maps.Polyline({
				    map: map,
				    strokeWeight: 3, // 선의 두께입니다
				    //strokeColor: '#db4040', // 선의 색깔입니다
				    strokeColor: 'blue', // 확정되기 전에는 파란색
				    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'solid' // 선의 스타일입니다
				});

						console.log("path 확인", path);
						console.log("myMarkers 확인", myMarkers);
						
						myMarkers.forEach(e=>{
							//클라이언트가 추가하는 마커 정보들 족족 path에 저장하기
							path.push(new kakao.maps.LatLng(e.getPosition().getLat(),e.getPosition().getLng()));
							
						});
				
				//deletePlace() 관련, path에서 다시 클라이언트가 클릭했던 장소에 해당되는 마커는 배열에서 삭제해야 함
				
 				setInterval(function() {
				    clickLine.setPath(path);
				}, 100);
 				
 				//파란 path 삭제 관련 ---------------------------------------------------------------------
 				//삭제돼야 하는 경우 : 옵션 전환 시, deletePlace()실행 시
 				//옵션이 전환될 때 path 삭제하기
 				daysOption.addEventListener("change",e=>{

 					clickLine.setMap(null);
 			 		for(let i=0;i<myMarkers.length;i++){			
 			 			myMarkers[i].setMap(null); //마커 전체 삭제 			
 			 		}
 				})
 				
				//---------------------------------------------------------------------------------------
				
				
				let cards = document.querySelectorAll("div#dropZone>div");

     			[].forEach.call(cards,function(card){
     				card.addEventListener("dblclick",click,false);
     			});
     			
     			
     			function click(e){ //deletePlace()와 같이, 리스트 카드 클릭 시 파란 선과 사람 모양 마커 삭제하기
     				
     				let lat = e.target.getAttribute('latitude');
     				let lng = e.target.getAttribute('longitude');
     				console.log("위도 경도 확인 : ",lat,lng);
     				let target = new kakao.maps.LatLng(lat,lng);
     				console.log("객체 확인 : ",target);
     				//path[] 전체 삭제 후, 대상 좌표만 제거한 다음 다시
     				
     				
     				console.log("원본 배열 : ", path);
     				let tempPathArr = path.filter(function(v,i,ori){

     					return (v.La != target.La&&v.Ma!=target.Ma); //삭제 대상을 제외한 새로운 배열을 반환함
     				}); 
     				
     				//console.log("필터 적용되나? ", tempArr);
     				//원본 파란 선은 모두 삭제하고, temp기준으로 polyline다시 그리기   				
     				path = tempPathArr.slice();
     				//console.log("복사 잘 됐나? ",path);
		
     			}
     			
     			
     			
     			
     			//0817 deletePlace()가 아닌, delPlace버튼으로부터 장소가 삭제된 경우, 마커 제거하기
     			document.getElementById("delPlace").addEventListener("click",e=>{
     				
     				
     				
     				
     				
     				let lng = document.getElementById("placeLng").value;
     				let lat = document.getElementById("placeLat").value;
     				console.log("정보 잘 받아왔나??????",lng," , ",lng);
     				
     				console.log("위도 경도 확인 : ",lat,lng);
     				let target = new kakao.maps.LatLng(lat,lng);
     				console.log("객체 확인 : ",target);
     				//path[] 전체 삭제 후, 대상 좌표만 제거한 다음 다시
     				
     				
     				console.log("원본 배열 : ", path);
     				let tempPathArr = path.filter(function(v,i,ori){

     					return (v.La != target.La&&v.Ma!=target.Ma); //삭제 대상을 제외한 새로운 배열을 반환함
     				}); 
     				
     				//console.log("필터 적용되나? ", tempArr);
     				//원본 파란 선은 모두 삭제하고, temp기준으로 polyline다시 그리기   				
     				path = tempPathArr.slice();
     				console.log("복사 잘 됐나? ",path);

     				
     			});
     			
     			
 				//----------------------------------------------------------------------------------------
				//리스팅된 방문 장소의 순서가 변경될 때도, '선' 표기가 변경되어야만 함
 				//카드가 drag되는 상황을 감지할 수 있어야 함
	
      			[].forEach.call(cards,function(card){
     				card.addEventListener("dragend",drag,false);
     			});
				
 				function drag(e){ //드래그가 완료된 시점에, 카드에 저장된 내용을 바탕으로 myMarkers재구성하기!
 				
 					
 					let cards = document.querySelectorAll("div#dropZone>div");
 					let tempArr = [];	
 				
 					cards.forEach(v=>{ //순서 변경으로 재배열된 카드 토대로 path배열 재구성하기
 						
 						let lat = v.getAttribute('latitude');
 						let lng = v.getAttribute('longitude');
 						tempArr.push(new kakao.maps.LatLng(lat,lng));
 					
 					});
 				
 					console.log("////////////////////////",tempArr);
 					path = tempArr.slice();
 					
 					
 					const daysOption = document.getElementById("travelDaysOpt");
 					daysOption.addEventListener("change",e=>{

 						//line.setMap(null);
 				    	markersArr.forEach(e=>{
 				    		e.setMap(null);
 				    	})
 						
 					});
 					
 				}
 				
 				
 				//옵션 변경 시 마커 제거 무조건이다
 			    daysOption.addEventListener("change",e=>{
	    	    	
 			    	clickLine.setMap(null);
 			    	markersArr.forEach(e=>{
 			    		e.setMap(null);
 			    	})

 			    });

			
			}
		
			//폴리라인 제거 관련
			function deleteBlueLine(polyLine){
				polyLine.setMap(null);
			}
		

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
		
		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';
		
		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           
		
		    el.innerHTML = itemStr;
		    el.className = 'item';
		
		    return el;
		}
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });
		
		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		
		    return marker;
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 
		
		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }
		
		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;
		
		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }
		
		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}
		
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
		
		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
		

			 
		 
		 
		 
		 
/* 		//0. 테스트 : 지도 상 마커 생성과 polyline 그리기 -----------------------------------------------------------------------
		//기능 내용 : 지도 위 특정 지점 클릭 시, 마커가 생성되고 마커 간에 선이 그어진다. 
		var path =  []; 
		var clickLine = new kakao.maps.Polyline({
		    map: map,
		    strokeWeight: 3, // 선의 두께입니다
		    strokeColor: '#db4040', // 선의 색깔입니다
		    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid' // 선의 스타일입니다
		});
		
		// 지도에 클릭 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    // 마우스로 클릭한 위치입니다
		    var clickPosition = mouseEvent.latLng;
		    path.push(clickPosition);
		});
		
		setInterval(function() {
		    clickLine.setPath(path);
		}, 1000); */
		
		//-------------------------------------------------------------------------------------------------------------------
		//커스텀 오버레이 만들기

		
	//-----------------------------------------------------------------------------------------------------------------------
	//지도 상에 마커를 계속 표출하는 대신, 카드 클릭 시 관련 상세 내용을 확인할 수 있도록 구현하는 편이 더 깔끔할 거라 판단함

		
	
	(()=>{ //안 되네
		
		
		
		function checkCards(){
			
			let listedCards = document.querySelectorAll("#dragZone div");
			console.log("몇 개 인가요? : ",listedCards.length);


				[].forEach.call(listedCards,function(card){
					card.addEventListener("dblclick",click,false);
				});
				
				function click(e){
					
					alert(e);
					
				}
			
		}
		
		checkCards();
		
		
		
	})();
		
		
		//==============================================================================================================
		//플래너 저장||삭제 관련 함수
		
		//1. 플래너 삭제 함수
		const deleteSchedule = ()=>{
			
			localStorage.clear(); //localStorage 비우기
			location.assign("${path}/"); //메인화면으로 돌아가기
			
		}
		
		
		//TODO0906)
		//2. 플래너 저장 함수
		const saveSchedule = ()=>{ //form은 form대로 보내고, 여기에는 개별 구체적인 plan들을 fetch로 전송할 수 있을까?
			
				alert("저장!");
		
		
			//-------------------------------------------------------------------
			//startPlanner.jsp 페이지에서 사용자가 입력한 값 확인하기
			//console.log("사용자 입력 값 : ",${tempPlanner});
			
			//localStorage객체 배열로 저장하기
			//내장점
			console.log("파싱 테스트 : ", JSON.parse(localStorage.getItem(1)));
			
			let tempArr = []; //객체가 저장될 배열
			for(let i=0;i<localStorage.length;i++){
				
				
				//tempArr.push(localStorage.getItem(i+1)); //key값은 1부터 시작하므로... i+1의 형태로 저장함
				//TODO 0907) localStorage의 value를 tempArr에 저장하기
			
				//localStorage.getItem
				tempArr.push(JSON.parse(localStorage.getItem(i+1)));
			
			}
			
			console.log("배열 확인 : ", tempArr);
			//console.log("JSON.stringify(배열) : ", JSON.stringify(tempArr));
			
			
			const fileInput = document.querySelector("#img_");
			
			//FormData객체 사용해보기
			
			let formData = new FormData();
			
			formData.append("img", fileInput.files[0]); //이미지 파일 가져오기
			
			//플래너 제목, localStorage > JS객체 배열 데이터도 추가할 수 있나?
			
			//플래너 정보
			//0. 작성자 > memberId
			formData.append("memberId","${loginMember.memberId}");
			//1. 제목 > plannerTitle
			formData.append("plannerTitle",document.getElementById("plannerTitle_").value);
			//2. 여행일자 > travelDays
			formData.append("travelDays","${tempPlanner.travelDays}");
			//3. 테마 > theme
			formData.append("theme","${tempPlanner.theme}");
			//4. 주요 여행지 > areaCode, sigunguCode
			formData.append("areaCode","${tempPlanner.areaCode}");
			formData.append("sigunguCode","${tempPlanner.sigunguCode}");
			//5. 소개글 > sumamry
			formData.append("summary",document.getElementById("summary_").value);
			
			//TODO 0911 > 6. 주소 > address도 저장해야 함
			//TODO 0912 > address정보 저장 시도!
			
			//localStorage배열도 저장할 수 있나? ------------------------------------------------------------
			//5. Plan[] plan			
			//formData.append("tempArr",tempArr);
			
			
				console.log("tempArr 확인하기 : ",tempArr.length);
				
				

				
				//배열 구조
				//-> 여행 일자 (3일)
				//   -> 해당 일의 방문 장소 (2개 : 객체 배열 형태임)
			
				for(let i=0;i<tempArr.length;i++){ //여행 일자 만큼 반복
					
					for(let j=0;j<tempArr[i].length;j++){ //방문 장소 만큼 반복 (PlanTemp클래스 참고)
						
						formData.append("planList["+i+"]["+j+"].day",tempArr[i][j]['day']);
						formData.append("planList["+i+"]["+j+"].id",tempArr[i][j]['id']);
						formData.append("planList["+i+"]["+j+"].latitude",tempArr[i][j]['latitude']);
						formData.append("planList["+i+"]["+j+"].longitude",tempArr[i][j]['longitude']);
						formData.append("planList["+i+"]["+j+"].memo",tempArr[i][j]['memo']);
						formData.append("planList["+i+"]["+j+"].placeName",tempArr[i][j]['placeName']);
						
						//console.log(addressArr[0]);
						formData.append("planList["+i+"]["+j+"].address",""); //장소 정보 DB에 저장 불가능함
/* 						let lat = tempArr[i][j]['latitude'];
						let lng = tempArr[i][j]['longitude'];
						console.log("좌표 전달하기 : ",lat,lng);
						getAddress(lat,lng);
						
						console.log("가져올 수 있니?????", document.getElementById("tempAddrContainer").value); */
						
					}
				
				
				
				}
			
				//console.log("리턴 값 테스트 : ",test2);
			
			
			
			//-------------------------------------------------------------------------------------------
			
			//console.log(formData);
			fetch('${path}/planner/savePlanner2.do',{
				method:'POST',
				cach: 'no-cache',
				body:formData 
				
			})
			.then((res)=>res.json())
			.then((data)=>{
				
			
				console.log("저장 결과 확인 : ",data);
				if(data==1){
					
					alert("저장 성공! 메인화면으로 돌아갑니다!");
					//localStorage삭제 후 메인화면으로 이동
					localStorage.clear(); //localStorage 비우기
					location.replace("${path}/"); //메인화면으로 돌아가기 (뒤로 가기 불가)
					
				} else {
					
					alert("저장 실패! 다시 시도해주세요. 오류가 반복되는 경우, 관리자에게 문의부탁드립니다");
					//모달 창만 닫기
					$("#saveSchedule").modal("hide");
					//$("#myLikes").modal("show");
				}
			
			});
			
			
			
		}
		
		//==============================================================================================================
	</script>
	
	
	
	<!-- Modal : deleteSchedule()관련 -->
	<div class="modal fade" id="deleteSchedule" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">플래너 삭제</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        편집 내용을 삭제하고 메인화면으로 돌아가겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
	        <button type="button" class="btn btn-outline-danger" onclick="deleteSchedule();">삭제하기</button>
	      </div>
	    </div>
	  </div>
	</div>
	

	
	
	<div class="modal fade" id="saveSchedule" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true"
	>
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content" style="height:550px;">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLongTitle">플래너 저장</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      
<%-- 	     
		TODO0906) form태그는 주석 처리
		<form name="memberEnrollFrm" action="${path }/planner/savePlanner" method="post"
		 enctype="multipart/form-data"> --%>
	      <div class="modal-body">
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">플래너 제목</span>
						</div>
						<input name="plannerTitle" id="plannerTitle_" type="text" class="form-control" aria-label="Small"
							aria-describedby="inputGroup-sizing-sm" value="${tempPlanner.plannerTitle}">
					</div>
					<p style="margin-bottom:5px;font-style:italic;">플래너를 소개할 수 있는 짤막한 한 문장!</p>
					<div class="input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">소개글</span>
						</div>
						<input id="summary_" name="summary" type="text" class="form-control" aria-label="Small"
							aria-describedby="inputGroup-sizing-sm">
					</div>
					
					<c:if test="${tempCrew.crewId!=null}">

						<input name="crewId" type="hidden" value="C${tempCrew.crewId}">	 
						<div class="form-group">
							<label for="exampleFormControlSelect2" style="font-size:larger;font-weight:500;">${tempCrew.crewTitle}</label> 
							<select multiple class="form-control"
								id="exampleFormControlSelect2">
								<c:forEach var="m" items="${crewMembers}">
									<option>${m.memberId}</option>
 								</c:forEach>
							</select>
						</div>
					</c:if>

					<div class="input-file-container" style="width:460px;margin-left:0px;">
							<h5 style="font-size:16px; text-align:left; margin-left:5px;">대표 이미지</h5>
							<div class="input-group mb-3">
							  <div class="custom-file">
							    <input type="file" class="custom-file-input" id="img_" name="img">
							    <label class="custom-file-label" for="inputGroupFile02">최대 10MB</label>
							  </div>
							</div>
					</div>
	      </div>
	      
	      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소하기</button>
		       <!--  <button type="submit" class="btn btn-outline-success" onclick="saveSchedule();">저장하기</button> -->
		        <button type="button" class="btn btn-outline-success" onclick="saveSchedule();">저장하기</button>
	      </div>
<!-- 	      </form> -->
	      
	    </div>
	  </div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	<script>
	            		//드래그 앤 드롭 이벤트 관련
		                
		                		function addDragEvent(){
		                			
		                			document.querySelector('#dropZone').addEventListener('dragover', dragover_handler);
		                			 
									document.querySelector('#dropZone').addEventListener('drop', drop_handler);
									
									const elements = document.querySelectorAll(".box_drag");
			            	        elements.forEach(e => e.addEventListener("dragstart", dragstart_handler));
		                		}
		                		
		                		
		                		
								function clearDragEvent(){
		                			
		                			document.querySelector('#dropZone').removeEventListener('dragover', dragover_handler);
									document.querySelector('#dropZone').removeEventListener('drop', drop_handler);
									const elements = document.querySelectorAll(".box_drag");
			            	        elements.forEach(e => e.removeEventListener("dragstart", dragstart_handler));
		                		}
		                		
		                		
		                		window.addEventListener('DOMContentLoaded', () => {
		                			addDragEvent();
			            	    });
		                		
		                		
		            			/* 드래그 앤 드롭 관련 */
		            		    
		            	        function dragstart_handler(ev) {
		            	          // 데이터 전달 객체에 대상 요소의 id를 추가합니다.
		            	          ev.dataTransfer.setData("text/plain", ev.target.id);
		            	          ev.dataTransfer.idx = 1111111111;
		            	          //console.dir('///////////////dragstart_handler////////////////');
			            	         console.dir(ev);
		            	        }

		
		            	        function dragover_handler(ev) {
		            	         ev.preventDefault();
		            	         ev.dataTransfer.dropEffect = "move";
		            	        }
		
		            	        function drop_handler(ev) {
		            	         ev.preventDefault();
		            	         console.dir(ev);
		            	         const data = ev.dataTransfer.getData("text/plain");
		            	         const divItems = document.querySelectorAll("div#dropZone>div");
		            	         
		            	         //태그 상 마지막 노드에 카드를 추가하고자 할 때, "insertBefore"함수 구현하기
		            	         if(ev.target.nextElementSibling!=null){
		            	         	dropZone.insertBefore(document.getElementById(data),ev.target);
		            	         } else dropZone.insertBefore(document.getElementById(data), null);
		            	         
		            	        }
	            	     	            		
	            		</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>