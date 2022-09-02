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
		border: 1px solid red;
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
		margin-right:30px;
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
	
		margin-top: 20px;
		margin-bottom: 20px;
		width:100px;
		height:100px;
 		max-width: 200px;
	    max-height: 200px;
	    border-radius: 50px;
	    
/* 	    border:1px solid red; */
	
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
			
<%-- 			<div class="card-body">
				<h5 class="card-title">나의 장소</h5>
				<p class="card-text">${loginMember.memberId}님이 "좋아요"한 장소들 모아보기</p>
				<a href="#" class="btn btn-primary">Go somewhere</a>
			</div> --%>
			
			<div class="content-body" style="border:1px solid red; margin-bottom:30px;">
			
				<div class="content-title-container">
					<p style="text-align:right; margin-top:10px; margin-right:30px;">내가 '좋아요'한 장소 모아보기</p>
				</div>
				
				<div class="option-container">
					<select name="likesId" id="catList" class="custom-select">
						<option value="notOpt" selected disabled>-- 선택 --</option>
					</select>
				</div>				
			</div>

			<div class="cards-container">
				카드가 들어갈 곳
				<!-- 카드 출력 예시 -->
							
			</div>


		</div>
	</div>
	
</section>

<script>

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
			
			console.log("${loginMember.memberId}가 좋아한 장소들 : ",data);
			
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
					
					const img = document.createElement("img");
					if(data[i].firstImage!=null){ //Place에 이미지 정보가 포함된 경우
						img.src= data[i].firstImage;
					} else { //미포함 시 기본 이미지 출력
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
					
					card.append(cardBody);
					container.append(card);
					document.getElementsByClassName("cards-container")[0].append(container);
					i++;
					
					
				}
				
				i--;
				
			}
			
			
		});
	
	
	
});


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>