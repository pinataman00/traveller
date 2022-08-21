<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- 지도 관련 스크립트 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=LIBRARY"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services,clusterer,drawing"></script>

<style>
.container {
	margin-top: 100px;
	text-align:center;
}

.setting-container{
	/* border : 1px solid red; */
	width : 800px;
	/* margin-left : 150px; */
	display:inline-block;
	margin-bottom:50px;
}
.setting-container p{
	text-align: left;
}
.info-container{
	width:800px;
	display:inline-block;
	margin-left: -1px;
}
.cnt-container{
	display:flex;
	float:right;
	margin-right:10px;
	margin-bottom:-10px;
}
textarea{
	height:261px;
	width:792px;
	resize:none;
	border-radius:10px;
	outline-color: #FE6B8B;
}
.map-container{
	margin-left:58px;
	margin-top:51px;
}
.map-container div{
	margin-top :10px;
}
.jumbotron{
	background-color:#E8D9FF;
}
</style>
<section>
	<div class="container">
		<div class="main-title-container">
			<div class="promotion-container">
				<div class="jumbotron" style="text-align:left;">
					<h1 class="display-4">장소 제안하기</h1>
					<hr class="my-4">
					<p style="text-align:left;">모두에게 자랑하고 싶은 장소를 알려주세요!</p>
				</div>
			</div>
		</div>
		
		<div>
					<div class="setting-container">
					<form action="${path}/place/placeProposal" method="post" enctype="multipart/form-data">
							<input id="memberId_" name="memberId" type="hidden" value="${loginMember.memberId}">
							<div class="input-group input-group-sm mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroup-sizing-sm">장소명</span>
								</div>
								<input name="title" id="title_" type="text" class="form-control" aria-label="Small"
									aria-describedby="inputGroup-sizing-sm" placeholder="장소명을 입력해주세요 (ex. 경복궁)" required>
							</div>

							<!-- 대표 이미지 등록 -->
							<div style="margin-top:20px;"> 
								<h5 style="font-size: 16px; text-align: left;">대표 이미지 (최대 10MB)</h5>
								<div class="input-group mb-3">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="img_"
											name="img"> <label class="custom-file-label"
											for="inputGroupFile02"></label>
									</div>
								</div>
							</div>



					<!-- 테마 -->
							<p style="margin-bottom:10px;">테마</p>
							<div class="theme-container" style="display:flex;">
								<select class="theme-select-one custom-select custom-select-sm">
									<option value="none">여행 테마를 선택해보세요</option>
									<option value="A01">자연</option>
									<option value="A02">인문</option>
									<option value="C01">추천 코스</option>
									<option value="A03">레포츠</option>
									<option value="shopping">쇼핑</option>
									<option value="food">음식</option>
									<option value="free">자유여행</option>
								</select>
								<select name="cat2" id="cat2_" class="theme-select-two custom-select custom-select-sm" required>
									<!-- 테마 카테고리 상세 -->
								</select>
						   </div>
						   <!-- 장소 -->
							<p style="margin-bottom:10px;">장소</p>
							<div class="theme-container" style="display:flex;">
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
						   <!-- 주소 검색 -->
					
						<div class="input-group input-group-sm mb-3" style="margin-top:20px;">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-sm">상세 주소</span>
							</div>
							<input name="address" id="address_" type="text" class="form-control"
								aria-label="Small" aria-describedby="inputGroup-sizing-sm"
								placeholder="주소지를 입력해주세요 (ex. 서울 종로구 사직로 161)" required>
								
						  <button class="btn btn-primary btn-sm" id="addrBtn" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
   							확인하기
 						  </button>
							<div class="collapse" id="collapseExample">
							  <div class="card card-body map-container">
							    	주소창에 입력하신 주소 정보를 토대로 출력된 지도입니다. 이 장소가 맞는지 확인해주세요
							    	<div id="map" style="width:100%;height:500px;"></div>			  	
							  </div>
							  
							  <input type="hidden" name="mapx" id="mapx_">
							  <input type="hidden" name="mapy" id="mapy_">
							</div>
						</div>
	
							<!-- 소개 글 -->
							<div class="info-container">
								<div class="cnt-container">
									<p class="textCount">0자</p>
									<p class="totalCount">/1000자</p>
								</div>
								<textarea class="textBox" name="info" id="info_" id="textBox" style="height: 300px; resize: none;" maxlength="1000"
									placeholder="소개글을 입력하세요" required></textarea>
							</div>
							<button type="submit" class="btn btn-primary btn-lg btn-block">장소 등록 신청하기</button>
						</form>	
						</div>
		</div>
		
				
	</div>
