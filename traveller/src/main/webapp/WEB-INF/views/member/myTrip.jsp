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
		border: 1px solid blue;
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

/* 사용자 프로필 이미지 출력 관련 */
	img.profileImg{
	
		margin-top: -70px;
		margin-bottom: 10px;
		width:100px;
		height:100px;
 		max-width: 200px;
	    max-height: 200px;
	    border-radius: 50px;
	    
/* 	    border:1px solid red; */
	
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
					<li class="nav-item"><a class="nav-link active" href="#">나의 장소</a></li>
					<li class="nav-item"><a class="nav-link" href="#">나의 플랜</a></li>
					<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a></li>
				</ul>
			</div>
			
			<div class="content-body" style="border:1px solid red; margin-bottom:30px;">
			
				<div class="content-title-container">
					<p style="text-align:right; margin-top:10px; margin-right:30px;">내가 '좋아요'한 장소 모아보기</p>
				</div>
				
				<div class="option-container" style="display:flex;">
					<select name="likesId" id="catList" class="custom-select">
						<option value="notOpt" selected disabled>-- 선택 --</option>
					</select>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#catEditor" onclick="myList();">편집</button>
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


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>