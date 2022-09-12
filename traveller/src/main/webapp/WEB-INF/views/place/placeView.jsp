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
			    <!-- <p class="star-container">★★★★★</p> -->
			    <hr class="my-4">
				<p class="lead" style="float:right;">
					<button id="likeBtn" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#addLikesList" role="button">좋아요</button>
					<!-- <button class="btn btn-primary btn-sm" href="#">별점</button> -->
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
<!-- 					<button id="routeBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#searchRoute">
						길 찾기
					</button> -->
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


<!-- TODO0830) Modal : 좋아요 목록 추가 관련 -->
<!-- Modal : 좋아요 목록 추가 관련 -->
<div class="modal fade" id="addLikesList" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content likes-main-container">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle" style="float:left;">
        	<p class="likedPlace"></p>   
        	<p id="savedPlace" style="font-size:10pt; color:green; display:none;">이미 좋아요 목록에 추가된 장소입니다</p>
        	<!-- 이미 목록에 추가된 장소라면, lcode정보 확인할 수 있어야 함! -->
        	<input type="hidden" id="lcode_" name="lcode">     
        </h5>
                	
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
     		 <!-- 이미 "좋아요"리스트에 추가된 경우에는 "좋아요 취소하기"버튼 활성화하기 -->	
		      <div class="modal-body">
		      		<!-- mybatis : LikesInfo객체와 연결하기 -->
		        	<input type="hidden" name="contentId" id="placeCode"> 
		        	<select name="likesId" id="catList" class="custom-select custom-select-sm" required>
						<option value="notOpt" selected disabled>-- 선택 --</option>
						<!-- 출력 예시 -->
						<!-- 0823) 좋아요 카테고리 추가함 
							 : LIKES테이블에서 불러오기 -->
<!-- 						<option value="basicLikes">좋아요</option> -->
					</select>
					
					<p id="addAlarm" style="color:red; display:none;">좋아요 카테고리를 먼저 추가해주세요!</p>
					<button id="addCat" type="button" class="btn btn-outline-primary btn-sm" onclick="addCat();">카테고리 +</button>
					
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
		      <div class="modal-footer">
		        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> -->
		        <button id="delHeart" type="button" class="btn btn-outline-danger" style="display:block;" data-dismiss="modal">좋아요 취소하기</button>
		        <button id="liked-btn" type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveLikes()">추가하기</button>
		      </div>
      
    </div>
  </div>
</div>	


	
	
	
</body>

