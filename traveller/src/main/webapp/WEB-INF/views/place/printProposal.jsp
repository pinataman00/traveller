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
		margin-top: 130px;
		
	}
	.container div{
		/* border: 1px solid red; */
	}
	.btn-container{
		 margin-top: 10px;
		 margin-bottom: 30px;
		 display:flex;
		 float:right;"
	}
	#map{
		height:300px;
		border-radius: 10px;
	}
	input.white-container{
		background-color: white;
	}
	.for-space{
		margin-top: -10px;
	}
	img.proposalImg{
	    margin-top: 20px;
	    margin-bottom: 20px;
	    width: 770px;
	    height: 500px;
	    max-width: 800px;
	    max-height: 500px;
	    border-radius: 10px;
	    object-fit: cover;
	    border: 0.5px solid #EEEEEE;
	}

</style>
<section>
	<div class="container" style="width:800px;">
		<input id="pId" type="hidden" value="${proposalId}">
		


		<div class="content-container">	
		
			<h5 style="font-weight:bolder;">장소 제안서</h5>
			<hr style="margin-bottom:30px;">
			<div class="detail-info-container">


				<div class="input-group mb-3 for-space">
				  <div class="input-group-prepend">
				    <span class="input-group-text" id="inputGroup-sizing-default">제목</span>
				  </div>
				  <input id="title" type="text" class="form-control white-container" aria-label="Default" aria-describedby="inputGroup-sizing-default">
				</div>
				
				<!-- 이미지 등록하기 -->
				<div id="proposalPic-container"></div>
				
				
				<div class="input-group mb-3 input-group-sm for-space">
				  <div class="input-group-prepend">
				    <span class="input-group-text" id="inputGroup-sizing-sm">작성자</span>
				  </div>
				  <input id="proposer" style="background-color:white;" readonly type="text" class="form-control white-container" aria-label="Default" aria-describedby="inputGroup-sizing-sm">
				</div>
			
				<div class="input-group mb-3 input-group-sm for-space" style="margin-top:20px;">
				  <div class="input-group-prepend">
				    <span class="input-group-text" id="inputGroup-sizing-sm">주소</span>
				  </div>
				  <input id="addr" type="text" class="form-control white-container" aria-label="Default" aria-describedby="inputGroup-sizing-sm">
				</div>
				
				
				 <!-- 장소 -->
				<div class="theme-container for-space" style="display:flex; margin-bottom:30px;">
					<select class="custom-select custom-select-sm area-class" name="areaCode" id="areacode_" onclick="createAreaOption(0);">
							<option value="0">지역을 선택해보세요</option>
							<option value="1">서울</option>
							<option value="2">인천</option>
							<option value="3">대전</option>
							<option value="4">대구</option>
							<option value="5">광주</option>
							<option value="6">부산</option>
							<option value="7">울산</option>
							<option value="8">세종특별자치시</option>
							<option value="31">경기도</option>
							<option value="32">강원도</option>
							<option value="33">충청북도</option>
							<option value="34">충청남도</option>
							<option value="35">경상북도</option>
							<option value="36">경상남도</option>
							<option value="37">전라북도</option>
							<option value="38">전라남도</option>
							<option value="39">제주도</option>	
					</select>
					<select class="custom-select custom-select-sm sigungu-class" name="sigunguCode" id="sigungucode_" required>
						<!-- <option selected value="0">-- 선택 --</option> -->
					</select>
			   </div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				<div class="input-group mb-3 input-group-sm for-space">
				  <div class="input-group-prepend">
				    <span class="input-group-text" id="inputGroup-sizing-sm">테마</span>
				  </div>
				  <input id="theme" type="text" class="form-control white-container" aria-label="Default" aria-describedby="inputGroup-sizing-sm">
				</div>

				<div class="form-group">
					<label for="exampleFormControlTextarea1" style="font-weight:500;">소개글</label>
					<textarea id="info" class="form-control" id="exampleFormControlTextarea1"
						rows="3"></textarea>
				</div>

			</div>			
			<div class="addr-container">
				<div id="map" class="map-container">
					지도 
				</div>				
			</div>
			
			
 		</div> 
			<div class="btn-container">
					<button id="enroll" type="button" class="btn btn-outline-primary" style="margin-right:5px;">등록하기</button>
					<button type="button" class="btn btn-outline-secondary">목록으로</button>
			</div>	


	</div>
	