</section>
<script>

	//페이지 접속 회원 아이디 확인
	//console.log("접속 중 : "+document.getElementById("memberId_").value);

	//텍스트 박스 > 1000자 제한 확인
	const textBox = document.getElementsByClassName("textBox")[0];
	const textCnt = document.getElementsByClassName("textCount")[0];
	
	textBox.addEventListener("keyup",e=>{
		
		let content = e.target.value;
		//console.log(content.length);
		
		//글자 수 세기
		if(content.length==0||content==''){
			textCnt.innerText='0자';
		} else {
			textCnt.innerText= content.length+'자';
		}
		
		//글자 수 알림
		if(content.length>1000){
			//1000자부터는 타이핑 방지
			//e.target.value(e.target.value.substr(0,10));
			 content = content.substring(0, 1000);
			 
			//1000자 초과 시 알림창
			alert('글자 수 1000자까지 입력하실 수 있습니다');
		}
		
	});
	

	//카카오맵API활용, 좌표 정보 받아오기
	const addrBtn = document.getElementById("addrBtn");
	
	
	
	addrBtn.addEventListener("click",e=>{
		
		
 		setTimeout(function(){
 			
 			
 			
			map.relayout();
			map.setCenter(new kakao.maps.LatLng(33.450701, 126.570667));
			
			let addr = document.getElementById("address_").value;
			console.log(addr);
			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(addr, function(result, status) {

			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {

			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });

			        // 인포윈도우로 장소에 대한 설명을 표시합니다
/* 			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">이곳인가요?</div>'
			        });
			        infowindow.open(map, marker); */

			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			        
			        console.log("x좌표 : ", result[0].x);
			        document.getElementById("mapx_").value= result[0].x; //위도 : latitude
			        console.log("y좌표 : ", result[0].y);
			        document.getElementById("mapy_").value= result[0].y; //경도 : longitude
			        
			    } 
			});  
			
			
			
			
			
			
			
			
			
			
			
		}, 100);
	
	});
	
	
	
	
//카카오맵API 사용, 클라이언트가 입력한 주소 토대로 좌표 값을 받아오는 것이 목적임



