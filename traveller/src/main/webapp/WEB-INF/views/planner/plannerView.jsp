<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc"></script> -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services"></script>	
<style>

 div.main-container{
 	margin-top : 100px;
 	border: 1px solid red;
 }
 .container div{
 	border: 1px solid blue;
 }
 .plan-content-container{
 	display:flex;
 }	
.plan-list-container{
	width:30%;
	height:500px;
	border-radius:10px;
}
.map-container{
	width:70%;
	height:500px;
	border-radius:10px;
}
.basic-info-container p{
	text-align:left;
}
#plannerTitle{
	font-size:30px;
	font-weight:800;
	margin-bottom:0px;
}
.plan-card{
	border:1px solid red;
	border-radius:10px;
	height:90px;
	text-align:left;
	margin-bottom:10px;
}
.text-container{
	margin-left:10px;
	height:80px;
}
.place-title{
	margin-bottom:0px;
	margin-top:10px;
}
.place-addr{
	font-size:13px;
	margin-bottom:0px;
	font-weight:100;
}
.memo{
	font-size:11px;
	margin-top:3px;
}
.card-container{
	 overflow:scroll;
	 height:430px;
	 border:1px solid red;
}
.card-container::-webkit-scrollbar{
	display:none;
}
p#planTheme{
	text-align:right;
	margin-right:30px;
}


</style>
<section class="container">
	<div class="container-fluid main-container">
		<div class="basic-info-container">			
				<p id="plannerTitle">내가 작성한 플래너</p>
				<p id="summary">플래너 설명</p>
				<!-- TODO 0910) 플래너 테마 : 이모지로 표시하기 -->
				<p id="planTheme">플래너 테마</p>
		</div>

		<div class="plan-content-container">
			<div class="plan-list-container">

				<div class="input-group mb-3 option-container">
					<div class="input-group-prepend">
						<label class="input-group-text" for="inputGroupSelect01">여행일자</label>
					</div>
					<select class="selectDays custom-select" id="inputGroupSelect01">
						<option selected disabled>-- 선택 --</option>
					</select>
				</div>

				<div class="card-container">
					<!-- plan이 리스트로 들어감 -->
					<!-- 카드 출력 예시 -->
<!-- 					<div class="plan-card">
						<div class="text-container">
							<p class="place-title">여행지 이름</p>
							<p class="place-addr">여행지 주소</p>
							<p class="memo">메모</p>
						</div>
					</div> -->
					
				</div>
				
				
				
				
			</div>
			<div class="map-container">
				<!-- 지도가 들어가는 영역 -->
				<div id="map" style="border:1px solid red; height:500px;"></div>
			</div>
		</div>
		<div class="controller-container" style="display:flex;float:right;">

			<div class="btn-container">
				<button type="button" class="btn btn-outline-primary btn-sm" onclick="downloadPlan();">다운받기</button>
				<button type="button" class="btn btn-outline-primary btn-sm">수정하기</button>
			</div>
		</div>	
	
	</div>
	