</section>
<script>


	let img;

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
			
			//받아온 데이터 토대로 화면 구성하기
			document.getElementById("proposer").value = data.memberId;
			document.getElementById("title").value= data.title;
			document.getElementById("addr").value=data.address;
			
			let theme;
			
			switch(data.cat2){
			
				case 'A0101' : theme='자연관광지'; break;
				case 'A0102' : theme='관광 자원'; break;
				case 'A0201' : theme='역사'; break;
				case 'A0202' : theme='휴양'; break;
				case 'A0203' : theme='체험'; break;
				case 'A0204' : theme='산업'; break;
				case 'A0205' : theme='건축/조형'; break;
				case 'A0206' : theme='문화시설'; break;
				case 'A0207' : theme='축제'; break;
				case 'A0208' : theme='공연/행사'; break;
				case 'C0112' : theme='가족'; break;
				case 'C0113' : theme='나홀로'; break;
				case 'C0114' : theme='힐링'; break;
				case 'C0115' : theme='도보'; break;
				case 'C0116' : theme='캠핑'; break;
				case 'C0117' : theme='맛'; break;
				case 'A0301' : theme='일반'; break;
				case 'A0302' : theme='육상'; break;
				case 'A0303' : theme='수상'; break;
				case 'A0304' : theme='항공'; break;
				case 'A0305' : theme='복합'; break;
				case 'A0401' : theme='쇼핑하기'; break;
				case 'A0502' : theme='먹기'; break;
				case 'free' : theme='자유여행'; break;
		
			}
			
			document.getElementById("theme").value = theme;
			if(data.info!=null&&data.info!=''){
				document.getElementById("info").value= data.info;
			} else {
				document.getElementById("info").value="소개글이 존재하지 않습니다";
			}
			
			
			//지도 출력하기
			mapStarter(data.mapy,data.mapx);
			img = data.firstImg.renamedFileName;
			console.log(img);
			
			const container = document.getElementById("proposalPic-container");
			if(data.firstImg.renamedFileName!=null&&data.firstImg.renamedFileName!=''){

			//console.log('이미지 존재함');
			
			async function getImg(){
				let response = await fetch("${path}/resources/place/proposal/"+data.firstImg.renamedFileName);
				let blob = await response.blob(); //응답을 blob형태로 가져옴
				let img = document.createElement("img");
				//const container = document.getElementById("proposalPic-container");
				container.append(img);
				container.append(document.createElement("hr"));
				img.className = "proposalImg";
				img.src = URL.createObjectURL(blob);

			}
			
			getImg();

		} 
			
