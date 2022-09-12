<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
	div#container{
		margin-top:100px;
		text-align:center;
	}
	.title-container{
		text-align:left;
	}
	
	.jumbotron{
		/* background-image:url("${path}/resources/img/pink.jpg"); */
		background-color:white;
		/* border: 1px solid red; */
		height:300px;
		padding-left:30px;
	}
	#profileImg{
		width:100px;
		height:100px;
	}
	select#catList{
		width:300px;
		float:right;
		margin-right:10px;
		margin-bottom:30px;
	
	}
	.cards-container{
		/* border: 1px solid blue; */
	}
	
	/* 카드 관련 설정 */
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
/*     width: 280px; */
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

/* 사용자 프로필 이미지 출력 관련 */
	img.profileImg{
	
		margin-top: -70px;
		margin-bottom: 10px;
		width:100px;
		height:100px;
 		max-width: 200px;
	    max-height: 200px;
	    border-radius: 10px;
	
	}
	

	
	
	.option-container{
		display:flex;
		float:right;
		align-items:baseline;
		margin-right:30px;
	}
	
	/* 결과 내 검색 관련 */
	.search-container{
		/* margin-top:50px; */
		margin-left:30px;
		float:right;
		display:flex;
	}
	

	
	.my-btn{
    float: right;
    margin-top: 10px;
    margin-bottom: 10px;
	}
	
	p#contentTitle{
	
	 text-align:right; 
	 margin-top:10px; 
	 margin-right:30px;
	
	}
	
	/* 플래너 출력 카드 */
	.my-planner-card{
	display:flex;
	}
	
	.card-title{
		font-weight:600;
	}

	.my-planner-theme{
		font-size:13px;
		margin-top:3px;
	}
	.my-planner-summary{
		margin-bottom:0px;
	}
	
	.planner-result-card{
		width:500px;
		height:150px;
		display:inline-block;
	}
	.my-planner-card{
		display:flex;
	}
	.planner-card-img{
		width: 130px;
	    height: 130px;
	    margin-top: 10px;
	    margin-left: 10px;
	    padding: 6px;
	    /* border: 1px solid red; */
	    

 		max-width: 130px;
	    max-height: 130px;
	    object-fit:cover;
	    over-flow:hidden;
	    border-radius: 10px;
	    
	    
	}
	.planner-info-container{
		width: 300px;
	    text-align: left;
	    margin-top: 10px;
	    margin-left: 10px;
	}
	.planner-btn-container{
		display:flex;
		margin-top:103px;
		margin-right:20px;
	}
	.planner-info-btn{
		margin-right:5px;
		
	}
	.planner-container{
		margin-left:30px;
		display:grid;
		height:500px;
		overflow-y:scroll;
	}
	.planner-container::-webkit-scrollbar{
		display:none;
	}
	
	
</style>

<section>
	<div id="container">

		<div class="jumbotron jumbotron-fluid">
			<div class="container title-container">
			
				<!-- 프로필 이미지 출력 -->
				<div id="myPic-container">
					<c:choose>					
						<c:when test="${not empty loginMember.image.oriName}">						
						</c:when>
						<c:when test="${empty loginMember.image.oriName}">
							<img id="profileImg" src="${path}/resources/img/icons/person-fill.svg">
						</c:when>
					</c:choose>
				</div>
				
				<p class="display-4" style="font-size:30px;font-weight:400;">나의 여행</p>
				<p class="lead">${loginMember.memberId}님의 여행 미리보기</p>
				<p class="my-introduce">${loginMember.introduce}</p>
			</div>
		</div>


		<div class="card text-center" style="margin-top:0px;">
			<div class="card-header">
				<ul class="nav nav-tabs card-header-tabs">
					<li class="nav-item"><a id="likeMenu" class="nav-link active" href="#" onclick="myLikes();">나의 장소</a></li>
					<li class="nav-item"><a id="planMenu" class="nav-link" href="#" onclick="myPlanner();">나의 플랜</a></li>
					<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a></li>
				</ul>
			</div>
			
			<div class="content-body" style="margin-bottom:30px;">
			
		
			
				<div class="content-title-container">
				
					<p id="contentTitle">내가 '좋아요'한 장소 모아보기</p>
					
				</div>
				
				<div class="option-container" style="display:flex;">
				
					<div class="myLikes-contents-container">
						<select name="likesId" id="catList" class="custom-select">
							<option value="notOpt" selected disabled>-- 선택 --</option>
						</select>
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#catEditor" onclick="myList();">편집</button>
					</div>
					
					<div class="myPlanner-contents-container" style="display:none;">
						<select name="plannerNo" id="plannerNo_" class="custom-select">
							<option value="notOpt" selected disabled>-- 선택 --</option>
						</select>
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#catEditor" onclick="plannerEditor();">편집</button>
					</div>
				</div>						
		
		
			</div>


