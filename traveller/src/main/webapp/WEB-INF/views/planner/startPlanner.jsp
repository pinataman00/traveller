<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>

	.planner-container{
		/* margin-top: 100px; */
	    width: 700px;
	    display: inline-block;
	}
	.theme-container{
		display:flex;
		margin-bottom:20px;
	}
	.planner-setting-container{
		width:500px;
		display:inline-block;
		margin-top:30px;
	}
	.area-container{
		margin-top: 12px;
	    margin-bottom: 10px;
	    margin-left: 25px;
	    display: contents;
	    width: 300px;
	}
	.select-days{
		margin-top: 20px;
		margin-bottom: 20px;
	}
	div#makeGroup{
		margin-top: 80px;
	}
	.groupStart-btn{
		float:right;
		margin-top:25px;
	}
	.tempList{
		display:flex;
		align-items:baseline;
		border: 0.5px solid #e9e9e9;
		border-radius:10px;
		padding-top:10px;
		padding-bottom:10px;
		padding-left: 20px;
	}
	.delBtn{
		margin-left:20px;
	}
	.planner-title-container{
		margin-top : 100px;
		border-radius : 10px;
		text-align:left;
		/* width:800px; */
		/* display:inline-block; */
	}
	.planner-title{
		margin-left:30px;
	}
	.main-title{
		font-weight:500;
		font-size:30px;
	}
	.sub-title{
		font-size:15px;
	}
	.jumbotron{
		background-image:url("${path}/resources/img/planner_main_img.jpg");
	}
</style>





<section class="container">

<!-- 				<div class="jumbotron jumbotron-fluid planner-title-container">
					<div class="container planner-title">
						<h5 class="display-4 main-title">플래너 만들기</h5>
						<p class="lead sub-title">혼자서, 또는 여럿이 함께 떠나는 여행 계획을 세워보세요</p>
					</div>
				</div> -->

	<div class="planner-title-container">
		<div class="jumbotron" onclick="alert('여름!');">
			<h1 class="display-4">플래너 만들기</h1>
			<p class="lead">손끝에서 시작되는 여행</p>
			<hr class="my-4">
			<p>혼자서, 또는 친구와 함께 여행 계획을 세워보세요!</p>
		</div>
	</div>



	<hr>

	<div class="planner-container">

	<form action="${path }/planner/setting" method="post" onsubmit="return fn_planValidate();">
<!-- 		<div class="planner-title-container">
			<h4 style="text-align: left;">플래너를 시작해보세요</h4>
			<input type="hidden" name="memberId" id="memberId_" value=${loginMember.memberId}>
			<hr>
		</div> -->
		
		<input type="hidden" name="memberId" value="${loginMember.memberId}">
		<div class="planner-setting-container">
				
				<div class="input-group input-group-sm mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="inputGroup-sizing-sm">플랜 제목</span>
					</div>
					<input placeholder="띄어쓰기 포함 최대 15글자" name="plannerTitle" id="plannerTitle_" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" required>
				</div>
				<div class="theme-container">
					<!-- 테마 -->
					<div class="input-group-prepend">
						<span class="input-group-text" id="inputGroup-sizing-sm" style="height: 31px; font-size: 14px;">테마</span>
					</div>
					<select class="theme-select-one custom-select custom-select-sm" required>
						<option value="none">여행 테마를 선택해보세요</option>
						<option value="A01">자연</option>
						<option value="A02">인문</option>
						<option value="C01">추천 코스</option>
						<option value="A03">레포츠</option>
						<option value="shopping">쇼핑</option>
						<option value="food">음식</option>
						<option value="free">자유여행</option>
					</select> 
					<select name="theme" id="theme_" class="theme-select-two custom-select custom-select-sm" required>
						<!-- 테마 카테고리 상세 -->
					</select>
				</div>
				<div class="area-container">
					<!-- 지역 -->
					<p style="text-align: left;">주요 여행 지역</p>
					<select class="custom-select custom-select-sm area-class"
						name="areaCode" id="areacode_" onclick="createAreaOption();" required>
						<option value="0">-- 선택 --</option>
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
					</select> <select class="custom-select custom-select-sm sigungu-class"
						name="sigunguCode" id="sigungucode_" required>
						<option value="0">-- 선택 --</option>
					</select>

					<div class="select-days input-group input-group-sm mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text" id="inputGroup-sizing-sm">여행 일자</span>
						</div>
						<input name="travelDays" id="travelDays_" type="number" class="form-control" aria-label="Small"
							aria-describedby="inputGroup-sizing-sm" required>
					</div>

				</div>
				<div class="btn-container" style="float: right;">
					<button id="makeGroupBtn" type="button" class="btn btn-outline-primary"
						data-toggle="collapse" data-target="#makeGroup"
						aria-expanded="false" aria-controls="collapseExample" onclick="btnSetting();">그룹 만들기</button>
						<!-- "플래너 만들기" 버튼만 클릭한 경우에는, 그룹 관련 작업은 수행하지 않음 -->
					<button id="startBtn" type="submit" class="btn btn-outline-primary">플래너 만들기</button>
				</div>
			
				<!-- collapse : 그룹 만들기 -->
				<div class="collapse" id="makeGroup">
					<div class="card card-body" style="text-align:initial;margin-bottom:30px;">
						<p>함께 여행가고 싶은 친구들과 그룹을 만들어보세요!</p>
						<p style="color:red;font-size:13px;">* 주의 * <br> "그룹 만들기" 버튼을 재클릭할 경우, 작성 내용은 모두 소멸됩니다! </p>
						<div class="input-group input-group-sm mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-sm">그룹 이름</span>
							</div>
							<input name="crewTitle" id="crewTitle_" type="text" class="form-control"
								aria-label="Small" aria-describedby="inputGroup-sizing-sm">
						</div>
						<p>친구 찾기</p>
						<div class="input-group input-group-sm mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text" id="inputGroup-sizing-sm">ID</span>
							</div>
							<input id="findId_" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
							<button type="button" class="btn btn-primary btn-sm" onclick="findId();">검색</button>
						</div>
						<div class="search-res-container">
						<span class="guide error">존재하지 않는 회원입니다</span>
						<span class="guide ok">
							<div id="friendsList">
								<p>* 멤버 리스트</p>
								
								<!-- crewMember를 선택하지 않을 경우에는 @RequestParam에서 에러가 발생함... 가짜 데이터를 넣어줘야 할 거 같음 -->
								<input type="hidden" id="fakeInput" name="crewMember" value="fakeData">
								<!-- 검색된 아이디를 append로 추가함 -->
								<!-- 데이터를 서버로 넘기기 위해서는... 다중 값을 넘길 때는 역시 체크박스로 구성해야 하나? 
								     : 배열로 넘기면 될듯...
								-->
									