var mapContainer = document.getElementById('map'), // 지도를 표시할 div

    mapOption = {
       center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
       level: 3 // 지도의 확대 레벨
   };  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//지역 옵션 설정 =======================================================================================
		const createAreaOption = (idx)=>{ //class名으로 지역별 옵션 생성하기
			
			
			//-------------------------------------------------------------------------------------------
			//관심 지역 옵션 *생성 관련
			const area = document.getElementsByClassName("area-class");
			const sigungu = document.getElementsByClassName("sigungu-class");

	 		area[idx].addEventListener("change", e=>{
				
				if(e.target.value==1){ //서울
					
					let seoul = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구",
						         "금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구",
						         "서초구","성동구","성북구","송파구","양천구","영등포구","용산구",
						         "은평구","종로구","중구","중랑구"]
				
					insertInfo(seoul);
	
					 
				} else if (e.target.value==2){ //인천
					
					let incheon = ["강화군","계양구","미추홀구","남동구","동구","부평구","서구","연수구","옹진군","중구"];
					insertInfo(incheon);
				
				} else if (e.target.value==3){ //대전
					
					let daejeon = ["대덕구","동구","서구","유성구","중구"];
					insertInfo(daejeon);

				} else if (e.target.value==4){ //대구
					
					let daegu = ["남구","달서구","달성군","동구","북구","서구","수성구","중구"];
					insertInfo(daegu);
					
				} else if (e.target.value==5){ //광주
					
					let gwangju = ["광산구","남구","동구","북구","서구"];
					insertInfo(gwangju);
				
	 			} else if (e.target.value==6){ //부산
	 				
	 				let busan = ["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"]
	 				insertInfo(busan);
	 				
				} else if (e.target.value==7){ //울산
					
	 				let ulsan = ["중구","남구","동구","북구","울주군"]
	 				insertInfo(ulsan);
				
				} else if (e.target.value==8){ //세종
					
						sigungu[idx].innerHTML = "";
				
						let option = document.createElement("option");
						option.innerText = "세종특별자치시";
						option.value = 1;
						sigungu[idx].appendChild(option);
					
				} else if (e.target.value==31){ //경기
					
	 				let gyeonggi = ["가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시",
	 								"동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시",
	 								"양평군","여주시","연천군","오산시","용인시","의왕시","의정부시","이천시","파주시",
	 								"평택시","포천시","하남시","화성시"];
					
					insertInfo(gyeonggi);
				
				} else if (e.target.value==32){ //강원도
					
					let gangwon = ["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군",
								   "정선군","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"]
					insertInfo(gangwon);
					
				} else if (e.target.value==33){ //충북
					
					let chungbuk = ["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","진천군","청원군","청주시","충주시","증평군"]
					insertInfo(chungbuk);
					
				} else if (e.target.value==34){ //충남
					
					let chungnam = ["공주시","금산군","논산시","당진시","보령시",
									"부여군","서산시","서천군","아산시","예산군",
									"천안시","청양군","태안군","홍성군","계룡시"]
					insertInfo(chungnam);
				
				} else if (e.target.value==35){ //경북
					
					let gyeongbuk = ["경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군",
									"영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시"]
					insertInfo(gyeongbuk);				
					
				} else if (e.target.value==36){ //경남
					
					
					sigungu[idx].innerHTML = "";
					let gyeongnam = ["거제시","거창군","고성군","김해시","남해군","마산시","밀양시","사천시","산청군","양산시",
									"의령군","진주시","진해시","창녕군","창원시",
									"통영시","하동군","함안군","함양군","합천군"]
				
					let code = 1;
					for(let i=0;i<10;i++){
						
						let option = document.createElement("option");
						option.innerText = gyeongnam[i];
						option.value = code++;
						sigungu[idx].appendChild(option);					
					}
				
					//지역코드가 ~양산:10, 의령:12~임
					let codeFrom = 12;
					for(let i=10;i<gyeongnam.length;i++){
						
						let option = document.createElement("option");
						option.innerText = gyeongnam[i];
						option.value = codeFrom++;
						sigungu[idx].appendChild(option);					
					}
					
				} else if (e.target.value==37){ //전북
					
					
					let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
								    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]
					insertInfo(jeonbuk);
					
					
				} else if (e.target.value==38){ //전남
					
					sigungu[idx].innerHTML = "";
					//~여수시까지는 순차적임 (~13)
					//영광군부터 16~
					let jeonnam = ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시",
									"영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]

					let code = 1;
					for(let i=0;i<13;i++){
						
						let option = document.createElement("option");
						option.innerText = jeonnam[i];
						option.value = code++;
						sigungu[idx].appendChild(option);					
					}
				
					//지역코드가 영광부터 16~임
					let codeFrom = 16;
					for(let i=13;i<jeonnam.length;i++){
						
						let option = document.createElement("option");
						option.innerText = jeonnam[i];
						option.value = codeFrom++;
						sigungu[idx].appendChild(option);					
					}
					
				} else if (e.target.value==39){ //제주
					
					let jeju = ["남제주군","북제주군","서귀포시","제주시"]
					insertInfo(jeju);

				} else sigungu[idx].innerHTML = "";
				
		}); 
			
			console.log(sigungu);

			function insertInfo(city){ //지역 정보 대입 함수
				
				sigungu[idx].innerHTML = "";
				let code = 1;
				
				city.forEach(e=>{
					
					let option = document.createElement("option");
					option.innerText = e;
					option.value = code++;
					sigungu[idx].appendChild(option);
					
				});
				
			}

		}	
	
		//테마 옵션 구성하기 =============================================================
		const themeOne = document.getElementsByClassName("theme-select-one");	
		themeOne[0].addEventListener("change",e=>{
		//alert(e.target.value);
		const opt = e.target.value;
		
		if(opt=='none'){
			document.getElementsByClassName("theme-select-two")[0].innerHTML="";
		}
		
		if(opt=='A01'){			
			let nature = ["자연 관광지","관광 자원"];
			let val = ["A0101","A0102"];
			insertInto(nature,val);			
		}
		
		if(opt=='A02'){
			let culture = ["역사","휴양","체험","산업","건축/조형","문화시설","축제","공연/행사"];
			let val = ["A0201","A0202","A0203","A0204","A0205","A0206","A0207","A0208"];
			insertInto(culture,val);
		}
		
		if(opt=='C01'){
			let course = ["가족","나홀로","힐링","도보","캠핑","맛"];
			let val = ["C0112","C0113","C0114","C0115","C0116","C0117"];
			insertInto(course,val);
		}
		
		if(opt=='A03'){
			let repo= ["일반","육상","수상","항공","복합"];
			let val = ["A0301","A0302","A0303","A0304","A0305"];
			insertInto(repo,val);
		}

		if(opt=='shopping'){
			insertTheme('쇼핑하기','A0401');
		}
		if(opt=='food'){
			insertTheme('먹기','A0502');
		}
		if(opt=='free'){
			insertTheme('자유로운 여행','free');
		}
	
	});
	
	function insertTheme(theme,cat){ //단일 옵션
		const themeTwo = document.getElementsByClassName("theme-select-two");
		themeTwo[0].innerHTML="";
		let option = document.createElement("option");
		option.innerText = theme;
		option.value= cat;
		themeTwo[0].appendChild(option);
	}
	
	function insertInto(theme,val){ //복수 옵션
		
		const themeTwo = document.getElementsByClassName("theme-select-two");
		themeTwo[0].innerHTML="";
		
/* 		theme.forEach(n=>{
			
			let option = document.createElement("option");
			option.innerText = n;
			
			val.forEach(v=>{
				option.value = v;				
			});
			
		
			themeTwo[0].appendChild(option);			
		}); */
		
		
		for(let i=0;i<theme.length;i++){
			let option = document.createElement("option");
			option.innerText = theme[i];
			option.value = val[i];
			themeTwo[0].appendChild(option);
		}
		
		
	}

</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>