<!-- Modal : 카테고리 편집 -->

<div class="modal fade" id="catEditor" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">카테고리 편집하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="cat-title-contianer">
        	<p style="text-align:left;">카테고리를 편집해보세요</p>
        </div>
        <div>
        
        			<select name="likesId" id="catList2" class="custom-select custom-select-sm" required>
						<option value="notOpt" selected disabled>-- 선택 --</option>
						<!-- 출력 예시 -->
						<!-- 0823) 좋아요 카테고리 추가함 
							 : LIKES테이블에서 불러오기 -->
<!-- 						<option value="basicLikes">좋아요</option> -->
					</select>
					<p id="addAlarm" style="color:red; display:none;">좋아요 카테고리를 먼저 추가해주세요!</p>
					
					<div class="my-btn-container">
					<button id="delCat" type="button" class="my-btn btn btn-outline-danger btn-sm" data-toggle="tooltip" data-placement="bottom" title="클릭 시 선택한 카테고리가 삭제됩니다">삭제하기</button>
					<button id="addCat" type="button" class="my-btn btn btn-outline-primary btn-sm" onclick="addCat();" style="margin-right:10px;">추가하기</button>					
					</div>
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
      </div>
    </div>
  </div>
</div>


					<div class="search-container" style="display:none;">
						<input id="keyword" name="keyword" class="form-control mr-sm-2" style="width: 444px;" 
						type="search" placeholder="결과 내 검색" aria-label="Search">
						<button class="btn btn-outline-success my-2 my-sm-0" type="submit" onclick="searchMyPlaces();">검색</button>
					</div>
					
					<div class="no-saved-place" style="margin-bottom:30px; display:none;">
						<p class="info-text" style="color:red;">저장된 장소가 없습니다! 나만의 장소를 추가해보세요!</p>
						<button type="button" class="btn btn-primary btn-lg" onclick="location.assign('${path}/place/placesMain')">여행지 탐색하기</button>
					</div>
					
					<div class="cards-container">
						<!-- 카테고리 옵션 선택 시, 검색 결과 카드가 출력될 영역 -->									
					</div>
					
					
					<div class="temp-container">
					<!-- 0907) 플래너 불러오기 -->
					<div class="planner-container" style="display:none;">


							<!-- TODO0908) 카드 출력 예시 -->
 							<div class="planner-result-card card">								
								<div class="my-planner-card">
									<img class="planner-card-img" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
									<div class="planner-info-container">
										<!-- 장소명  -->							
										<h5 class="card-title">Card title</h5>
										<!-- TODO0907) cat2를 기준으로 pasring해야 함 -->
										<p class="my-planner-summary">요약</p>
										<p class="my-planner-theme">테마</p>

									</div>
									
										<div class="planner-btn-container">
										<button type="button" class="btn btn-outline-primary btn-sm planner-info-btn">상세보기</button>
										<button type="button" class="btn btn-outline-primary btn-sm planner-del-btn">삭제하기</button>
										</div>												
								</div>								
							</div> 
					</div>

					
					
					
					
					</div>

		</div>
	</div>
	
</section>

<script>

//좋아요 > 카테고리 추가 입력창 열기 

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

})();


//좋아요 > 카테고리 추가 관련
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
		//select의 option에 추가하기 : select가 두 개임
		const select = document.getElementById("catList");
		const select2 = document.getElementById("catList2");
		
		let newOpt = document.createElement("option");
		newOpt.innerText= data.likesTitle;
		newOpt.value= data.likesId;
		
		select.append(newOpt);
		select2.append(newOpt);
		
		//collapse 다시 접기
		document.getElementById("catTitle").value=""; //입력창 초기화
		const block = document.getElementsByClassName("ok")[0];
		console.log("/////////////",block);
		block.style.display="none"; //접기
		
		
		
	});

	
}

//좋아요 목록 불러오기

const myList = ()=>{ //"편집" 버튼 클릭 시, 좋아요 목록 불러오기!
	
	//alert("안녕!");
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
			
			const select = document.getElementById("catList2");
			//존재하는 경우, select의 option으로서 저장된 리스트의 '항목'들 가져오기
			
			select.innerHTML = "";
			let basicOpt = document.createElement("option");
			basicOpt.innerText = "-- 선택 --";
			basicOpt.value="notOpt";
			basicOpt.selected="true";
			basicOpt.disabled="true";
			select.append(basicOpt);
			
			data.forEach(e=>{
				
				console.log("좋아요 리스트 : ",e);
				
				let opt = document.createElement("option");
				opt.innerText = e.likesTitle;
				opt.value= e.likesId;
				select.append(opt);
				
			});
		}
		
	});
	
	
	
}


