<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc"></script>
<style>
.view-main-container {
	margin-top: 100px;
}

.view-main-container div {
/* 	border: 1px solid red; */
}

.content-container {
	display: flex;
	justify-content: center;
}

.main-title {
	margin-left: 0px;
}

div.title-container {
	width: 1000px;
/* 	height:230px; */
	margin-left: 50px;
}
p#title{
	font-size:30px;
	font-weight:bolder;
}
p#address{
	font-size:15px;
}
p#theme{
	font-size:15px;
}
.jumbotron{
	/* background-image:url("${path}/resources/img/background02.jpg"); */
	background-color:#f5f5f5;
	border-radius:25px;
	text-align:left;
}
img#photo{

    width: 100%;
    height: 100%;
    overflow: hidden;
    width: 500px;
    height: 400px;
    object-fit: cover;
    border-radius:10px;

}
div#map{
	width:500px;
	height:400px;
	border-radius:10px;
	margin-right:10px;
}
button#routeBtn{
	margin-top:15px;
	float:left;
}
.info-container{
    text-align: justify;
    display: block;
    margin-left: 51px;
    width: 1000px;
}
</style>

<body>
	<section class="container">
		<div class="container view-main-container">

 			<div class="jumbotron title-container">
			    <p class="display-4" id="title">장소명</p>
				<input type="hidden" id="contentId">
			    <p class="lead address-container" id="address">주소</p>
			    <div class="lead address-container" id="homepage">
			    	<!-- 홈페이지 (없을 수도 있음) -->
			    </div>			    
			    <p class="lead address-container" id="theme">테마</p>
			    <p class="star-container">★★★★★</p>
			    <hr class="my-4">
				<p class="lead" style="float:right">
					<a class="btn btn-primary btn-sm" href="#" role="button">좋아요</a>
					<a class="btn btn-primary btn-sm" href="#" role="button">별점</a>
				</p>

			</div>
			<div class="info-container">
				<!-- 장소 관련 설명 (없을 수도 있음) -->
			</div>
			<div class="content-container">

				<div class="map-container">
					<div class="main-map-container">
						<div id="map"></div>
					</div>
					<!-- <button type="button" class="btn btn-primary" style="margin-top:15px;">길 찾기</button> -->
					<button id="routeBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#searchRoute">
						길 찾기
					</button>
				</div>
				<div class="photo-container">
					<img id="photo"></img>		
				</div>
			</div>
						
		</div>
	</section>
	
<div class="modal fade" id="searchRoute" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">길 찾기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <iframe id="linkForRoute" width="100%" height="800px" src="https://map.kakao.com/link/to/카카오판교오피스,37.402056,127.108212"></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
<!--         <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>
	
	
	
</body>

<script>

	const id = ${contentId}; //클라이언트가 클릭한 장소의 고유 ID
	(()=>{ //상세화면 출력하기
		

		console.log(id);
		
		fetch('${path}/place/placeDetail', {
			  method: 'POST', 
			  headers: {
			    'Content-Type': 'application/json',
			  },
			  body: JSON.stringify({"":id}),
			})
			.then((response) => response.json())
			.then((data) => {
			  
				console.log("성공했니? ", data);
				
				//제목
				const title = document.getElementById("title");
				title.innerText = data.title;
				//주소
				const address = document.getElementById("address");
				address.innerText = data.address;
				//사진
				const photo = document.getElementById("photo");
				
				if(data.firstImage!=null){					
					photo.src=data.firstImage;
			
				} else { //기본 이미지 출력
					photo.src= "${path}/resources/img/testPic/doraemon.png";
				}
				
				//지도 (좌표 정보)
				mapStarter(data.mapy,data.mapx);

				//테마 정보
				
				//루트 정보
				
				const routeTitle = data.title;
				const mapy = data.mapy;
				const mapx = data.mapx;
				console.log("/////////////////", routeTitle, mapy, mapx);
				
				routeStarter(routeTitle,mapy,mapx);
				//https://map.kakao.com/link/to/카카오판교오피스,37.402056,127.108212
				
				//console.log("/////////////// 장소 정보 확인 ////////////////////", data.info);
				if(data.info!=null&&data.info!=''){
					document.getElementsByClassName("info-container")[0].innerHTML = data.info;
				}
							
			});
						
	})();


	function routeStarter(title,latitude,longitude){
		document.getElementById("linkForRoute").src = "https://map.kakao.com/link/to/"+title+","+latitude+","+longitude;
	}

 	function mapStarter(latitude,longitude){
 		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	     mapOption = { 
	        center: new kakao.maps.LatLng(latitude,longitude), // 지도의 중심좌표 (첫 번째 저장한 장소)
	        level: 3 // 지도의 확대 레벨
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		//마커 생성 관련 ----------------------------------------------------------
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
			var markerPosition  = new kakao.maps.LatLng(latitude,longitude); 
			
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);

 	}
 
 	//장소 관련 상세 정보 --------------------------------------------------------------
 	console.log(id); // 토대로 공공API에서 관련 상세 정보 글 가져오기
 	
	const url = "https://apis.data.go.kr/B551011/KorService/detailCommon?serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D&MobileOS=ETC&MobileApp=AppTest&_type=json&contentId=${contentId}&contentTypeId=12&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y";
	//fetch(url).then(res=>console.log(res));
	fetch(url)
	.then(res=>res.json())
	.then(myJson=>{
		console.log(myJson);
		const obj = myJson.response.body.items.item[0]; //개별 아이템 가져오기
		//obj.overview
		console.log(obj);
		
		document.getElementsByClassName("info-container")[0].innerHTML = obj.overview;
		document.getElementById("homepage").innerHTML = obj.homepage;
		
	})


	
	
</script>


</html>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>