/* 			else { //등록된 이미지가 없다면... 기본 이미지를 출력할 것인가, 관리자가 사진을 등록할 수 있게할까...
			
			let img = document.createElement("img");
			img.src = "${path}/resources/img/testPic/dimitri.png";
		
			container.append(img);
			container.append(document.createElement("hr"));
			img.className = "proposalImg";
			
		} */
		
			//지역 옵션 구성하기
			document.getElementById("areacode_").value= data.areaCode;
			fn_forSigungu(data.areaCode);
		
			
			
			//등록하기 버튼 클릭 시
			document.getElementById("enroll").addEventListener("click",e=>{
				fn_enroll(data);
			})
			
			
			
		})
		
	})();

	console.log(img);


	//Places 테이블로 데이터 등록하기
	function fn_enroll(data){
		
		console.log("들어왔니?", data);
		
		
		
		
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
 	
 	//지역 옵션 설정 (1,2 경우 모두에 적용되는 함수 구성하기) =======================================================================================
	//1. data 정보 토대로 옵션 구성해 출력하기
	//문제: 기존 코드는 areacode가 change되는 시점에, areacode값을 토대로 sigungu옵션을 구성할 수 있도록 구현됨
	//-> areacode옵션의 value에 따라 곧바로 sigungu코드가 구현될 수 있도록 함수를 변경해야 함
	//1의 경우는 기본이고 2의 경우에 따라서도 change를 반영해 sigungucode를 구성할 수 있도록 해야 함
	
	//2. data가 틀릴 수도 있으므로, 옵션 변경해 수정할 수 있도록 함
	
	const area = document.getElementsByClassName("area-class");
	const sigungu = document.getElementsByClassName("sigungu-class");
	
	area[0].addEventListener("change", e=>{
		
		fn_forSigungu(e.target.value);
		
	});
	
	function fn_forSigungu(e){
		
		if(e==1){ //서울
			
			let seoul = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구",
				         "금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구",
				         "서초구","성동구","성북구","송파구","양천구","영등포구","용산구",
				         "은평구","종로구","중구","중랑구"]
		
			insertInfo(seoul);

			 
		} else if (e==2){ //인천
			
			let incheon = ["강화군","계양구","미추홀구","남동구","동구","부평구","서구","연수구","옹진군","중구"];
			insertInfo(incheon);
		
		} else if (e==3){ //대전
			
			let daejeon = ["대덕구","동구","서구","유성구","중구"];
			insertInfo(daejeon);

		} else if (e==4){ //대구
			
			let daegu = ["남구","달서구","달성군","동구","북구","서구","수성구","중구"];
			insertInfo(daegu);
			
		} else if (e==5){ //광주
			
			let gwangju = ["광산구","남구","동구","북구","서구"];
			insertInfo(gwangju);
		
			} else if (e==6){ //부산
				
				let busan = ["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"]
				insertInfo(busan);
				
		} else if (e==7){ //울산
			
				let ulsan = ["중구","남구","동구","북구","울주군"]
				insertInfo(ulsan);
		
		} else if (e==8){ //세종
			
				sigungu[0].innerHTML = "";
		
				let option = document.createElement("option");
				option.innerText = "세종특별자치시";
				option.value = 1;
				sigungu[0].appendChild(option);
			
		} else if (e==31){ //경기
			
				let gyeonggi = ["가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시",
								"동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시",
								"양평군","여주시","연천군","오산시","용인시","의왕시","의정부시","이천시","파주시",
								"평택시","포천시","하남시","화성시"];
			
			insertInfo(gyeonggi);
		
		} else if (e==32){ //강원도
			
			let gangwon = ["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군",
						   "정선군","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"]
			insertInfo(gangwon);
			
		} else if (e==33){ //충북
			
			let chungbuk = ["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","진천군","청원군","청주시","충주시","증평군"]
			insertInfo(chungbuk);
			
		} else if (e==34){ //충남
			
			let chungnam = ["공주시","금산군","논산시","당진시","보령시",
							"부여군","서산시","서천군","아산시","예산군",
							"천안시","청양군","태안군","홍성군","계룡시"]
			insertInfo(chungnam);
		
		} else if (e==35){ //경북
			
			let gyeongbuk = ["경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군",
							"영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시"]
			insertInfo(gyeongbuk);				
			
		} else if (e==36){ //경남
			
			
			sigungu[0].innerHTML = "";
			let gyeongnam = ["거제시","거창군","고성군","김해시","남해군","마산시","밀양시","사천시","산청군","양산시",
							"의령군","진주시","진해시","창녕군","창원시",
							"통영시","하동군","함안군","함양군","합천군"]
		
			let code = 1;
			for(let i=0;i<10;i++){
				
				let option = document.createElement("option");
				option.innerText = gyeongnam[i];
				option.value = code++;
				sigungu[0].appendChild(option);					
			}
		
			//지역코드가 ~양산:10, 의령:12~임
			let codeFrom = 12;
			for(let i=10;i<gyeongnam.length;i++){
				
				let option = document.createElement("option");
				option.innerText = gyeongnam[i];
				option.value = codeFrom++;
				sigungu[0].appendChild(option);					
			}
			
		} else if (e==37){ //전북
			
			
			let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
						    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]
			insertInfo(jeonbuk);
			
			
		} else if (e==38){ //전남
			
			sigungu[0].innerHTML = "";
			//~여수시까지는 순차적임 (~13)
			//영광군부터 16~
			let jeonnam = ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시",
							"영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]

			let code = 1;
			for(let i=0;i<13;i++){
				
				let option = document.createElement("option");
				option.innerText = jeonnam[i];
				option.value = code++;
				sigungu[0].appendChild(option);					
			}
		
			//지역코드가 영광부터 16~임
			let codeFrom = 16;
			for(let i=13;i<jeonnam.length;i++){
				
				let option = document.createElement("option");
				option.innerText = jeonnam[i];
				option.value = codeFrom++;
				sigungu[0].appendChild(option);					
			}
			
		} else if (e==39){ //제주
			
			let jeju = ["남제주군","북제주군","서귀포시","제주시"]
			insertInfo(jeju);

		} else sigungu[0].innerHTML = "";
		
	}
	
	function insertInfo(city){ //지역 정보 대입 함수
		
		sigungu[0].innerHTML = "";
		let code = 1;
		
		city.forEach(e=>{
			
			let option = document.createElement("option");
			option.innerText = e;
			option.value = code++;
			sigungu[0].appendChild(option);
			
		});
		
	}
	
	
	
	
	
</script>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