<script>


	//---------------------------------------------------------------------------------------------------------------------
	//좋아요 MODAL 관련 > placeView에 작성한 코드 활용하기
	
	
		let heart = document.getElementById("likeBtn");
		//'좋아요' 리스트에 추가하기 > modal창 관련
		//const addLikes = (heart,data) => {
			
			heart.addEventListener("click",e=>{
				
				if(${loginMember!=null}){ //로그인 여부 확인 > 회원 전용 기능
					
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
								
								console.log("좋아요 리스트 : ",e);
								
								let opt = document.createElement("option");
								opt.innerText = e.likesTitle;
								opt.value= e.likesId;
								select.append(opt);
								
							});
						}
						
					});
					
					//---------------------------------------------------------------
					//사용자가 이미 "좋아요"항목에 추가한 경우 *알림 및 취소하기 버튼 활성화
					//-> TODO) 어떤 카테고리에 추가된 장소인지 확인할 수 있으면 좋은데...
					
 	 				function getHearts(){
	 					
	 					let memberId = "${loginMember.memberId}";
	 					
	 					const res = fetch('${path}/place/heartInfo.do', {
							  			method: 'POST', 
							  			headers: {
							    		'Content-Type': 'application/json',
							  			},
							  			body: JSON.stringify({"memberId":memberId}),
										});
	 					
	 					return res.then(res=>res.json());
	 					
	 					
	 				} 
					
					//기본 : "이미 추가된 장소" 안내 문구, "취소하기" 버튼은 숨기기
	 				document.getElementById("savedPlace").style.display="none";
	 				document.getElementById("delHeart").style.display="none";
	 				
					let placeId = document.getElementById("placeCode").value;
					console.log("장소 코드 확인 : ",placeId);
					
 	 				async function exec(placeId){
	 					
	 					let hearts;
	 					
	 					
	 					try{
	 						
	 						hearts = await getHearts();
	 						
	 						const values = Object.values(hearts); //객체의 value값들을 하나의 배열로 묶어주는 함수
	 						//console.log("values : ",values);
	 						
	 						const entries = Object.entries(hearts); //객체의 [key,value]를 한 벌의 이중 배열 형태로 반환해주는 함수
	 						//console.log("entries : ",entries);
	 						
	 						//entries로 순회하기
	 						//-> contentId에 대응되는 lcode 값도 input에 저장하기
	 						for(let i=0;i<entries.length;i++){
	 							
	 							//if(entries[i])
	 							//console.log(entries[i][1]);
	 							
	 							if(placeId==entries[i][1]){
	 								document.getElementById("lcode_").value=entries[i][0];
	 								document.getElementById("savedPlace").style.display="block";
									document.getElementById("delHeart").style.display="block";
	 							}
	 							
	 							
	 						}
					
	 						
	 					} catch(error){
	 						console.log(error);
	 					}
	 					
	 				} 
					
					exec(placeId);

					
					//좋아요 추가하기 -> 선택한 항목에 장소 정보 저장하기
					document.getElementById("liked-btn").onclick = ()=>{
						
				 		let contentId = document.getElementById("placeCode").value;
						let likesId = document.getElementById("catList").value;
						
						if(likesId=="notOpt"){
							
							alert("옵션을 선택해주세요!");
								
						} else {
							
							fetch('${path}/place/saveLikes.do', {
								  method: 'POST', 
								  headers: {
								    'Content-Type': 'application/json',
								  },
								  body: JSON.stringify({"contentId":contentId,"likesId":likesId}),
								})
								.then((response) => response.json())
								.then((data) => {
									
									console.log("좋아요 추가 완료? ",data);
									
								});
											
							//"좋아요" 표시 변경 -> 하트 색상 변경하기
							//heart.src =  "${path}/resources/img/icons/heart-fill.svg";
							
							
						}

					}
					
					//0830)
					//'좋아요 취소하기' 로직
					document.getElementById("delHeart").addEventListener("click",e=>{
						
						//1. LIKES_INFO테이블에 저장된 데이터 삭제를 위해 lcode 가져오기
						let lcode = document.getElementById("lcode_").value;
						
 						fetch('${path}/place/deleteLikes.do', {
							  method: 'POST', 
							  headers: {
							    'Content-Type': 'application/json',
							  },
							  body: JSON.stringify({"lcode":lcode}),
							})
							.then((response) => response.json())
							.then((data) => {
								
								console.log("좋아요 삭제 완료? ",data);
								if(data==1){
									alert("좋아요 취소 완료!");
									heart.src =  "${path}/resources/img/icons/heart.svg";
								}
								
							});
						
						//하트 색상 변경하기
						//heart.src =  "${path}/resources/img/icons/heart.svg";
					});
					

										
				} else alert('로그인 먼저!');
			
			});

		//좋아요 카테고리 추가 관련
		
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

	//----------------------------------------------------------------------------------------------------------------------
	const id = ${contentId}; //클라이언트가 클릭한 장소의 고유 ID
	(()=>{ //상세화면 출력하기
		

		console.log(id);
		
		fetch('${path}/place/placeDetail', {
			  method: 'POST', 
			  headers: {
			    'Content-Type': 'application/json',
			  },
			  body: JSON.stringify({"contentId":id}),
			})
			.then((response) => response.json())
			.then((data) => {
			  
				console.log("성공했니? ", data);
				
				//제목
				//1. 기본 페이지 출력
				const title = document.getElementById("title");
				title.innerText = data.title;
				//2. 좋아요 Modal창 title영역에 출력
				document.getElementsByClassName("likedPlace")[0].innerText=data.title;
				//장소 contentId
				document.getElementById("placeCode").value=data.contentId;
				
				//주소
				const address = document.getElementById("address");
				address.innerText = data.address;
				//사진
				const photo = document.getElementById("photo");
				
				if(data.firstImage!=null){					
					photo.src=data.firstImage;
			
				} else { //기본 이미지 출력
					photo.src= "${path}/resources/img/traveller/basicImg.png";
				}
				
				//지도 (좌표 정보)
				mapStarter(data.mapy,data.mapx);

				//테마 정보
				const themeData = data.cat2;
				const theme = document.getElementById("theme");
				
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