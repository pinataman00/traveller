<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>

	.container{
		margin-top: 80px;
	}
	.jumbotron{
		border-radius:25px;
	}
	.list-main-container{
		/* border: 1px solid red; */
		display:flex;
		justify-content:center;
/* 		height: 500px; */
/* 		overflow:scroll; */
		margin-top:10px;
	}
	.planner-info{
		margin: 10px;
		height: 360px;
	}
	.plannerImg{
	
	    width: 100%;
	    height: 100%;
	    overflow: hidden;
	    width: 280px;
	    height: 200px;
	    object-fit: cover;
	    border-radius:10px;
	    margin-top:10px;
	    padding:10px;	
	    /* border: 0.5px solid #dcdcdc; */
	}
	.card-title{
		font-size:20px;
	}
	.result-container{
		height:600px;
		overflow:scroll;
	}
	.result-container::-webkit-scrollbar{
		display:none;
	}
	.creatorView{
		margin-right:5px;
	}
</style>

<section>
	
	<div class="container">

		<div class="list-banner-container">
			<div class="jumbotron">
				<h1 class="display-4">Traveller의 크리에이터</h1>
				<p class="lead">당신의 마음에 쏙 드는 여행 계획을 만들어드릴게요!</p>
				<hr class="my-4">
				<p>크리에이터의 포트폴리오를 구경하고, 의뢰해보세요</p>
				<p class="lead">
					<a class="btn btn-primary btn-sm" href="#" role="button"
						data-toggle="tooltip" data-placement="bottom"
						title="크리에이터가 되고 싶다면, 지금 바로 신청해보세요!">크리에이터 신청하기</a>
				</p>
			</div>
		</div>

	   <hr>
	   
	   
	   
	   <div class="result-container">
	   
<%-- 	   <div class="list-main-container" style="display:flex;">

			<!-- 크리에이터 카드 출력 예시 -->
			<div class="card planner-info" style="width: 18rem;">
				<img class="card-img-top plannerImg"
					src="${path}/resources/img/testPic/pikachu.png"
					alt="Card image cap">
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<div class="planner-btn-container">
						<a href="#" class="btn btn-primary">구경하기</a> <a href="#"
							class="btn btn-primary">의뢰하기</a>
					</div>
				</div>
			</div>
			
			<div class="card planner-info" style="width: 18rem;">
				<img class="card-img-top plannerImg"
					src="${path}/resources/img/testPic/pikachu.png"
					alt="Card image cap">
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<div class="planner-btn-container">
						<a href="#" class="btn btn-primary">구경하기</a> <a href="#"
							class="btn btn-primary">의뢰하기</a>
					</div>
				</div>
			</div>
			<div class="card planner-info" style="width: 18rem;">
				<img class="card-img-top plannerImg"
					src="${path}/resources/img/testPic/pikachu.png"
					alt="Card image cap">
				<div class="card-body">
					<h5 class="card-title">Card title</h5>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<div class="planner-btn-container">
						<a href="#" class="btn btn-primary">구경하기</a> <a href="#"
							class="btn btn-primary">의뢰하기</a>
					</div>
				</div>
			</div>

		</div> --%>



	</div>
</div>
</section>
<script>

	//MEMBER테이블에서 GRADE가 'planner'인 회원 목록 출력하기
	fetch('${path}/member/selectPlanners.do', {
	  method: 'POST', 
	  headers: {
	    'Content-Type': 'application/json',
	  },
	  //body: JSON.stringify({"memberId":memberId,"title":title}),
	})
	.then((response) => response.json())
	.then((data) => {
		
		console.log(data);
		//console.log(data[0]['memberId']); //아이디
		//console.log(data[3]['image']['renamedFileName']); //이미지 > 이미지 등록 안 된 경우는 null임
		console.log("총 몇 명? : ",data.length);
		//1행 당 3개씩 출력하기
		for(let i=0;i<data.length;i++){
			
			//1행 > 여기에 콘텐츠 카드가 3장씩 담길 것임
			const container = document.createElement("div");
			container.classList.add("list-main-container");
			
			for(let j=0;j<3;j++){
				
				//1개 콘텐츠 구성하기
				//1. card, planner-info
				const card = document.createElement("div");
				card.classList.add("planner-info");
				card.style.width="18rem";
				card.classList.add("card");
				
				//2. img
				const img = document.createElement("img");
				img.classList.add("card-img-top");
				img.classList.add("plannerImg");
				
				let imgTemp = data[i]['image']['renamedFileName'];
				
					if(imgTemp!=null){
						img.src= "${path}/resources/member/profile/"+imgTemp;
					} else {
						img.src= "${path}/resources/img/traveller/basicImg.png";
					}
				//img.alt = data[i].memberId;
				
				//card, planner-info에 추가하기
				card.append(img);
				
				//3. card-body
				const body = document.createElement("div");
				body.classList.add("card-body");
				//3-1. card-title
				const title = document.createElement("h");
				title.classList.add("card-title");
				console.log(data[i].memberId);
				title.innerText = data[i].memberId;
				//3-2. card-text
				const text = document.createElement("p");
				text.classList.add("card-text");
				
				let tempIntroduce = data[i]['introduce'];
				if(tempIntroduce!=null){
					text.innerText= tempIntroduce;
				} else text.innerText = "안녕하세요! "+data[i]['memberId']+"입니다";
				
				
				
				//3-3. btn-container
				const btnContainer = document.createElement("div");
				btnContainer.classList.add("planner-btn-container");
				//3-3-1. a링크들
				const creatorView = document.createElement("a");
				creatorView.href="${path}/member/creatorsBlog/"+data[i]['memberId'];
				creatorView.classList.add("btn");
				creatorView.classList.add("btn-primary");
				creatorView.classList.add("creatorView");
				creatorView.innerText="구경하기";
				
				
				
				const request = document.createElement("a");
				request.href="#";
				request.classList.add("btn");
				request.classList.add("btn-primary");
				request.classList.add("request");
				request.innerText="의뢰하기";
				//card, planner-info에 추가하기
				body.append(title);
				body.append(text);
				btnContainer.append(creatorView);
				btnContainer.append(request);
				body.append(btnContainer);
				card.append(body);
				
				//container에 추가하기
				container.append(card);
				document.getElementsByClassName("result-container")[0].append(container);
				i++;
			}
			i--;
		}
		
		
	});


</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>