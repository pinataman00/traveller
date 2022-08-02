<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/slideStyle.css"/>

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
				<button type="button" class="btn btn-primary btn-sm">검색하기</button>
			</div>
		</div>
		</div>
    <div class="carousel-item mainImg">
      <img class="d-block w-100" src="${path}/resources/img/map03.jpg" alt="Second slide">
      		<div class="carousel-caption d-none d-md-block">
	      		<div class="textBox">
				    <h5>잘 만든 플래너 하나</h5>
					<p>혼자, 또는 누군가와 함께 가슴 설레는 여행 계획을 세워보세요</p>
					<button type="button" class="btn btn-primary btn-sm" onclick="alert('안녕!');">플래너 만들기</button>
				</div>
		</div>
    </div>
    <div class="carousel-item mainImg">
      <img class="d-block w-100" src="${path}/resources/img/main04.jpg" alt="Third slide">
      		<div class="carousel-caption d-none d-md-block">
      		<div class="textBox">
			<h5>전문가에게 맡겨보세요</h5>
			<p>계획형은 아니지만, 잘 짜여진 여행을 하고 싶다구요?</p>
			<button type="button" class="btn btn-primary btn-sm">플랜 의뢰하기</button>
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


<%@ include file="/WEB-INF/views/common/footer.jsp"%>

