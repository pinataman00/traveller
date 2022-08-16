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
<link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@1,800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<%-- <script src="${path}/resources/js/bootstrap.js"></script> --%>
<script src="${path}/resources/js/jquery-3.6.0.min.js"></script>

	<!-- 지도 관련 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=LIBRARY"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services,clusterer,drawing"></script>

</head>

<body>
<style>
	.main-container{
		/* border:1px solid red; */
		/* margin-top : 50px; */
		display:flex;
		overflow:hidden;
		height:100vh;
	}
	.editor-container{
		float:left;
		/* border: 1px solid blue; */
		width: 300px;
		background-color: #E6F0F8;
		padding:10px;
		text-align:center;
	}
	.map-container{
		float:right;
		/* border:1px solid red; */
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
		/* border:1px solid red; */
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
		/* border:1px solid blue; */
		padding: 25px;
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
	.title-container{
		font-weight:300;
	}
	.box_drag{
   
	   background-color:rgba(255, 255, 255, 0.7);
	   width : 248px;
	   height:30px;
	   border-radius : 5px;
	   margin-top: 3px;
	   margin-bottom: 3px;
	   margin-left : -12px;
	   font-size:13px;
	   line-height:30px;
	   text-indent: 8px;
	   text-align: left;
   
   }
</style>

<section>

	<div class="main-container">
		<div class="editor-container">
			<div class="title-container">
				${tempPlanner.plannerTitle}
			</div>
			<div class="planner-container">
					<div class="daysOpt input-group mb-3">
						  <div class="input-group-prepend">
						    <label class="input-group-text" for="inputGroupSelect01">여행일자</label>
						  </div>
						  <select class="custom-select" id="travelDaysOpt">
						  </select>
					</div>
				
					<div id="dropZone">
<!-- 						

						드래그 앤 드롭 카드 출력 예시

						<div id="p1" class="box_drag" draggable="true" >plan 1</div>
				        <div id="p2" class="box_drag" draggable="true" >plan 2</div>
				        <div id="p3" class="box_drag" draggable="true" >plan 3</div>
				        <div id="p4" class="box_drag" draggable="true" >plan 4</div>
				        <div id="p5" class="box_drag" draggable="true" >plan 5</div>
				        <div id="p6" class="box_drag" draggable="true" >plan 6</div>
				        <div id="p7" class="box_drag" draggable="true" >plan 7</div>  -->
					</div>
			 </div>
				<div class="btn-container">
					<button class="btn btn-primary" type="button">작성 완료</button>
					<button class="btn btn-primary" type="button">작성 취소</button>
				</div>
			</div>
		<!-- 지도 영역 -->	
		<div id="map" class="map-container">
			<!-- 이 영역에 지도가 출력될 것임 -->
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
			<button id="searchListBtn" class="btn btn-primary btn-sm" type="button" onclick="showList();">검색하기</button>
			<button tyle="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">나의 도구들</button>
		
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
	<!-- 컨트롤러 관련 div 끝 -->

  
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


	<script>
	//플래너 기본 구성 관련 함수들 ===========================================================================================================================
		
		(()=>{
			
			//● 사용자 입력 값 토대로 기본 검색창 결과 구성하기
			const tempItem = ${tempPlanner.areaCode};
			let searchItem = "";
			
			switch(tempItem){
			
			case 1 : searchItem="서울";break;
			case 2 : searchItem="인천";break;
			case 3 : searchItem="대전";break;
			case 4 : searchItem="대구";break;
			case 5 : searchItem="광주";break;
			case 6 : searchItem="부산";break;
			case 7 : searchItem="울산";break;
			case 8 : searchItem="세종특별자치시";break;
			case 31 : searchItem="경기도";break;
			case 32 : searchItem="강원도";break;
			case 33 : searchItem="충청북도";break;
			case 34 : searchItem="충청남도";break;
			case 35 : searchItem="경상북도";break;
			case 36 : searchItem="경상남도";break;
			case 37 : searchItem="전라북도";break;
			case 38 : searchItem="전라남도";break;
			case 39 : searchItem="제주도";break;
			
			}
			
			document.getElementById("keyword").value= searchItem;
			
		})();
	

		//● 사용자 입력 값 토대로 옵션 구성하기
		const daysOption = document.getElementById("travelDaysOpt");
		
		const inputDays = ${tempPlanner.travelDays};
		
		for(let i=1;i<=inputDays;i++){
			const opt = document.createElement("option");
			opt.value=i;
			opt.innerText=i;
			daysOption.append(opt);
		}
		
	
		//● "사용자 편의 콘테이너" 기능 관련 함수들
		const showList = (()=>{ //"검색하기" 버튼 클릭 時, "검색 리스트"가 보이거나, 보이지 않도록 구현함
	
		const searchList = document.getElementById("menu_wrap");
	
	 	let cnt = 1;
		return()=>{
			
			if(++cnt%2!=0){
				searchList.style.display="";
			} else {
				searchList.style.display="none";
			}
			
		}
		
		})();
		
		//기타 오류 대처 ----------------------------------------------------------------------------------------
		window.onbeforeunload = (e)=>{
			
			//TODO0815 화면이 전환될 경우에는...
			localStorage.clear(); //로컬 스토리지에 저장된 내용 제거하기
		
		}
	
	//플래너 리스트 관련 함수들 ==============================================================================================================================
	//옵션 변경 관련 기능

	/*
		○ 저장 내용 불러오기
		1. 카드, 선 불러오기
		2. 저장 내용을 편집할 경우에는, 해당 선을 토대로 실시간으로 이어주는 함수 새로 만들어야 함
		
		○ (해당 옵션에 저장된 데이터가 없다면) 새로운 편집 페이지 열어주기
		1. 카드, 선 리셋하기
	
	*/
	
	
	//1. 불러오기 관련 로직 -------------------------------------------------------------------------------------------
	
	

	let myMarkers = []; //편집 중에 클라이언트가 리스트에 추가할 마커 관련 배열 (전역에서 사용하기 위해서 여기에 선언함...)
	
	//● 공통함수 : printMyLog() => 옵션 변경으로 선택한 일자에 저장된 이정이 존재한다면, 해당 정보 불러오기!
	const thisDay = document.querySelector("#travelDaysOpt>option").value;
	let markersArr = []; //* (저장된 내용을 기반으로) 앞으로 생성될 마커들을 저장할 배열
	
	function printMyLog(myLog, logArr){ //공통 function : 저장 이력 출력하기
	//매개변수?
	//myLog : localStorage에 JS객체로서 일자별 일정이 저장된 데이터의 배열
	//logArr : localStorage로부터 추출한 좌표 정보 (printMyLog함수에서 가공해서 저장할 것임)
		
		for(let i=0;i<myLog.length;i++){ //card의 개수 만큼 반복
			
			//1. 마커 출력하기
			//마커 생성부터
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(36, 37); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: new kakao.maps.LatLng(myLog[i].latitude, myLog[i].longitude), //사용자의 저장 기록을 토대로 마커 위치를 설정함
		        title : myLog[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다 (TODO0815 표시 안 됨)
		        image : markerImage // 마커 이미지 
		    });
		    

		    
		    infoOverlay(marker); //마커 클릭 시, 커스텀 오버레이 출력할 것임
		    
		    //마커 간 선으로 연결하기 위해, 각 배열 (logArr, markersArr에 저장하기)
		    //logArr : 
		    //markersArr : 
			logArr.push(new kakao.maps.LatLng(myLog[i].latitude, myLog[i].longitude));
		    markersArr.push(marker); //이전에 저장됐던 마커들을 저장함. 이를 기반으로 쭉쭉 새로운 마커들을 추가해 나갈 수도 있음!
	
		}
	
		
	
		//마커 간 선 연결하기
	    // 지도에 표시할 선을 생성합니다
	    var polyline = new kakao.maps.Polyline({
	        path: logArr, //logArr을 기준으로 출력할 것임 (logArr : 이전에 저장한 마커의 배열 !=markersArr : 이전에 저장한 마커+앞으로 편집을 통해 추가할 마커들이 저장될 배열)
	        strokeWeight: 5, 
	        strokeColor: '#e61919',
	        strokeOpacity: 0.7, 
	        strokeStyle: 'solid', 
	        endArrow:'true' //화살표 표시할 것임
	    });

	    // 지도에 선을 표시합니다 
	    polyline.setMap(map);
	    
	    daysOption.addEventListener("change",e=>{
	    	    	
	    	polyline.setMap(null);

	    });
	    

	} //printMyLog함수 종료
	
	
	//여행의 첫 번째 일자에 저장된 정보 불러오기
	const dayOnePlan = JSON.parse(localStorage.getItem(1)); //JS객체를 JSON문자열로 변환 후 localStorage에 저장했었으므로, 저장 데이터를 불러올 때는 다시 JS객체로 parsing함
	var imageSrc = 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-256.png'; //마커 이미지
	var linePath = []; //"선"을 이어주기 위해 배열을 만듦		

	if(dayOnePlan!=null&&thisDay==1){ //만약, 1일자 관련 여행 일정 데이터가 존재한다면!
		
		console.log("1일차 데이터 있어", dayOnePlan);
		
		//1. 리스트 > 장소 카드 관련
		//> 데이터가 있다면, 새로고침 시에도 해당 장소 데이터가 출력되도록 로직 구현하기
		
		document.getElementById("dropZone").innerHTML=""; //계속 appendChild하면 카드가 무한히 누적되므로, 먼저 해당 영역을 비워주기
		
		for(let i=0;i<dayOnePlan.length;i++){				
		
			const div = document.createElement("div"); //태그 만들기
			
			div.setAttribute("day", 1);
			div.setAttribute("id", dayOnePlan[i].id);
			div.setAttribute("placeName", dayOnePlan[i].placeName);
			div.setAttribute("latitude", dayOnePlan[i].latitude);
			div.setAttribute("longitude", dayOnePlan[i].longitude);
			div.setAttribute("memo", dayOnePlan[i].memo);
			
			div.innerText = dayOnePlan[i].placeName;
			div.classList.add("box_drag");
			div.setAttribute("draggable",true);
			document.getElementById("dropZone").appendChild(div); 
												
			deletePlace(div);
			moveMap(div);
			 
		}
		
		printMyLog(dayOnePlan,linePath);

	}
	
	
	
	

	
	
	//2. 클라이언트가 선택한 일자 정보 가져오기 : select > option
	let preCho = ""; //선택 前 일자
	let nowCho = ""; //선택한 일자 (열람||편집 희망 일자)
	
	//const daysOption = document.getElementById("travelDaysOpt");
	
	daysOption.addEventListener("focus",e=>{
		daysOption.blur();
		preCho = daysOption.value; //옵션 영역 선택 당시의 일자 값
		
	});
	
	daysOption.addEventListener("change",e=>{ //옵션 전환 시
		
		//선택한 옵션 일자에 저장된 일정이 존재하는가?
		//존재 : 해당 일자에 저장된 일정 정보 출력
		//부재 : 아무것도 출력하지 않는다
		
		//선택 前 선택 직전 option에서 편집한 일자의 마커 및 선 지우기 ------------------------------------------------------------------------
		//console.log("저장한 옵션 확인하기! //////////////", myMarkers); //플랜에 저장된 일체 장소 리스트가 출력됨
/* 		console.log("선택 前 옵션 확인 : ",preCho);
		const previousPlan = JSON.parse(localStorage.getItem(preCho));
		console.log("직전 옵션에서 저장한 장소들 확인하기 : ",previousPlan); //옵션 전환 직후는 localStorage에 저장이 안 되는 걸까? 1회는 확인이 잘 안 되네
		
		myMarkers.forEach(e=>{
			
			console.log("마커 구성 ",e);
			
		}); */
		
		
		
		
	
		//선택한 일자에 해당하는 일정 편집 및 저장 관련 로직 ▼ ---------------------------------------------------------------------------------
		nowCho = daysOption.value;

		const cards = document.querySelectorAll("div#dropZone>div");
		console.log("현재 dropZone에 추가된 장소 카드 : (현재 선택 일자에 해당하는 저장 데이터가 없는 경우에는, 존재하지 않을 수도 있음!)", cards);
		
		//-> 따라서, card의 존재 여부에 따라서 *데이터savedPlan 불러오기, 로직을 구현할 수도 있음
		const savedPlan = JSON.parse(localStorage.getItem(nowCho)); //현재 선택한 일자로 저장된 데이터가 있을까?
		let lineArr = []; //저장된 데이터 기준으로 경로를 그려주기 위해서, 마커가 저장될 배열을 만듦
		
		if(savedPlan!=null&&savedPlan.length!=0){ //저장된 데이터가 존재한다면!
			console.log("배열로 받아온, ",nowCho,"의 일정 : ",savedPlan);
			
			//1. 작성 기록이 존재한다면, 리스트에 출력해주기
			//먼저, 리스트 깨끗이 비워주기
			document.getElementById("dropZone").innerHTML="";
				
			for(let i=0;i<savedPlan.length;i++){
				
				const div = document.createElement("div");
				
				//div에 플래너 관련 *속성 생성하고 저장하기
				if(nowCho!=null){
					div.setAttribute("day",nowCho);					
				} else {
					div.setAttribute("day",1);
				}
				
				div.setAttribute("id", savedPlan[i].id);
				div.setAttribute("placeName", savedPlan[i].placeName);
				div.setAttribute("latitude", savedPlan[i].latitude);
				div.setAttribute("longitude", savedPlan[i].longitude);
				div.setAttribute("memo", savedPlan[i].memo);
				
				div.innerText = savedPlan[i].placeName;
				div.classList.add("box_drag");
				div.setAttribute("draggable",true);
				document.getElementById("dropZone").appendChild(div); 
				
				deletePlace(div); //TODO0815) 더블클릭 시, 리스트에서 장소 삭제됨
				moveMap(div);
	
			}
			
			printMyLog(savedPlan,lineArr); //리스트에 로그 출력하기
			clearDragEvent();
			addDragEvent();
			
		} else { //선택한 일자에 해당하는 여행 일정이 부재하는 경우
			document.getElementById("dropZone").innerHTML=""; //편집을 새로 시작하는 것이므로, 영역 비워주기
		}
		
		
		
		//플래너 내용 작성 -> 장소 방문 순서 편집 관련 로직
		let arr = []; //card에 저장된 정보 일체 (아이디, 장소명, 위도, 경도 등을 *객체화함) arr배열에 저장하기
		
		function Places(day,id,placeName,latitude,longitude,memo){ //생성자 함수 : 장소 정보 저장 객체
			
			this.day = day;
			this.id = id;
			this.placeName = placeName;
			this.latitude = latitude;
			this.longitude = longitude;
			this.memo = memo;			
			
		}
		
		for(let i=0;i<cards.length;i++){	
			
			//생성자 함수로 "장소"객체 생성 후, 배열arr에 저장하기
				arr.push(new Places(
						
									//cards[i].getAttribute("day"),
									preCho, //일자 정보 : 선택 일자로 저장하기
									cards[i].getAttribute("id"),
									cards[i].getAttribute("placeName"),
						            cards[i].getAttribute("latitude"),
						            cards[i].getAttribute("longitude"),
						            cards[i].getAttribute("memo")));
			
		}
		
		console.log("카드 리스트 확인하기 : ",arr);
		
		//다음 option으로 전환되기 前 마무리 작업
		localStorage.setItem(preCho,JSON.stringify(arr)); //일자 별로 해당 일정을 확인할 수 있도록, arr객체를 JSON문자열로 저장함
		console.log("현재 편집한 일정이 잘 저장됐는지 확인하기 : ", JSON.parse(localStorage.getItem(preCho)));
		

		
	});
	
	//다음 option으로 전환되기 전, 당해 option에서 저장했던 마커 삭제 및 myMarkers[] 리셋
	//-> myMarkers[] 리셋해야, 옵션 무관하게 해당 배열을 기준으로 선이 그어지는 현상을 막을 수 있음!!!
	daysOption.addEventListener("change",e=>{
 		
 		for(let i=0;i<myMarkers.length;i++){			
 			myMarkers[i].setMap(null); //마커 전체 삭제 			
 		}
		myMarkers = [];
		console.log("삭제 잘 됐는가? ", myMarkers);

	
	});
	
	//플래너 지도 관련 함수들 ==================================================================================================================================
	//마커 클릭 시 출력될 커스텀 오버레이
	var customContent = '<div class="wrap">' + 
            '    	 <div class="info">' + 
            '        <div class="title">' + 
            '            여기 괜찮아요?' + 
            '            <div class="close" id="exitBtn" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="desc">' + 
            '                <div class="ellipsis" style="margin-top:30px;margin-bottom:8px;"><p style="font-size:18px;">장소를 플랜에 추가할까요?</p></div>' +
            '                <input type="text" id="memo" style="width:225px; "placeholder="메모를 작성해주세요">'+ //☆ 해당 장소에 대한 정보를 이미 사용자가 작성했다면, value에 값을 넣어도 되지 않을까
            '                <div style="margin-top:10px;margin-left:125px;"><button id="addBtn" onclick="addList();" class="addToList" style="font-size:12px;margin-left:20px;width:80px;">추가하기</button></div>' + 
            '        	 </div>' + 
            '    </div>' +    
            '</div>'+
            '<div style="display:none", id="hiddenLat"></div>' //마커의 위도
            +'<div style="display:none", id="hiddenLng"></div>' //마커의 경도
            +'<div style="display:none", id="hiddenTitle"></div>' //마커의 장소명
            +'<div style="display:none", id="mfgDate"></div>'; //0616 마커 관련 전반적인 정보 확인
	
	
            
     //커스텀 오버레이 > "추가하기"버튼 클릭 시, 클라이언트의 장소 리스트에 해당 장소가 카드 형식으로 추가될 것임
     function addList(){ //특정 장소를 사용자의 플랜 리스트에 추가하는 인터페이스
    	 
		clearDragEvent();
		       	
		const lat = document.getElementById("hiddenLat").innerText;
		const lng = document.getElementById("hiddenLng").innerText;
	 	const placeName = document.getElementById("hiddenTitle").innerText;
	 	const memo = document.getElementById("memo").value;
	 	
		console.log("위도 : ",lat,"경도 : ",lng,"타이틀 : ",placeName,"메모 : ",memo);
	
		//장소 카드 생성해, 플랜 리스트에 추가하기 -----------------------------------
		const dropZone = document.getElementById("dropZone");
		
		const addPlan = document.createElement("div"); //div생성하기
		addPlan.classList.add("box_drag");
		addPlan.setAttribute("draggable",true);
		addPlan.innerText = placeName;
	
		//index를 식별하기 위해, 현재 dropZone에 자식 태그들이 몇 개 있는지 확인하기	
		
		const cards = document.querySelectorAll("div#dropZone div");
		console.log("현재 카드 개수 : ",cards.length);
		let tempNo = cards.length+1;
		addPlan.id="p"+tempNo;
		dropZone.insertAdjacentElement("beforeend",addPlan);
		addDragEvent();
		
		console.log(addPlan);
				
		//-------------------------------------------------------------------
	
		//장소 카드의 "속성"을 새로 생성해, 해당 장소의 정보를 저장하기--------------------
		
		addPlan.setAttribute("id",addPlan.id);
		addPlan.setAttribute("placeName",placeName);
		addPlan.setAttribute("latitude",lat);
		addPlan.setAttribute("longitude",lng);
		addPlan.setAttribute("memo",memo);

		
		deletePlace(addPlan); //더블클릭 시, 편집 시점에 생성된 마커와 카드가 삭제됨
		//deletePlaceMarker(addPlan);
		moveMap(addPlan);
	} 
            
     
     
     
     function deletePlace(e){ //리스트에서 특정 장소 삭제 시 구현될 이벤트
 		
     	let dropZone = document.getElementById("dropZone");

     	e.addEventListener("dblclick",e=>{ //삭제 대상 카드 클릭 시 (카드 및 마커가 삭제됨)	
     	
     		alert("삭제!");

     		let placeLat = e.target.getAttribute("latitude"); //카드의 위도
     		let placeLng = e.target.getAttribute("longitude"); //카드의 경도
     		
     		
     		//마커 삭제 1) (localStorage에 저장되지 않은 내용, 사람 모양 마커)작성 中, 내가 생성한 마커 지우기
     		for(let i=0;i<myMarkers.length;i++){
     			
     			let mkLat = myMarkers[i].getPosition().getLat();
     			let mkLng = myMarkers[i].getPosition().getLng();
     			console.log(mkLat, mkLng);
     			console.log(placeLat, placeLng);
     			
 				if(mkLat==placeLat&&mkLng==placeLng){
 					myMarkers[i].setMap(null);
 					break;
 				}    			
     		}
     		
     		//마커 삭제 2) printMyLog()메소드로부터 생성된 마커(=localStorage에 저장된 마커, 빨간 마커) 지우기
     		for(let i=0;i<markersArr.length;i++){
     			
     			//myMarkers[i].setMap(null); //마커 전체 삭제
     			let mkLat2 = markersArr[i].getPosition().getLat();
     			let mkLng2 = markersArr[i].getPosition().getLng();
     			console.log(mkLat2, mkLng2);
     			
 				if(mkLat2==placeLat&&mkLng2==placeLng){
 					markersArr[i].setMap(null);
 					break;
 					
 				}    			
     		}
     		
     		//TODO 0816 마커에 대응되는 선 또한 삭제해야 함 (0815 사람모양 마커-파란 선은 수정 완료)
     		//지도에 표시된 폴리 라인 일체를 삭제한 다음에, 남은 마커들을 기준으로 선을 다시 그리면 됨
			
     		
     		dropZone.removeChild(e.target); //방문 리스트에서 선택한 장소 카드 삭제

     	});
  	
     };
     
     function moveMap(e){ //카드에 마우스 오버 시, 지도가 이동하도록 구현
    	    
     	//let dropZones = document.querySelectorAll("div#dropZone>div");
     	var thisMarker = "";
 		
 	     	e.addEventListener("mouseover",e=>{
 	 		
 	    		const lat = e.target.getAttribute("latitude");
 	    		const lng = e.target.getAttribute("longitude");
 	    		
 	    		//0618) 마커가 생성됨 (선만으로는 확인하기 어려우니까)
 	    		var markerPosition  = new kakao.maps.LatLng(lat, lng); 
 	     		// 마커를 생성합니다
 	     		thisMarker = new kakao.maps.Marker({
 	     		    position: markerPosition
 	     		});
      		
      			panTo(lat,lng); //지도 이동 메소드

 	     		thisMarker.setMap(map); //마커 표시하는 메소드
 		
 	    	});
 	     	
 	     	//마우스 오버 시, 해당 일자에 마커가 생성됨. 마우스 아웃 시, 마커는 사라짐!
 	     	e.addEventListener("mouseout",e=>{
 	     		thisMarker.setMap(null);
 	     	})
 	     	
 	     	//카드를 더블클릭하면 해당 장소는 삭제되므로, 이때 마커도 삭제됨
 	     	e.addEventListener("dblclick",e=>{
 	     		thisMarker.setMap(null);
 	     	})

     } 
     
     
 	function panTo(lat,lng) { //지도 이동 관련 카카오 제공 기본 함수
 		    // 이동할 위도 경도 위치를 생성합니다 
 		    var moveLatLon = new kakao.maps.LatLng(lat, lng);
 		    
 		    // 지도 중심을 부드럽게 이동시킵니다
 		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
 		    map.panTo(moveLatLon);            
 		}   
   
            

	
	
		//● "지도" 기능 관련 함수들
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
		// 지도를 클릭한 위치에 표출할 마커입니다 //TODO 0814) 이 부분은 보류... 오버레이 닫힘 버튼을 누를 때도 마커가 찍힘...
 		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		//marker.setMap(map); //...그래서 여기를 주석처리해둠. 전체를 또 주석처리하면 지도 이동이 안 되기 때문임
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    //alert("위도 "+latlng.getLat()+" "+"경도 "+latlng.getLng());
		    
		});
		
		
		//4. 마커 및 검색 기능 ----------------------------------------------------------------------------------------
		

		// 마커를 담을 배열입니다
		var markers = [];
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 키워드로 장소를 검색합니다
		searchPlaces();
		
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
		
		    var keyword = document.getElementById('keyword').value;
		
		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);
		
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
		
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		
		    } else if (status === kakao.maps.services.Status.ERROR) {
		
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
		
		    }
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
		
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);
		
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);
		
		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        
		        
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });
		
		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
		            
		            
		            //● "마커" 관련 이벤트 =====================================================

		            	
		            //마커 관련 이벤트 > 1. 마커 클릭 시, 커스텀 오버레이를 출력할 것임
				  	var overlay = new kakao.maps.CustomOverlay({ //커스텀 오버레이 등록
					    content: customContent,
					    //content: savedInfo,
					    map: map,
					    position: marker.getPosition()       
					});
		          	
		          		overlay.setMap(null); //디폴트 : 출력 안 함
		          		
		          		
		          		kakao.maps.event.addListener(marker, 'click', function() { //마커 클릭 시 발생할 이벤트
		          			
		          			
		          			//커스텀 오버레이 관련 함수 시작 ------------------------------------------------------
		          			//alert('안녕? 나는 마커야!');
		          			overlay.setMap(map); //커스텀 오버레이를 출력함
		          			
		          			//개별 마크에 내포된 정보들을 오버레이에 저장 -> 출력하기
		          			//1-1. 정보 추출 > 마커에 포함된 위도, 경도 정보
		          			let lat = marker.getPosition().getLat(); //위도
							let lng = marker.getPosition().getLng(); //경도
		          			//1-2. 오버레이에 저장하기
							document.getElementById("hiddenLat").innerText=lat;
							document.getElementById("hiddenLng").innerText=lng;
							
							document.getElementById("hiddenTitle").innerText=title;	
							
							//TODO 0814) 저장해둔 메모가 있다면, 해당 메모를 input창의 value에 출력하기
							//아직 localStorage를 미구현해 주석처리함...
							//저장해둔 "메모"가 있다면, 해당 메모를 input창의 value에 출력해주기
							/*
							const savedData = JSON.parse(localStorage.getItem(document.getElementById("dayTitle").innerText));
							
							
							if(savedData!=null){
									console.log(savedData, title);
					
									const memo = document.getElementById("memo");
									
									
					 				savedData.forEach(e=>{					
										if(title===e.title&&e.memo!=''){
											memo.value = e.memo;
										}					
									});
							}
							*/
							
							//추가하기 버튼 클릭 時, 해당 마커의 이미지 변경
							const isAdded = document.getElementById("addBtn");
							isAdded.addEventListener("click",e=>{
								
								addMarkerFunc(lat,lng,title);
								
							});
							
							
							//● 커스텀 오버레이 > "닫기"
							//1. X 버튼 클릭 時
							const exitBtn = document.getElementById("exitBtn");
							exitBtn.addEventListener("click", e=>{
								overlay.setMap(null);
							})
							//2. "등록" 버튼 클릭 時
							//커스텀 오버레이창 *닫기
							const addBtnClose = document.getElementById("addBtn");
							addBtnClose.addEventListener("click",e=>{
								overlay.setMap(null);
							});
							//커스텀 오버레이 관련 함수 끝 --------------------------------------------------------
							
				
							
		          		});	//마커 클릭 이벤트 끝

		            	
		            //=======================================================================	
		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };
		
		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
		
		        fragment.appendChild(itemEl);
		    }
		
		    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
		
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
		

		 //"추가하기" 버튼 클릭을 눌렀을 때
		 //기능 리스트
		 /*
		 
		 	1. 마커 모양 차별화 : "사람"모양의 마커
		 	2. 커스텀 오버레이 차별화 : 해당 마커에 대한 간단한 설명과 더불어, 리스트로부터 마커를 삭제할 수 있음 (구현 예정)
		    3. 실시간 선 그리기 : 마커가 추가되는 대로 자동 선 그리기 (* setInterval())
		 
		 */

		 
		 
		 const addMarkerFunc = (lat,lng,placeName)=>{
			 
			 //1. 마커 이미지 변경 
			 //1-1. (아직은 저장되기 이전이므로, 사람 모양 마커)
			 var tempMarker = "https://cdn0.iconfinder.com/data/icons/zondicons/20/travel-walk-256.png";
			 //1-2. 마커 크기 변경
			 var tempMarkerSize = new kakao.maps.Size(36, 37); 
			    
			    // 마커 이미지를 생성합니다    
			    var tempMarkerImg = new kakao.maps.MarkerImage(tempMarker, tempMarkerSize); 
			    
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(lat,lng),
			        title : placeName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : tempMarkerImg // 마커 이미지 
			    });
					
			    
				infoOverlay(marker); //커스텀 오버레이 출력
				
				
				//myMarkers를 카카오 좌표 객체化해서 보내야 작업이 간단하겠다...
				myMarkers.push(marker); //배열에 저장하기!
				
				
				//장소 삭제 관련, 삭제 내용 반영해 myMarkers 재구성하기 ==============================================
				let cards = document.querySelectorAll("div#dropZone>div");

     			[].forEach.call(cards,function(card){
     				card.addEventListener("dblclick",click,false);
     			});
     			
     			function click(e){ //deletePlace()와 같이, 리스트 카드 클릭 시 파란 선과 사람 모양 마커 삭제하기
     				
     				let lat = e.target.getAttribute('latitude');
     				let lng = e.target.getAttribute('longitude');
     				let target = new kakao.maps.LatLng(lat,lng);
				
     				//----------------------------------------------------------------------------------------
     				//myMarkers에서도 해당 좌표 값은 삭제해야 함

					console.log(target.Ma); //latitude
					console.log(target.La); //longitude
					
      				let tempArr = myMarkers.filter(function(v,i,ori){
     					return (v.getPosition().getLat()!=target.Ma&&v.getPosition().getLng()!=target.La);
     				});
     				
					console.log("tempArr의 유형 /////////////////////",tempArr);
     				myMarkers = tempArr.slice();
     				
     			}
     			
     			//장소 방문 순서 변경 관련, 수정 내용 반영해 myMarkers 재구성하기 ==========================================
      			[].forEach.call(cards,function(card){
     				card.addEventListener("dragend",drag,false);
     			});
				
 				function drag(e){ //드래그가 완료된 시점에, 카드에 저장된 내용을 바탕으로 myMarkers재구성하기!
 				
 					
 					let cards = document.querySelectorAll("div#dropZone>div");
 					let tempArr = [];	
 				
 					cards.forEach(v=>{ //순서 변경으로 재배열된 카드 토대로 path배열 재구성하기
 						
 						let lat = v.getAttribute('latitude');
 						let lng = v.getAttribute('longitude');
 						let name = v.getAttribute('placename');
 						
 					    var marker = new kakao.maps.Marker({
 					        map: map,
 					        position: new kakao.maps.LatLng(lat,lng),
 					        title : name, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
 					        image : tempMarkerImg // 마커 이미지 
 					    });
 						
 						tempArr.push(marker);
 					
 					});
 				
 					console.log("////////////////////////",tempArr);
 					myMarkers = tempArr.slice();
 				} 
		
				drawLines(myMarkers); //마커 간 선 그리기

			}  
		 
		 
		 	//리스트에 추가된 장소 대상 커스텀 오버레이 (공통 function)
		 	function infoOverlay(marker){
		 		
			 	//사람 모양의 마커 위로 출력될 커스텀 오버레이 만들기
				var content = '<div class="wrap">' + 
				            '    <div class="info">' + 
				            '        <div class="title">' + 
				            '            리스트에 추가된 장소' + 
				            '        </div>' + 
				            '        <div class="body">' + 
				    		'            <div style="position:relative;margin:10px;padding:10px;display:block">' + 
				    		'                <div id="listedName" style="font-size:15px;margin-right:30px;">장소명</div>' +
				    		'                <div id="listedMemo" style="font-size:15px;margin-right:30px;"><input style="margin-top:10px;margin-bottom:10px;" placeholder="메모"></div>' + 
				    		'                <input id="listedDay" style="font-size:15px;margin-right:30px;" placeholder="방문일자"></div>' +
/* 				   			'                <div style="float:right;margin-right:20px;"><button onclick="deleteThisMarker();">삭제하기</button></div>' +  */ 
				            '            </div>' + 
				            '        </div>' + 
				            '    </div>' +    
				            '</div>';
			    
			    
		        var overlay = new kakao.maps.CustomOverlay({
		            content: content,
		            map: map,
		            position: marker.getPosition()       
		        });
		        
		        overlay.setMap(null); //디폴트 : 출력 안 함

		        // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
		        kakao.maps.event.addListener(marker, 'click', function() {
		            
		        	showOverlay(); //오버레이 출력 관련 설정
		        });

			    
				const showOverlay = (()=>{ //마커 클릭 시 오버레이 출력, 재클릭 시 숨김
					
				 	let cnt = 1;
				
					return()=>{						
						if(++cnt%2!=0){
							overlay.setMap(null);
						} else {
							overlay.setMap(map); //오버레이 표시하기
							console.log(document.getElementById("listedName"));
							
							//마커에 저장된 정보 확인하기
							let lat = marker.getPosition().getLat();
							let lng = marker.getPosition().getLng();
							let title = marker.getTitle();
							
							document.getElementById("listedName").innerText = title;
						}						
					}
					
					})();
		 		
		 		
		 	}
		 

		    function deleteThisMarker(marker){
		    	alert(marker.getTitle());
		    }
		
			//실시간으로 선 그리기 ------------------------------------------------------------------------------
			
			

			
			function drawLines(myMarkers){

				
				var path =  []; 
				
				const savedPlan = JSON.parse(localStorage.getItem(nowCho));
				console.log("저장된 내용이 있습니까? ",savedPlan);
				
				let savedLat, savedLng = "";
				
 				if(savedPlan!=null&&savedPlan.length!=0){ //가장 최근에 저장된 장소 정보(마지막 index)
					
 					savedLat = savedPlan[savedPlan.length-1].latitude;
 					savedLng = savedPlan[savedPlan.length-1].longitude;
 					path.push(new kakao.maps.LatLng(savedLat,savedLng));
				}
 				
				console.log("lat : ", savedLat);				
				console.log("lat : ", savedLng);				

				
 				var clickLine = new kakao.maps.Polyline({
				    map: map,
				    strokeWeight: 3, // 선의 두께입니다
				    //strokeColor: '#db4040', // 선의 색깔입니다
				    strokeColor: 'blue', // 확정되기 전에는 파란색
				    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'solid' // 선의 스타일입니다
				});

						
						myMarkers.forEach(e=>{
							//클라이언트가 추가하는 마커 정보들 족족 path에 저장하기
							path.push(new kakao.maps.LatLng(e.getPosition().getLat(),e.getPosition().getLng()));
							
						});
				
				//deletePlace() 관련, path에서 다시 클라이언트가 클릭했던 장소에 해당되는 마커는 배열에서 삭제해야 함
				
 				setInterval(function() {
				    clickLine.setPath(path);
				}, 100);
 				
 				//파란 path 삭제 관련 ---------------------------------------------------------------------
 				//삭제돼야 하는 경우 : 옵션 전환 시, deletePlace()실행 시
 				//옵션이 전환될 때 path 삭제하기
 				daysOption.addEventListener("change",e=>{

 					clickLine.setMap(null); 				
 				})
 				
				//---------------------------------------------------------------------------------------
				
				
				let cards = document.querySelectorAll("div#dropZone>div");

     			[].forEach.call(cards,function(card){
     				card.addEventListener("dblclick",click,false);
     			});
     			
     			function click(e){ //deletePlace()와 같이, 리스트 카드 클릭 시 파란 선과 사람 모양 마커 삭제하기
     				
     				let lat = e.target.getAttribute('latitude');
     				let lng = e.target.getAttribute('longitude');
     				console.log("위도 경도 확인 : ",lat,lng);
     				let target = new kakao.maps.LatLng(lat,lng);
     				console.log("객체 확인 : ",target);
     				//path[] 전체 삭제 후, 대상 좌표만 제거한 다음 다시
     				
     				
     				console.log("원본 배열 : ", path);
     				let tempPathArr = path.filter(function(v,i,ori){

     					return (v.La != target.La&&v.Ma!=target.Ma); //삭제 대상을 제외한 새로운 배열을 반환함
     				}); 
     				
     				//console.log("필터 적용되나? ", tempArr);
     				//원본 파란 선은 모두 삭제하고, temp기준으로 polyline다시 그리기   				
     				path = tempPathArr.slice();
     				//console.log("복사 잘 됐나? ",path);
		
     			}
     			
     			
     			
 				//----------------------------------------------------------------------------------------
				//리스팅된 방문 장소의 순서가 변경될 때도, '선' 표기가 변경되어야만 함
 				//카드가 drag되는 상황을 감지할 수 있어야 함
				
 				
 				
      			[].forEach.call(cards,function(card){
     				card.addEventListener("dragend",drag,false);
     			});
				
 				function drag(e){ //드래그가 완료된 시점에, 카드에 저장된 내용을 바탕으로 myMarkers재구성하기!
 				
 					
 					let cards = document.querySelectorAll("div#dropZone>div");
 					let tempArr = [];	
 				
 					cards.forEach(v=>{ //순서 변경으로 재배열된 카드 토대로 path배열 재구성하기
 						
 						let lat = v.getAttribute('latitude');
 						let lng = v.getAttribute('longitude');
 						tempArr.push(new kakao.maps.LatLng(lat,lng));
 					
 					});
 				
 					console.log("////////////////////////",tempArr);
 					path = tempArr.slice();
 				} 

			
			}
		
			//폴리라인 제거 관련
			function deleteBlueLine(polyLine){
				polyLine.setMap(null);
			}
		

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
		
		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';
		
		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           
		
		    el.innerHTML = itemStr;
		    el.className = 'item';
		
		    return el;
		}
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });
		
		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		
		    return marker;
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 
		
		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }
		
		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;
		
		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }
		
		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}
		
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
		
		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
		

			 
		 
		 
		 
		 