//카테고리 삭제하기

		const delCat = document.getElementById("delCat");
		
		delCat.addEventListener("click",e=>{
			
			alert("안녕!");
			
			let likesId = document.getElementById("catList2").value;
			
			fetch('${path}/place/delCatagory.do', {
			  method: 'POST', 
			  headers: {
			    'Content-Type': 'application/json',
			  },
			  body: JSON.stringify({"likesId":likesId}),
			})
			.then((response) => response.json())
			.then((data) => {
				
				console.log("삭제 완료?", data);
				
 				if(data==0){
 					
					alert("삭제 실패! 다시 시도해주세요");
					
				} else if(data==1){
					alert("삭제 성공!");
					$("#catEditor").modal("hide");
					location.replace("${path}/member/myTrip.do");
				} 
				
			});
			
			
		});


//회원 프로필 이미지 출력 관련

		if(${loginMember.image.renamedFileName!=null}){

			async function getImg(){
				let response = await fetch("${path}/resources/member/profile/${loginMember.image.renamedFileName}");
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
			
			let opt = document.createElement("option");
			opt.innerText = e.likesTitle;
			opt.value= e.likesId;
			select.append(opt);
			
		});
	}
	
});

//나의 장소 > select > "option" 선택 시 해당 옵션에 저장된 데이터 불러올 수 있도록
//option의 value인 lcode를 기준으로 가져올 수 있음
const heartsList = document.getElementById("catList");
heartsList.addEventListener("change",e=>{
	
	//alert(e.target.value);
	const likesId = e.target.value;
	
	fetch('${path}/place/savedHearts.do', {
		  method: 'POST', 
		  headers: {
		    'Content-Type': 'application/json',
		  },
		  body: JSON.stringify({"likesId":likesId}),
		})
		.then((response) => response.json())
		.then((data) => {
			
			const cardContainer = document.getElementsByClassName("cards-container")[0];
			cardContainer.innerHTML="";
			
			if(data.length!=0){ //
				document.getElementsByClassName("search-container")[0].style.display="flex";
				document.getElementsByClassName("no-saved-place")[0].style.display="none";
				
			} else {
				document.getElementsByClassName("search-container")[0].style.display="none";
				document.getElementsByClassName("no-saved-place")[0].style.display="";
				
			}
			
			//console.log("${loginMember.memberId}가 좋아한 장소들 : ",data);
			
			//카드 출력하기
			createCards(data);

		});
		
});

//(공통) 카드 생성 함수 --------------------------------------------------------------------------

const createCards = (data)=>{ //매개변수 : DB에서 가져온 data배열
	
	
	//카드 출력하기
	for(let i=0;i<data.length;++i){
		
		const container = document.createElement("div");
		container.classList.add("search-result-contents");
		
		for(let j=0;j<3;j++){ //1행 당 3열씩 출력하기
			
			//1개 카드 구성하기
			//1. div > card
			const card = document.createElement("div");
			card.classList.add("result-card");
			card.classList.add("card");
			
			//이미지 firstImage
			const img = document.createElement("img");
			if(data[i].firstImage!=null){ //Place에 이미지 정보가 포함된 경우
				img.src= data[i].firstImage;
			} else { //미포함 시 기본 이미지 출력
				
				img.src="${path}/resources/img/testPic/doraemon.png";
				
			}
			
			//장소 contentId
			const contentId = data[i].contentId;
			img.addEventListener("click",e=>{
				location.assign("${path}/place/placeView/"+contentId);
			});
			card.append(img);
			
			const cardBody = document.createElement("div");
			cardBody.classList.add("card-body");
			const cardTitle = document.createElement("h5");
			cardTitle.classList.add("card-title");
			
			//장소명 title
			cardTitle.innerText = data[i].title; 
			cardBody.append(cardTitle);
			
			card.append(cardBody);
			container.append(card);
			document.getElementsByClassName("cards-container")[0].append(container);
			i++;
								
		}				
		i--;				
	}
	
	
}


//객체 생성하기

function myPlace (contentId, firstImage, title){
	
	this.contentId = cntentId;
	this.firstImage = firstImage;
	this.title = title;
	
}