<!-- 									<div class="tempList">
											<p class="temp-id" name="crewMember" value="pinataman">pinataman</p>
											<button type="button" class="delBtn btn btn-outline-danger btn-sm">삭제하기</button>
										</div>  
								-->
							</div>
								<div class="groupStart-btn">
									<!-- 그룹으로 플래너 시작하기, 버튼 클릭 시 플래너 기본 정보+그룹 관련 정보를 저장함 -->
									<button id="startAsGroupBtn" type="submit" class="btn btn-primary">그룹으로 플래너 시작하기</button>
								</div>
							</span>
							</div>
				</form>	
			
	</div>

</section>


<!-- "그룹으로..." 버튼 재클릭 시, 관련 작성 내용은 소멸된다는 내용의 경고창 띄우기 -->
<div id="testModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">경고!</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="close">
          <span id="isOk" aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>"그룹 만들기" 버튼을 다시 클릭할 경우, 그룹 관련 작성 내용은 모두 소멸됩니다. 괜찮을까요?</p>
      </div>
      <div class="modal-footer">
        <button id="delOk" type="button" class="btn btn-primary">삭제돼도 괜찮아요</button>
        <button id="delNo" type="button" class="btn btn-secondary" data-dismiss="modal">삭제되면 안 돼요</button>
      </div>
    </div>
  </div>
</div>




