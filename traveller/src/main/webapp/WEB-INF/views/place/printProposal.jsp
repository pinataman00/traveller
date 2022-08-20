<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
<!-- 지도 관련 스크립트 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=LIBRARY"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services,clusterer,drawing"></script>

<style>
	.container{
		margin-top: 100px;
	}
	.container div{
		border: 1px solid red;
	}
	.btn-container{
		float:right;
	}
	#map{
		width:300px;
		height:300px;
	}
	.content-container{
		display:flex;
		justify-content:center;
	}
	.detail-info-container{
		width:400px;
	}
</style>
<section>
	<div class="container">
		<input id="pId" type="hidden" value="${proposalId}">


	<div class="temp-container">
		<div class="content-container">		
			<div class="detail-info-container">
				<div class="place-title-container">제목</div>
				<div class="place-info-container">소개글</div>
			</div>			
			<div class="addr-container">
				<div id="map" class="map-container">
					지도 
				</div>
				<p id="addr">주소</p>
			</div>				
		</div>

	</div>
			<div class="btn-container">
			<button class="btn btn-primary">등록하기</button>
			<button class="btn btn-primary">취소하기</button>
		</div>
	</div>
	
</section>
<script>

	//지도 출력하기
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	

	//proposalId에 대응하는 데이터 가져오기+화면에 정보 출력하기
	(()=>{
		
		const id = document.getElementById("pId").value;
		console.log(id);
		
		fetch('${path}/place/printProposal/${proposalId}',{
			method:'POST',
			headers:{
				'Content-Type':'application/json',
			},
			body:JSON.stringify({proposalId:id}),
			
			
		}).then(response=>response.json())
		.then(data=>{
			console.log("성공했어?",data);
		})
		
	})();
	
</script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
