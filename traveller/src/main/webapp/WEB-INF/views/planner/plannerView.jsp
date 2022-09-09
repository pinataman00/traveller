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


</style>
<section class="container">
	<div class="container-fluid main-container">
		<div class="basic-info-container">			
				<p id="plannerTitle">내가 작성한 플래너</p>
				<p id="summary">플래너 설명</p>
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
				<button type="button" class="btn btn-outline-primary btn-sm">다운받기</button>
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
	
	//--------------------------------------------------------------------------------
	//PLAN데이터 가져오기 > select option이 변경되면, 일자에 대응되는 PLAN을 불러옴

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
			

			
			selectDays.addEventListener("change",e=>{
				
				alert(e.target.value);
				cardContainer.innerHTML="";
				
				//선택한 일자
				let ckDay = e.target.value;

				for(let i=0;i<data.length;i++){
					
					if(data[i].day==ckDay){ //선택한 옵션 일자에 대응되는 장소 정보 출력하기 
						
						//리스트 업---------------------------------------------------------------
						
							const planCard = document.createElement("div");
							planCard.classList.add("plan-card");
							const txtContainer = document.createElement("div");
							txtContainer.classList.add("text-container");
							
							const title = document.createElement("p");
							title.classList.add("place-title");
							title.innerText = data[i].placeName;
							
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
							
							cardContainer.append(planCard);
						
						//지도 관련 -----------------------------------------------------------------
						
							
						
						
					}
					
				}
				
				
				
			});
			
			
			
			
			


		});
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	})();
	
	

	
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

	
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>