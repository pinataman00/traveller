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
<link rel="stylesheet" type="text/css" href="${path }/resources/css/mapStyle.css"/>
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
		background-color: rgba( 255, 255, 255, 0.5 );
	}
	.btn-controller button{
		margin:2px;
	}
	#myLikes{
		height: 600px;
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
		
		
		
		
		
		
		
		
		
		
		
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		            	<h1 id="listTitle" style="text-align:left;padding:10px;margin-bottom:0px;margin-left:5px;font-family:Rubik;">SEARCH!</h1>
		                <form onsubmit="searchPlaces(); return false;" id="searchBox">
		                    	<input type="text" value="" id="keyword" size="40" placeholder="검색어를 입력하세요"> 
		                    	<button id="searchBtn" type="submit">검색하기</button> 
		                </form>
		            </div>
		        </div>
		        <hr id="listLine">
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>  
    		</div>
		
		
		
		
		
		
		
		
		
		

		<!-- 지도 관련 컨트롤러 -->
		<div class="btn-controller" style="left:10px;">
			<button class="btn btn-primary btn-sm" type="button">검색하기</button>
			<button tyle="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">나의 메뉴</button>
		
				<!-- dropdown : 사용자 아이템 드롭다운 -->
			  <div class="dropdown-menu">
			    <a class="dropdown-item" href="#">나의 좋아요</a>
			    <a class="dropdown-item" href="#">나의 그룹</a>
			    <a class="dropdown-item" href="#">나의 체크 리스트</a>
			    <div class="dropdown-divider"></div>
			    <a class="dropdown-item" href="#">날씨</a>
			    <a class="dropdown-item" href="#">길 찾기</a>
			  </div>

		</div>
		
		
	</div>
	

  
<!-- Modal : 좋아요 -->
<div class="modal fade" id="myLikes" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">나의 좋아요</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        "좋아요"를 클릭했던 장소들
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>





	
</section>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc"></script>
	<script>
	
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
		
		//3. 클릭 시, 해당 위치에 마커 꽂기 ---------------------------------------------------------------------------
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    //alert("위도 "+latlng.getLat()+" "+"경도 "+latlng.getLng());
		    
		});
	</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>