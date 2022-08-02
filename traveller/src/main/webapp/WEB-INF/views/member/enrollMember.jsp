<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<section class="container">
	
		<div class="enroll-container">
		
			<div class="title-container">
				<h3>회원가입</h3>
			</div>
			<form name="memberEnrollFrm" action="${path }/member/enrollMemberEnd.do" method="post"
			enctype="multipart/form-data" onsubmit="return fn_enrollMemberValidate();">
				<div id="memberId-container">
					<input style="width:209px;" type="text" class="form-control" placeholder="아이디 (4~10글자)" name="memberId" id="memberId_" required>
					<button type="button" class="btn btn-outline-success" onclick="checkMemberId();">중복확인</button>					
				</div>
				<div>
					<span class="guide ok">사용 가능한 아이디입니다</span>
					<span class="guide error">이미 사용 중인 아이디입니다</span>
				</div>
				
				<div class="info-container">
				<input type="password" class="form-control" placeholder="비밀번호(대문자 1개 포함 최소 8글자 입력)" name="password" id="password_" required>
				<input type="password" class="form-control" placeholder="비밀번호 확인" id="password_2" required>
				<span id="pwRes"></span>
				<input type="text" class="form-control" placeholder="이메일" name="email" id="email_" required>
				<input type="text" class="form-control" placeholder="전화번호" name="phone" id="phone_" required>
				<textarea name="introduce" id="introduce_" placeholder="나는 누구인가요? 소개말을 써주세요"></textarea>
				</div>
				
				<div class="input-file-container">
					<h5 style="font-size:18px; text-align:left;">프로필 사진</h5>
					<div class="input-group mb-3">
					  <div class="custom-file">
					    <input type="file" class="custom-file-input" id="img_" name="img">
					    <label class="custom-file-label" for="inputGroupFile02">최대 10MB</label>
					  </div>
					</div>
				</div>


			<div class="area-container"">
					<h5 style="font-size:18px; text-align:left;">관심 지역</h5>
					<p style="font-size:13px; float:left;">관련 소식을 알림으로 알려드릴게요</p>
					
				<select class="custom-select custom-select-sm" name="areacode" id="areacode_">
							<option value="">-- 선택 --</option>
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
				<select class="custom-select custom-select-sm" name="sigungucode" id="sigungucode_">
				  <option selected>-- 선택 --</option>
				</select>
					
					
				</div>
				<div class="button-container" style="width:150px;">
					<input type="submit" class="btn btn-outline-success" value="가입하기">&nbsp;
					<input type="reset" class="btn btn-outline-success" value="취소하기">
				</div>
			</form>
		</div>
	

	</section>
	
	<script>
	
	
    $(document).ready(function() {
    	console.log("있니");
        console.log($.ajax);
      });

	
		const checkMemberId = ()=>{ //아이디 중복 체크
			
			const id = document.getElementById("memberId_").value;
			const ok = document.getElementsByClassName("ok");
			const error = document.getElementsByClassName("error"); 
			
			console.log(id);
			console.dir(ok[0]);
			console.log(error[0]);
			
			
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
					
				   	if(!data){
						  ok[0].style.display="block";
						  error[0].style.display="none";
					  } 
 				   	  else {
						  ok[0].style.display="none";
						  error[0].style.display="block";
					  }  			  
				});
			
		}
		
		
		//비밀번호 확인 일치 여부 안내
		$(()=>{
			
			const res = document.getElementById("pwRes");
			
			document.getElementById("password_2").addEventListener("keyup",e=>{
				const pwVal = document.getElementById("password_").value;
				const pwCk = e.target.value;
				if(pwCk.trim().length>3){
					if(pwVal==pwCk){
						res.innerText = "비밀번호 일치";
						res.style.color="#181182";
					} else {
						res.innerText = "비밀번호 불일치! 다시 입력하세요"
						res.style.color="red";
					}
				} else {
					res.innerText="";
				}
			});
			
		});
		
		//이메일 양식 준수 여부 체크
		function emailCk(email) {    
		    var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		    return (email != '' && email != 'undefined' && regex.test(email)); 
		}
	
		
		const email = document.getElementById("email_");
		email.addEventListener("blur", e=>{
			const emailVal = email.value;
			if (emailVal==''||email=='undefined') return;
			
			//유효성 체크 (정규표현식 기준)
			if(!emailCk(emailVal)){
				alert("이메일 양식에 맞춰 작성해주세요!");
				email.value = "";
				email.focus();
				return false;
			}
		});
		
		
		
		//유효성 체크
		const fn_enrollMemberValidate = ()=>{
			
			//1. 아이디
			const memberId = document.getElementById("memberId_").value;
			console.log(memberId);
			
			if(memberId.trim().length<4||memberId.trim().length>10){
				alert("아이디는 4글자 이상~10글자 이하로 입력하세요");
				document.getElementById("memberId_").focus();
				return false;
			} 
			
			//2. 비밀번호
			//정규표현식 : 최소 한 개의 대문자+최소 8자
			const exr = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
			const password=document.getElementById("password_").value;
			if(password.trim()<8||!exr.test(password)){
				alert("최소 한 개의 영문자가 포함된 8글자 이상의 비밀번호를 입력하세요");
				document.getElementById("password_").value="";
				document.getElementById("password_2").value="";
				document.getElementById("password_").focus();
				return false;
			}
			

		}
		
		//----------------------------------------------------------------------------------------------------
		//관심 지역 옵션 생성 관련
		const area = document.getElementById("areacode_");
		const sigungu = document.getElementById("sigungucode_");

		//다중select > ※ 전남, 경남... 지역코드가 순차적이지 않아 별도의 작업 수행함. 다른 지역도 그러한지 확인해야 함...
		
 		area.addEventListener("change", e=>{
			
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
				
					sigungu.innerHTML = "";
			
					let option = document.createElement("option");
					option.innerText = "세종특별자치시";
					option.value = 1;
					sigungu.appendChild(option);
				
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
				
				
				sigungu.innerHTML = "";
				let gyeongnam = ["거제시","거창군","고성군","김해시","남해군","마산시","밀양시","사천시","산청군","양산시",
								"의령군","진주시","진해시","창녕군","창원시",
								"통영시","하동군","함안군","함양군","합천군"]
			
				let code = 1;
				for(let i=0;i<10;i++){
					
					let option = document.createElement("option");
					option.innerText = gyeongnam[i];
					option.value = code++;
					sigungu.appendChild(option);					
				}
			
				//지역코드가 ~양산:10, 의령:12~임
				let codeFrom = 12;
				for(let i=10;i<gyeongnam.length;i++){
					
					let option = document.createElement("option");
					option.innerText = gyeongnam[i];
					option.value = codeFrom++;
					sigungu.appendChild(option);					
				}
				
			} else if (e.target.value==37){ //전북
				
				
				let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
							    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"]
				insertInfo(jeonbuk);
				
				
			} else if (e.target.value==38){ //전남
				
				sigungu.innerHTML = "";
				//~여수시까지는 순차적임 (~13)
				//영광군부터 16~
				let jeonnam = ["강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군","순천시","신안군","여수시",
								"영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"]

				let code = 1;
				for(let i=0;i<13;i++){
					
					let option = document.createElement("option");
					option.innerText = jeonnam[i];
					option.value = code++;
					sigungu.appendChild(option);					
				}
			
				//지역코드가 영광부터 16~임
				let codeFrom = 16;
				for(let i=13;i<jeonnam.length;i++){
					
					let option = document.createElement("option");
					option.innerText = jeonnam[i];
					option.value = codeFrom++;
					sigungu.appendChild(option);					
				}
				
			} else if (e.target.value==39){ //제주
				
				let jeju = ["남제주군","북제주군","서귀포시","제주시"]
				insertInfo(jeju);

			} else sigungu.innerHTML = "";
			
	}); 
		
		console.log(sigungu);

		function insertInfo(city){ //지역 정보 대입 함수
			
			sigungu.innerHTML = "";
			let code = 1;
			
			city.forEach(e=>{
				
				let option = document.createElement("option");
				option.innerText = e;
				option.value = code++;
				sigungu.appendChild(option);
				
			});
			
		}
		
		console.log(document.querySelector("#areacode_ option").value);
		console.log(document.querySelector("#sigungucode_ option").value);

	</script>
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp"%>