<script>
	
	//그룹 만들기 ---------------------------------------------------------------------------------------
	//1. "그룹 만들기" 버튼 클릭 여부에 따라, "플래너 만들기"버튼 출력 옵션 설정
	const btnSetting = (()=>{
		
		const target = document.getElementById("startBtn");
		//TODO 0812) 그룹 관련 입력 값들도 form으로 넘어가면 안 되니까 초기화해야 함 
		//const groupSetting = document.getElementById
		let cnt = 0;
		
		return()=>{
			
			if(++cnt%2!=0){ //숨기기
			
				
				target.style.display="none";
			
			
			} else { //드러내기
				
				
				target.style.display="";
				
				//alert("버튼을 클릭할 경우, 지금껏 작성했던 그룹 관련 데이터는 삭제됩니다");
/* 				$('#testModal').modal('show');
				
				document.getElementById("delOk").addEventListener("click",e=>{
					--cnt;
					target.style.display="";
				});
				document.getElementById("delNo").addEventListener("click",e=>{
					//$('#testModal').modal('show');
					--cnt;
				}); */
				
			}
			
		}
		
	})();
	
	
	const findId = ()=>{
	
	const id = document.getElementById("findId_").value;
	const ok = document.getElementsByClassName("ok");
	const error = document.getElementsByClassName("error");
	const friendsList = document.getElementById("friendsList");
	
	fetch('${path}/member/checkMemberId.do?memberId='+id, {
		  method: 'POST', 
		  headers: {
		    'Content-Type': 'application/json',
		  },
		  body: JSON.stringify({memberId:id}),
		})
		.then((response) => response.json())
		.then((data) => {
		  
			console.log('성공:', data);
			
		   	if(data){ //검색한 아이디로 가입한 회원이 존재하는 경우
				  ok[0].style.display="block";
				  error[0].style.display="none";
				  
				  //리스트에 하나씩 추가하기
				  //document.getElementById("foundFriends").append();
				  const tempList = document.createElement("div");
				  tempList.classList.add("tempList");
				  
				  //기존의 fakeData는 지우기
				  document.getElementById("fakeInput").name="";
				  
				  //TODO 0812) p태그 대신 input태그로 바꿔봄...
/* 				  const tempId = document.createElement("p");
				  tempId.classList.add("temp-id");
				  tempId.innerText = id; */
				  
				  
				  const tempId = document.createElement("input");
				  tempId.classList.add("temp-id");
				  tempId.name="crewMember";
				  tempId.value=id;
				  tempId.readOnly=true;
				  
				  
				  tempList.append(tempId);
				  const delBtn = document.createElement("button");
				  delBtn.classList.add("delBtn");
				  delBtn.classList.add("btn");
				  delBtn.classList.add("btn-outline-danger");
				  delBtn.classList.add("btn-sm");
				  delBtn.innerText = "삭제하기";
				  tempList.append(delBtn);
				  
				  friendsList.append(tempList);

				  delBtn.addEventListener("click",e=>{
					  //alert('안녕?');
					  e.preventDefault();
					  console.log(e.target.parentElement);
					  e.target.parentElement.style.display="none";
					  //e.target.previousElementSibling.innerText="";
					  
					  
					  e.target.parentElement.innerHTML="";
					  
				  });
				  
				  
			  } else { //회원이 존재하지 않는 경우
				  //ok[0].style.display="none";
				  error[0].style.display="block";
			  }  			  
		});
	}

	
	
	//지역 옵션 구성하기
			const createAreaOption = ()=>{ //class名으로 지역별 옵션 생성하기
			
			
			//-------------------------------------------------------------------------------------------
			//관심 지역 옵션 *생성 관련
			const area = document.getElementsByClassName("area-class");
			const sigungu = document.getElementsByClassName("sigungu-class");

	 		area[0].addEventListener("change", e=>{
				
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
					
						sigungu[0].innerHTML = "";
				
						let option = document.createElement("option");
						option.innerText = "세종특별자치시";
						option.value = 1;
						sigungu[0].appendChild(option);
					
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
					
				} else if (e.target.value==37){ //전북
					
					
					let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
								    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]
					insertInfo(jeonbuk);
					
					
				} else if (e.target.value==38){ //전남
					
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
					
				} else if (e.target.value==39){ //제주
					
					let jeju = ["남제주군","북제주군","서귀포시","제주시"]
					insertInfo(jeju);

				} else sigungu[0].innerHTML = "";
				
		}); 
			
			console.log(sigungu);

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

		}
	
	
	//테마 옵션 구성하기
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
	
	function insertInto(nature,val){ //복수 옵션
		const themeTwo = document.getElementsByClassName("theme-select-two");
		themeTwo[0].innerHTML="";
		nature.forEach(n=>{
			let option = document.createElement("option");
			option.innerText = n;
			
			val.forEach(v=>{
				option.value = v;				
			});
			
			themeTwo[0].appendChild(option);			
		});
	}
	
	//form태그 유효성 체크 -----------------------------------------------------------------------------
	const fn_planValidate = ()=>{
		
		//플래너 제목은 띄어쓰기 포함 15글자로 제한함
		const plannerTitle = document.getElementById("plannerTitle_").value;
		if(plannerTitle.length>16){
			alert("플래너 제목은 15글자 이하로 입력해주세요!");
			//document.getElementById().focus("plannerTitle_");
			return false;
		}
		
		//여행 장소 선택을 안 했을 경우
		const areacode = document.getElementById("areacode_").value;
		console.log("////////////지역/////////////",areacode);
		if(areacode.value==0){
			alert("지역 관련 옵션을 선택해주세요");
			return false;
		}
		
		const sigungucode = document.getElementById("sigungucode_").value;
		console.log("////////////지역2/////////////",sigungucode);
		if(sigungucode.value==0){
			alert("지역 관련 옵션을 선택해주세요");
			return false;
		}
		
	}
	
	

	//데이터 전송 관련 ----------------------------------------------------------------------------------
	const startBtn = document.getElementById("startBtn");
	const startAsGroupBtn = document.getElementById("startAsGroupBtn");
	

	//이 부분에서 너무 오래 막힘... 보류
	
/*  	startBtn.addEventListener("click",e=>{
		
		//받아올 데이터
		const plannerTitle = document.getElementById("plannerTitle_").value;
		const theme = document.getElementById("theme_").value;
		const areacode = document.getElementById("areacode_").value;
		const sigungucode = document.getElementById("sigungucode_").value;
		const travelDays = document.getElementById("travelDays_").value;
		const memberId = document.getElementById("memberId_").value;
		
		fetch('${path}/planner/basicSetting', {
			  method: 'POST', 
			  headers: {
			    'Content-Type': 'application/json',
			  },
			  body: JSON.stringify({"plannerTitle":plannerTitle,"theme":theme,"memberId":memberId,"areaCode":areacode,"sigunguCode":sigungucode,"travelDays":travelDays,"theme":theme}),
			})
/* 			
  				.then((response) => response.json())
    			.then((data)=>{
			  
				console.log('성공:', data)
 			  	location.replace("${path}/planner/plannerEditor")
				
    		}) 

	}); */
	
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
