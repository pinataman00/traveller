<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/slideStyle.css"/>

<style>
.planner-photo{
    border-radius: 10px;
    width: auto;
    height: auto;
    max-width: 242px;
    max-height: 200px;
}
p.traveler-title{
	font-size: 18px;
    margin-top: 10px;
    padding-top: 10px;
}
p.traveler-info{
    margin: 18px;
    font-size: 15px;
    text-align: justify;
    display: contents;
}
.planner-container{

    display: flex;
    border-radius: 10px;
    margin: 10px;
    margin-top: 30px;
    padding: 13px;

}

.planners-big-container{
    display: flex;
    justify-content:center;
}

div.planner-info{
	margin:14px;
}

.planner-introduce-title{
	text-align:center;
    margin-top: 80px;
}

.plannerImg{

  width: 286px;
  height: 286.34px;
  object-fit: cover;

}

.planner-btn-container{

	text-align:center;

}
div.planner-btn-container a{

	width:110px;
	margin:3px;

}



</style>

<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="height:600px">

  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active mainImg">
      <img class="d-block w-100" src="${path}/resources/img/main01.jpg" alt="First slide">
		<div class="carousel-caption d-none d-md-block">
			<div class="textBox">
				<h5>먼저, 검색해보세요</h5>
				<p>언젠가 꿈꿔본 적 있던 여행지로 떠나요</p>
				<button type="button" class="btn btn-primary btn-sm" onclick="location.assign('${path}/place/placesMain')">검색하기</button>
			</div>
		</div>
		</div>
    <div class="carousel-item mainImg">
      <img class="d-block w-100" src="${path}/resources/img/map03.jpg" alt="Second slide">
      		<div class="carousel-caption d-none d-md-block">
	      		<div class="textBox">
				    <h5>잘 만든 플래너 하나</h5>
					<p>혼자, 또는 누군가와 함께 가슴 설레는 여행 계획을 세워보세요</p>
					<button type="button" class="btn btn-primary btn-sm" onclick="location.assign('${path }/planner/startPlanner')">플래너 만들기</button>
				</div>
		</div>
    </div>
    <div class="carousel-item mainImg">
      <img class="d-block w-100" src="${path}/resources/img/main04.jpg" alt="Third slide">
      		<div class="carousel-caption d-none d-md-block">
      		<div class="textBox">
			<p>전문가에게 맡겨보세요</p>
			<p>계획형은 아니지만, 잘 짜여진 여행을 하고 싶다구요?</p>
			<button type="button" class="btn btn-primary btn-sm" onclick="location.assign('${path }/member/creatorList')">플랜 의뢰하기</button>
			</div>
		</div>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<!-- TODO 0804) 플래너 회원 목록 출력하기 -->

 <div class="page-header planner-introduce-title">
  <h1>Members only! <small>여행 전문가에게 루트를 맡겨보세요!</small></h1>
  <p>원하는 지역과 테마를 말씀해보세요. 마음에 쏙 드는 여행 계획을 만들어 드릴게요</p>
</div>

<div class="row planners-big-container">
  <div class="planner-container">
<div class="card planner-info" style="width: 18rem;">
  <img class="card-img-top plannerImg" src="${path}/resources/img/testPic/pikachu.png" alt="Card image cap">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <div class="planner-btn-container">
	    <a href="#" class="btn btn-primary">구경하기</a>
	    <a href="#" class="btn btn-primary">의뢰하기</a>
    </div>
  </div>
</div>
<div class="card planner-info" style="width: 18rem;">
  <img class="card-img-top plannerImg" src="${path}/resources/img/testPic/ggobugi.png" alt="Card image cap">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <div class="planner-btn-container">
	    <a href="#" class="btn btn-primary">구경하기</a>
	    <a href="#" class="btn btn-primary">의뢰하기</a>
    </div>
  </div>
</div>
<div class="card planner-info" style="width: 18rem;">
  <img class="card-img-top plannerImg" src="${path}/resources/img/testPic/pairi.png" alt="Card image cap">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <div class="planner-btn-container">
	    <a href="#" class="btn btn-primary">구경하기</a>
	    <a href="#" class="btn btn-primary">의뢰하기</a>
    </div>
  </div>
</div>
</div>
</div>

<hr>




<%@ include file="/WEB-INF/views/common/footer.jsp"%>

