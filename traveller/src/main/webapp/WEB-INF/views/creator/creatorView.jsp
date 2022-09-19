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

/* request 관련 style설정 */

.request-title-container{
	width:600px;
}
.area-container{
	margin-top:12px;
	margin-bottom:10px;
	display:inline-block;
	width: -webkit-fill-available;
	margin-left:0px;
}
#requestBtn{
	float:right;
	margin-bottom:20px;
}

/* 의뢰 글 쓰기 */

.info-container{
	width:600px;
	display: contents;
	/* margin-left: -1px; */
}
.cnt-container{
	display:flex;
	float:right;
	margin-right:10px;
	margin-bottom:-10px;
}
textarea{
/* 	height:261px;
	width:792px; */
	resize:none;
	border-radius:10px;
	outline-color: #FE6B8B;
	
	width: -webkit-fill-available;
    height: 200px;
    margin-bottom: 30px;
	
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
					<p style="text-align:left;margin-top:30px;">${creator.memberId}님께 여행 계획 의뢰하기</p>
				
				
				<!-- 0917 -->
				
				<form action="${path}/creator/requestPlan.do" method="post">
						<!-- 의뢰인, 크리에이터 아이디 정보 -->
						<input id="memberId_" name="memberId" type="hidden" value="${loginMember.memberId}">
						<input id="creatorId_" name="creatorId" type="hidden" value="${creator.memberId}">
							
				
							<div class="input-group input-group-sm mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroup-sizing-sm">제목</span>
								</div>
								<input placeholder="띄어쓰기 포함 최대 15글자" name="requestTitle" id="requestTitle_" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
							</div>
						<div class="theme-container" style="display:flex;">
							<!-- 테마 -->
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-sm" style="height: 31px; font-size: 14px;">테마</span>
							</div>
							<select class="theme-select-one custom-select custom-select-sm" required>
								<option value="none">여행 테마를 선택해보세요</option>
								<option value="A01">자연</option>
								<option value="A02">인문</option>
								<option value="C01">추천 코스</option>
								<option value="A03">레포츠</option>
								<option value="shopping">쇼핑</option>
								<option value="food">음식</option>
								<option value="free">자유여행</option>
							</select> 
							<select name="theme" id="theme_" class="theme-select-two custom-select custom-select-sm" required>
								<!-- 테마 카테고리 상세 -->
							</select>
						</div>
							
							<div class="area-container">	
								<!-- 지역 -->
								<p style="text-align: left;">주요 여행 지역</p>
								<select class="custom-select custom-select-sm area-class"
									name="areacode" id="areacode_" onclick="createAreaOption();" required>
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
									name="sigungucode" id="sigungucode_" required>
									<option value="0">-- 선택 --</option>
								</select>
							</div>
								<div class="select-days input-group input-group-sm mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-sm">여행 일자</span>
									</div>
									<input name="travelDays" id="travelDays_" type="number" class="form-control" aria-label="Small"
										aria-describedby="inputGroup-sizing-sm" required>
								</div>
								
								
								<!-- 의뢰 글 -->
								<div class="info-container">
									<div class="cnt-container">
										<p class="textCount">0자</p>
										<p class="totalCount">/1000자</p>
									</div>
									<textarea class="textBox" name="requestContents" id="info_" id="textBox" style="height: 300px; resize: none;" maxlength="1000"
										placeholder="의뢰 관련 내용을 입력하세요" required></textarea>
								</div>
								
								
								
							<button id="requestBtn" type="submit" class="btn btn-outline-primary">플래너 의뢰하기</button>
								
				</form>
				
				
				
				</div>
				

			
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

<!-- 0917 request : 지역, 테마 옵션 구성하기 -->
<script>

//지역 옵션 구성하기
const createAreaOption = ()=>{ //class名으로 지역별 옵션 생성하기


//-------------------------------------------------------------------------------------------
//관심 지역 옵션 *생성 관련
const area = document.getElementsByClassName("area-class");
const sigungu = document.getElementsByClassName("sigungu-class");

	area[0].addEventListener("change", e=>{
	
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
		
			sigungu[0].innerHTML = "";
	
			let option = document.createElement("option");
			option.innerText = "세종특별자치시";
			option.value = 1;
			sigungu[0].appendChild(option);
		
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
		
		
		sigungu[0].innerHTML = "";
		let gyeongnam = ["거제시","거창군","고성군","김해시","남해군","마산시","밀양시","사천시","산청군","양산시",
						"의령군","진주시","진해시","창녕군","창원시",
						"통영시","하동군","함안군","함양군","합천군"]
	
		let code = 1;
		for(let i=0;i<10;i++){
			
			let option = document.createElement("option");
			option.innerText = gyeongnam[i];
			option.value = code++;
			sigungu[0].appendChild(option);					
		}
	
		//지역코드가 ~양산:10, 의령:12~임
		let codeFrom = 12;
		for(let i=10;i<gyeongnam.length;i++){
			
			let option = document.createElement("option");
			option.innerText = gyeongnam[i];
			option.value = codeFrom++;
			sigungu[0].appendChild(option);					
		}
		
	} else if (e.target.value==37){ //전북
		
		
		let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
					    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]
		insertInfo(jeonbuk);
		
		
	} else if (e.target.value==38){ //전남
		
		sigungu[0].innerHTML = "";
		//~여수시까지는 순차적임 (~13)
		//영광군부터 16~
		let jeonnam = ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시",
						"영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]

		let code = 1;
		for(let i=0;i<13;i++){
			
			let option = document.createElement("option");
			option.innerText = jeonnam[i];
			option.value = code++;
			sigungu[0].appendChild(option);					
		}
	
		//지역코드가 영광부터 16~임
		let codeFrom = 16;
		for(let i=13;i<jeonnam.length;i++){
			
			let option = document.createElement("option");
			option.innerText = jeonnam[i];
			option.value = codeFrom++;
			sigungu[0].appendChild(option);					
		}
		
	} else if (e.target.value==39){ //제주
		
		let jeju = ["남제주군","북제주군","서귀포시","제주시"]
		insertInfo(jeju);

	} else sigungu[0].innerHTML = "";
	
}); 

	console.log(sigungu);

	function insertInfo(city){ //지역 정보 대입 함수
		
		sigungu[0].innerHTML = "";
		let code = 1;
		
		city.forEach(e=>{
			
			let option = document.createElement("option");
			option.innerText = e;
			option.value = code++;
			sigungu[0].appendChild(option);
			
		});
		
	}

}


	//테마 옵션 구성하기
	const themeOne = document.getElementsByClassName("theme-select-one");	
	themeOne[0].addEventListener("change",e=>{
	//alert(e.target.value);
	const opt = e.target.value;
	
	if(opt=='none'){
	document.getElementsByClassName("theme-select-two")[0].innerHTML="";
	}
	
	if(opt=='A01'){			
		let nature = ["자연 관광지","관광 자원"];
		let val = ["A0101","A0102"];
		insertInto(nature,val);			
	}
	
	if(opt=='A02'){
		let culture = ["역사","휴양","체험","산업","건축/조형","문화시설","축제","공연/행사"];
		let val = ["A0201","A0202","A0203","A0204","A0205","A0206","A0207","A0208"];
		insertInto(culture,val);
	}
	
	if(opt=='C01'){
		let course = ["가족","나홀로","힐링","도보","캠핑","맛"];
		let val = ["C0112","C0113","C0114","C0115","C0116","C0117"];
		insertInto(course,val);
	}
	
	if(opt=='A03'){
		let repo= ["일반","육상","수상","항공","복합"];
		let val = ["A0301","A0302","A0303","A0304","A0305"];
		insertInto(repo,val);
	}
	
	if(opt=='shopping'){
		insertTheme('쇼핑하기','A0401');
	}
	if(opt=='food'){
		insertTheme('먹기','A0502');
	}
	if(opt=='free'){
		insertTheme('자유로운 여행','free');
	}
	
	});

	function insertTheme(theme,cat){ //단일 옵션
		const themeTwo = document.getElementsByClassName("theme-select-two");
		themeTwo[0].innerHTML="";
		let option = document.createElement("option");
		option.innerText = theme;
		option.value= cat;
		themeTwo[0].appendChild(option);
	}

	function insertInto(theme,val){ //복수 옵션
		
		const themeTwo = document.getElementsByClassName("theme-select-two");
		themeTwo[0].innerHTML="";

		for(let i=0;i<theme.length;i++){
			let option = document.createElement("option");
			option.innerText = theme[i];
			option.value = val[i];
			themeTwo[0].appendChild(option);
		}

	}
	
	//==============================================================================================
		
		
	//텍스트 박스 > 1000자 제한 확인
	const textBox = document.getElementsByClassName("textBox")[0];
	const textCnt = document.getElementsByClassName("textCount")[0];
	
	textBox.addEventListener("keyup",e=>{
		
		let content = e.target.value;
		//console.log(content.length);
		
		//글자 수 세기
		if(content.length==0||content==''){
			textCnt.innerText='0자';
		} else {
			textCnt.innerText= content.length+'자';
		}
		
		//글자 수 알림
		if(content.length>1000){
			//1000자부터는 타이핑 방지
			//e.target.value(e.target.value.substr(0,10));
			 content = content.substring(0, 1000);
			 
			//1000자 초과 시 알림창
			alert('글자 수 1000자까지 입력하실 수 있습니다');
		}
		
	});	
		

</script>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>