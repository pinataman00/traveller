<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>



<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>traveller</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css2?family=Work+Sans&display=swap" rel="stylesheet">
<!-- bootstrap css -->
<link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/headerStyle.css"/>
<%-- <script src="${path}/resources/js/bootstrap.js"></script> --%>
<script src="${path}/resources/js/jquery-3.6.0.min.js"></script>

</head>

<body>
<style>
	.main-container{
		border:1px solid red;
		/* margin-top : 50px; */
		display:flex;
		overflow:hidden;
		height:100vh;
	}
	.editor-container{
		float:left;
		border: 1px solid blue;
		width: 300px;
		background-color: #E6F0F8;
		padding:10px;
		text-align:center;
	}
	.map-container{
		float:right;
		border:1px solid red;
		width:100%;
		margin-right:-300px;
		padding-right:300px;
	}
	div.title-container{
		margin:10px;
		margin-top:10px;
		text-align:left;
	}
	
	.planner-container{
		border:1px solid red;
		height: 75vh;
		overflow-y:scroll;
	}
	.planner-container::-webkit-scrollbar{
		display:none;
	}
	.btn-container{
		margin-top:15px;
	}
	div#dropZone{
		border:1px solid blue;
		margin-top: 10px;
	}
	.btn-controller{
		/* position:absolute; */
		left:10px;
		display:flex;
		padding:10px;
	}
	.btn-controller button{
		margin:2px;
	}
</style>

<section>

<%-- 	${tempPlanner.plannerTitle}
	${tempCrew.crewTitle} --%>
	<div class="main-container">
		<div class="editor-container">
			<div class="title-container">
				${tempPlanner.plannerTitle}
				플래너 제목
			</div>
			<div class="planner-container">
					<div class="daysOpt input-group mb-3">
						  <div class="input-group-prepend">
						    <label class="input-group-text" for="inputGroupSelect01">여행일자</label>
						  </div>
						  <select class="custom-select" id="inputGroupSelect01">
						    <option selected>Choose...</option>
						    <option value="1">One</option>
						    <option value="2">Two</option>
						    <option value="3">Three</option>
						  </select>
					</div>
				
					<div id="dropZone">
						<!-- 드래그 앤 드롭 카드가 배치될 영역 -->
					</div>
			 </div>
				<div class="btn-container">
					<button class="btn btn-primary" type="button">작성 완료</button>
					<button class="btn btn-primary" type="button">작성 취소</button>
				</div>
			</div>
		<!-- 지도 영역 -->	
		<div id="map" class="map-container">
		</div>
		
		
		<div class="btn-controller" style="left:10px;">
			<button class="btn btn-primary btn-sm" type="button">검색하기</button>
			<button class="btn btn-primary btn-sm" type="button">좋아요</button>
			<button class="btn btn-primary btn-sm" type="button">나의 그룹</button>
		</div>
		
		
	</div>
	
	
</section>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc"></script>
	<script>
		//1. 지도 출력
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		//2. 지도에 컨트롤러 올리기
		const btnController = document.getElementsByClassName("btn-controller");
		map.addControl(btnController[0], kakao.maps.ControlPosition.TOPLEFT);
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>