//결과 내 검색 --------------------------------------------------------------------------
			
			const searchMyPlaces = ()=>{
				
				//카테고리 정보+keyword로 찾기
				let title = document.getElementById("keyword").value;
				let likesId = document.getElementById("catList").value;
				//console.log("카탈로그 : ",myCatagory); //LIKES_ID
				
				fetch('${path}/place/searchWithKeyword.do', {
					  method: 'POST', 
					  headers: {
					    'Content-Type': 'application/json',
					  },
					  body: JSON.stringify({"title":title, "likesId":likesId}),
					})
					.then((response) => response.json())
					.then((data) => {
						
						console.log(data);
						
						if(data.length==0){
							alert("검색결과가 없습니다");
						} else {
							
							document.getElementsByClassName("cards-container")[0].innerHTML="";
							createCards(data);	
						}
						
					});
				
			}


//===================================================================================================================
//0907) PLANNER 불러오기	


			const planMenu = document.getElementById("planMenu");
			const likeMenu = document.getElementById("likeMenu");
			const contentTitle = document.getElementById("contentTitle");
			
			const likesContainer = document.getElementsByClassName("myLikes-contents-container")[0];
			const plannerContainer = document.getElementsByClassName("planner-container")[0];
			
			
			//좋아요 관련
			const searchContainer = document.getElementsByClassName("search-container")[0];
			const noContent = document.getElementsByClassName("no-saved-place")[0];
			const cardContainer = document.getElementsByClassName("cards-container")[0];
			
			
			
			//플래너 ----------------------------------------------------------------------------------
			const myPlanner = ()=>{
				
				//메뉴 탭 활성화 대상 변경하기
				
				likeMenu.classList.remove("active");
				planMenu.classList.add("active");
				
				contentTitle.innerText= "내가 저장한 플래너 열람하기";
				
				likesContainer.style.display="none";
				//plannerContainer.style.display="";
				
				searchContainer.style.display="none";
				noContent.style.display="none";
				cardContainer.style.display="none";
				
				document.getElementById("plannerNo_").innerHTML="";
				//존재하는 경우, select의 option으로서 저장된 리스트의 '항목'들 가져오기
				
				plannerContainer.style.display="";
				
				//"플래너" 정보 불러오기 ---------------------------
				
				//alert("안녕!");
				let id = "${loginMember.memberId}";
				
				//1. 플래너 목록 불러오기
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
					
					if(data.length==0){
						plannerContainer.innerText = "저장된 플래너 목록이 없습니다";
					}
					
					plannerContainer.innerHTML="";
					
					//검색 결과 출력하기
					
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
							plannerImg.src= "${path}/resources/img/testPic/pikachu.png";
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
						
						const delBtn = document.createElement("button");
						delBtn.classList.add("btn");
						delBtn.classList.add("btn-outline-primary");
						delBtn.classList.add("btn-sm");
						delBtn.classList.add("planner-del-btn");
						delBtn.innerText="삭제하기";
						
						delBtn.addEventListener("click",e=>{
							
							//alert(data[i].plannerNo);
							delPlanner(plannerNo);
							
						});
						
						plannerBtnContainer.append(delBtn);
						
						myPlannerCard.append(plannerBtnContainer);
						
						//----------------------------------------------------------------------
						plannerCard.append(myPlannerCard);
						plannerContainer.append(plannerCard);
						
											
					}				
								
				
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					

					
				});

			}
			
			
			
			//좋아요 ----------------------------------------------------------------------------------
			const myLikes = ()=>{
				
				planMenu.classList.remove("active");
				likeMenu.classList.add("active");
				
				contentTitle.innerText= "내가 '좋아요'한 장소 모아보기";
				
				plannerContainer.style.display="none";
				likesContainer.style.display="";
				
				//likesMainContainer.style.display="";
				cardContainer.style.display="";
				plannerContainer.style.display="none";
			}
			
			//삭제하기 -----------------------------------------------------------------------------------
			const delPlanner = (num) =>{ //플랜 삭제하기!
				
				alert(num);
				let plannerNo = num; 
				console.log(plannerNo);
				
				  fetch('${path}/planner/deletePlanner/'+num, {
					  method: 'POST', 
					  headers: {
					    'Content-Type': 'application/json',
					  }
					})
					.then((response) => response.json())
					.then((data) => {
						
						console.log("삭제 잘 했니? ",data);
						if(data==1){
							alert("삭제 성공!");
							location.reload();
						} else {
							alert("삭제 실패! 다시 시도해주세요");
							
						}
						
					});
				
			
				
			}
			
			
			
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>