</section>
<script>

	
	const plannerNo = "${plannerNo}";
	
	
	//PLANNER 정보
	//console.log("PLANNER : ",${planner});
	//※ PLANNER, title, summary, theme정보는 가지고 와야 함...
	const plannerTitle = document.getElementById("plannerTitle");
	const plannerSumamry = document.getElementById("summary");
	plannerTitle.innerText = "${planner.plannerTitle}";
	plannerSumamry.innerText = "${planner.summary}";

	//card가 출력될 영역
	const cardContainer = document.getElementsByClassName("card-container")[0];
	
	const selectDays = document.getElementsByClassName("selectDays")[0];
	const travelDays = ${planner.travelDays}; //여행 일자
	//select > option 생성하기
	
	
		for(let i=1;i<=travelDays;i++){
			
			const opt = document.createElement("option");
			opt.value=i;
			opt.innerText=i;
			selectDays.append(opt);
			
		}
	
	
	//플래너 테마 가져오기
	//console.log("${planner.theme}");
	
	const myTheme = "${planner.theme}";
	const theme = document.getElementById("planTheme");
	console.log("테마? ",myTheme);
	
					switch(myTheme){
				
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
	
	
	
	
	//--------------------------------------------------------------------------------
	//PLAN데이터 가져오기 > select option이 변경되면, 일자에 대응되는 PLAN을 불러옴

	let addrArr = [];
	
	(()=>{
		
	
		fetch('${path}/planner/plannerDetail',{
			method:'POST',
			headers:{
				'Content-Type':'application/json',
			},
			body:JSON.stringify({"plannerNo":plannerNo}),
		})
		.then((response)=>response.json())
		.then((data)=>{
			
			console.log("데이터 가져왔니 ? ", data);
			
			//지도 생성하기 > 기본 : 1일 차의 첫 번째 방문지를 중심으로 지도 생성함
			printMap(data[0].latitude,data[0].longitude);
			console.log(data[0].latitude," , ",data[0].longitude)
			let forLine = [];
			
			//장소 정보 저장하기
			
			
			for(let a=0;a<data.length;a++){
				getAddress(data[a].latitude,data[a].longitude,addrArr);
			}
			

			
			selectDays.addEventListener("change",e=>{
				
				//alert(e.target.value);
				cardContainer.innerHTML="";
				document.getElementById('map').innerHTML="";
				
				//선택한 일자
				let ckDay = e.target.value;

				let markersArr = [];
				forLine.length=0; //배열 초기화
				
				for(let i=0;i<data.length;i++){
					
					if(data[i].day==ckDay){ //선택한 옵션 일자에 대응되는 장소 정보 출력하기 
						
						//지도 생성
						//printMap(data[i].latitude,data[i].longitude);
						
						//리스트 업---------------------------------------------------------------
						//"카드" 생성 -> 리스트 추가
							const planCard = document.createElement("div");
							planCard.classList.add("plan-card");
							
							
							const txtContainer = document.createElement("div");
							txtContainer.classList.add("text-container");
							
							const title = document.createElement("p");
							title.classList.add("place-title");
							title.innerText = data[i].placeName;
							
							moveMap(title,data[i].latitude,data[i].longitude);
							
							//title.setAttribute("onclick", moveMap(title,data[i].latitude,data[i].longitude));
							title.addEventListener("click",e=>{
								//alert(data[i].placeName);
								moveMap(data[i].placeName,data[i].latitude,data[i].longitude);
							})
							
							
							console.log("제목 : ",title);

							
							const addr = document.createElement("p");
							addr.classList.add("place-addr");
							getAddr(data[i].latitude,data[i].longitude,addr);								
							
							const memo = document.createElement("p");
							memo.classList.add("memo");
							memo.innerText = data[i].memo;
							
							planCard.append(txtContainer);
							txtContainer.append(title);
							txtContainer.append(addr);
							txtContainer.append(memo);
							
							
							//const forOpt = document.createElement("input")
							
							cardContainer.append(planCard);
						
						//지도 관련 -----------------------------------------------------------------
						//1. 마커 표기하기						
						//"배열"에 저장하기
						
						markersArr.push(new place(data[i].placeName,data[i].latitude,data[i].longitude));
						//console.log(ckDay,"방문 장소 : ",markersArr);
						forLine.push(new kakao.maps.LatLng(data[i].latitude,data[i].longitude));
						
						//--------------------------------------------------------------------------

						
					}

				}
				console.log("일자별 방문 장소 : ",markersArr);
				printInfo(markersArr,forLine); //지도, 마커, 선 등 비주얼 정보 출력하기
				
			});
			
			
			
			
			


		});

	})();
	
	
	
	
	
	//마커생성+지도 생성
	function printInfo (positions,forLine) {
	
	console.log(positions);
	//console.log(positions[0].latlng.La);

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(positions[0].latlng.Ma,positions[0].latlng.La), // 지도의 중심좌표
        level: 10 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 

	// 마커 이미지의 이미지 주소입니다
 	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
	    
	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(24, 35); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
  
	} 

	//마커 간을 잇는 선 그리기 -----------------------------------------------------
	//선 생성 관련 --------------------------------------------------------------
	var polyline = new kakao.maps.Polyline({
	    path: forLine, // 선을 구성하는 좌표배열 입니다
	    strokeWeight: 5, // 선의 두께 입니다
	    strokeColor: '#FFAE00', // 선의 색깔입니다
	    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid', // 선의 스타일입니다
		endArrow:true
	});

	// 지도에 선을 표시합니다 
	polyline.setMap(map); 

	

	}
	
	//카드에 마우스 오버 시, 해당 마커로 시점 이동 --------------------------------------

		


     		
     	//TODO 0911) "클릭" 횟수에 따라 (홀/짝), 함수 달리 대응하기 > 클로저 활용
     			//좋아요 카테고리 추가 관련
		
	function moveMap (title,latitude,longitude){
		
		let thisMarker = "";
		const lat = latitude;
		const lng = longitude;
		
		console.log("카운트 : ", document.getElementsByClassName("selectDays")[0].value);
		
		const sel = document.getElementsByClassName("selectDays")[0]; //select 선택
		
		
		let cnt= 0;
		
		title.addEventListener("click",title=>{

			
			if(++cnt%2!=0){
	 			panTo(lat,lng);
				title.target.style.color="red";
				
			} else {
				
				
				title.target.style.color="";
				const opt = document.getElementsByClassName("selectDays")[0].value;
				console.log("옵션 확인 : ",opt,"일자를 선택하셨네요");
				reloadPage(sel,opt);
	
			}
			
		});

	}
    
     	
	function reloadPage(sel,opt){ //타이틀 재클릭 시, 전경으로 지도 축소		
		localStorage.setItem("day",opt);		
		location.reload();		
	}

	(()=>{
		
		const sel = document.getElementsByClassName("selectDays")[0];
		
		
		for(let i=0;i<sel.length;i++){
			
			if(sel[i].value==localStorage.getItem("day")){
				
				console.log("//////////////",localStorage.getItem("day"));
				sel[i].selected= true;
				
				//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~				
				
						fetch('${path}/planner/plannerDetail',{
			method:'POST',
			headers:{
				'Content-Type':'application/json',
			},
			body:JSON.stringify({"plannerNo":plannerNo}),
		})
		.then((response)=>response.json())
		.then((data)=>{
			
			console.log("데이터 가져왔니 ? ", data);
			
			//지도 생성하기 > 기본 : 1일 차의 첫 번째 방문지를 중심으로 지도 생성함
			printMap(data[0].latitude,data[0].longitude);
			console.log(data[0].latitude," , ",data[0].longitude)
			let forLine = [];

				
				//alert(e.target.value);
				cardContainer.innerHTML="";
				document.getElementById('map').innerHTML="";
				
				//선택한 일자
				let ckDay = localStorage.getItem("day");

				let markersArr = [];
				forLine.length=0; //배열 초기화
				
				for(let i=0;i<data.length;i++){
					
					if(data[i].day==ckDay){ //선택한 옵션 일자에 대응되는 장소 정보 출력하기 
						
						//지도 생성
						//printMap(data[i].latitude,data[i].longitude);
						
						//리스트 업---------------------------------------------------------------
						//"카드" 생성 -> 리스트 추가
							const planCard = document.createElement("div");
							planCard.classList.add("plan-card");
							
							
							const txtContainer = document.createElement("div");
							txtContainer.classList.add("text-container");
							
							const title = document.createElement("p");
							title.classList.add("place-title");
							title.innerText = data[i].placeName;
							
							moveMap(title,data[i].latitude,data[i].longitude);
							
							//title.setAttribute("onclick", moveMap(title,data[i].latitude,data[i].longitude));
							title.addEventListener("click",e=>{
								//alert(data[i].placeName);
								moveMap(data[i].placeName,data[i].latitude,data[i].longitude);
							})
							
							
							console.log("제목 : ",title);

							
							const addr = document.createElement("p");
							addr.classList.add("place-addr");
							getAddr(data[i].latitude,data[i].longitude,addr);								
							
							const memo = document.createElement("p");
							memo.classList.add("memo");
							memo.innerText = data[i].memo;
							
							planCard.append(txtContainer);
							txtContainer.append(title);
							txtContainer.append(addr);
							txtContainer.append(memo);
							
							
							//const forOpt = document.createElement("input")
							
							cardContainer.append(planCard);
						
						//지도 관련 -----------------------------------------------------------------
						//1. 마커 표기하기						
						//"배열"에 저장하기
						
						markersArr.push(new place(data[i].placeName,data[i].latitude,data[i].longitude));
						//console.log(ckDay,"방문 장소 : ",markersArr);
						forLine.push(new kakao.maps.LatLng(data[i].latitude,data[i].longitude));
						
						//--------------------------------------------------------------------------

						
					}

				}
				console.log("일자별 방문 장소 : ",markersArr);
				printInfo(markersArr,forLine); //지도, 마커, 선 등 비주얼 정보 출력하기
				
				});
				
				
				//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			}
			
		}
		
		
	})();
     		
		
	
	//지도 이동 관련 -------------------------------------------------------------
		function panTo(lat,lng){
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(lat,lng), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		var moveLatLon = new kakao.maps.LatLng(lat,lng);
		map.panTo(moveLatLon);
		
		//마커 생성 관련
		var markerPosition  = new kakao.maps.LatLng(lat, lng); 
 		// 마커를 생성합니다
 		thisMarker = new kakao.maps.Marker({
 		    position: markerPosition
 		});
		
		thisMarker.setMap(map);
		
	}
	
	
	
	
	
	//장소 정보 저장 객체 생성하기 -----------------------------------------------
	function place (title,lat,lng){
		this.title= title;
		this.latlng = new kakao.maps.LatLng(lat,lng);
	}
	

	
	//좌표 정보 토대로 주소 정보 추출하기 ------------------------------------------
		function getAddr(lat,lng,addr){
		
		    let geocoder = new kakao.maps.services.Geocoder();
		    let coord = new kakao.maps.LatLng(lat, lng);
		    
		    let callback = function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            console.log(result);
		            let addrTemp = result[0]['address']['address_name'];
		            console.log(addrTemp);
		            
		            console.log("//////////",addr);
		            addr.innerText = addrTemp;
		            
		        }
		    };

		    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
		    
		}
	
	
		//지도 생성하기 ------------------------------------------------------------
	 	function printMap(latitude,longitude){
 		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	     mapOption = { 
	        center: new kakao.maps.LatLng(latitude,longitude), // 지도의 중심좌표 (첫 번째 저장한 장소)
	        level: 3 // 지도의 확대 레벨
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		
		}
		
		//========================================================================
	 	//플랜 다운받기
		function downloadPlan(){
			
 			let plannerNo = "${plannerNo}";
			
			location.assign('${path}/planner/plannerDownload/${plannerNo}');

			
			
			
/* 			fetch('${path}/planner/plannerDownload/${plannerNo}',{
				method:'POST',
				headers:{
					'Content-Type':'application/json',
				},
				//body:JSON.stringify({"addrArr":addrArr}),
			})
			.then((res)=>res.json())
			.then((data)=>{
				
				console.log(data);
				
			});  */
			
			
			
			
			
			
			
			
			
			
			//주소가 저장된 배열
			console.log("배열 : ",addrArr);
			
			//--------------------------------------------------------------------
/* 			fetch('${path}/planner/plannerDownload2',{
				method:'POST',
				headers:{
					'Content-Type':'application/json',
				},
				body:JSON.stringify({"addrArr":addrArr}),
			})
			.then((res)=>res.json())
			.then((data)=>{
				
				console.log(data);
				
			});  */
			
			
			
		}

		//주소 정보 가져오기 2) ---------------------------------------------------
		
		function getAddress(lat,lng,arr){
		
		    let geocoder = new kakao.maps.services.Geocoder();
		    let coord = new kakao.maps.LatLng(lat, lng);
		    
		    let callback = function(result, status) {
		        if (status === kakao.maps.services.Status.OK) {
		            console.log(result);
		            let addrTemp = result[0]['address']['address_name'];
		            console.log(addrTemp);
		            
		            //console.log("//////////",addr);
		            arr.push(addrTemp);
		            
		        }
		    };

		    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
		    
		}
		
	 	

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>