/* 		//0. 테스트 : 지도 상 마커 생성과 polyline 그리기 -----------------------------------------------------------------------
		//기능 내용 : 지도 위 특정 지점 클릭 시, 마커가 생성되고 마커 간에 선이 그어진다. 
		var path =  []; 
		var clickLine = new kakao.maps.Polyline({
		    map: map,
		    strokeWeight: 3, // 선의 두께입니다
		    strokeColor: '#db4040', // 선의 색깔입니다
		    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid' // 선의 스타일입니다
		});
		
		// 지도에 클릭 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    // 마우스로 클릭한 위치입니다
		    var clickPosition = mouseEvent.latLng;
		    path.push(clickPosition);
		});
		
		setInterval(function() {
		    clickLine.setPath(path);
		}, 1000); */
		
		//-------------------------------------------------------------------------------------------------------------------
		//커스텀 오버레이 만들기

		
		
		
		
		
		
	</script>

			                <script>
	            		//드래그 앤 드롭 이벤트 관련
		                
		                		function addDragEvent(){
		                			
		                			document.querySelector('#dropZone').addEventListener('dragover', dragover_handler);
		                			 
									document.querySelector('#dropZone').addEventListener('drop', drop_handler);
									
									const elements = document.querySelectorAll(".box_drag");
			            	        elements.forEach(e => e.addEventListener("dragstart", dragstart_handler));
		                		}
		                		
		                		
		                		
								function clearDragEvent(){
		                			
		                			document.querySelector('#dropZone').removeEventListener('dragover', dragover_handler);
									document.querySelector('#dropZone').removeEventListener('drop', drop_handler);
									const elements = document.querySelectorAll(".box_drag");
			            	        elements.forEach(e => e.removeEventListener("dragstart", dragstart_handler));
		                		}
		                		
		                		
		                		window.addEventListener('DOMContentLoaded', () => {
		                			addDragEvent();
			            	    });
		                		
		                		
		            			/* 드래그 앤 드롭 관련 */
		            		    
		            	        function dragstart_handler(ev) {
		            	          // 데이터 전달 객체에 대상 요소의 id를 추가합니다.
		            	          ev.dataTransfer.setData("text/plain", ev.target.id);
		            	          ev.dataTransfer.idx = 1111111111;
		            	          //console.dir('///////////////dragstart_handler////////////////');
			            	         console.dir(ev);
		            	        }

		
		            	        function dragover_handler(ev) {
		            	         ev.preventDefault();
		            	         ev.dataTransfer.dropEffect = "move";
		            	        }
		
		            	        function drop_handler(ev) {
		            	         ev.preventDefault();
		            	         console.dir(ev);
		            	         const data = ev.dataTransfer.getData("text/plain");
		            	         const divItems = document.querySelectorAll("div#dropZone>div");
		            	         
		            	         //태그 상 마지막 노드에 카드를 추가하고자 할 때, "insertBefore"함수 구현하기
		            	         if(ev.target.nextElementSibling!=null){
		            	         	dropZone.insertBefore(document.getElementById(data),ev.target);
		            	         } else dropZone.insertBefore(document.getElementById(data), null);
		            	         
		            	        }
	            	     	            		
	            		</script>
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp"%>