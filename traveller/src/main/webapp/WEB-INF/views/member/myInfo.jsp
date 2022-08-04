<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>


<style>
	div#container{
		margin-top:100px;
		text-align:center;
	}
	
	
	img.profileImg{
	
		margin-top: 20px;
		margin-bottom: 20px;
		width:100px;
		height:100px;
 		max-width: 200px;
	    max-height: 200px;
	    border-radius: 50px;
	    
/* 	    border:1px solid red; */
	
	}
	
	
	#update-info-frm{
	display: inline-grid;
	}
	
	div.btn-container{
	display: inline-block;
    margin-top: 20px;
    margin-bottom : 20px;
    margin-left: 25px;
	}
	
	div.btn-container button{
	width : 150px;
	}
	
	.input-file-container button{
	margin-left: 130px;
    margin-bottom: 8px;
    }
	
</style>



<section>

	<div id="container">
		<div id="title-container">
			<h3>${loginMember.memberId}님의 마이 페이지</h3>
		</div>
		<div id="myPic-container">
		<c:choose>
			<c:when test="${not empty loginMember.image.imgNo}">
		<!-- 파일 존재 여부에 따라서 기본 이미지||프로필 이미지 출력 
			 TODO 0803) 이상하게도, image멤버변수에 저장된 객체 값을 불러오지 못함...
			 (가입 시에는 setImage()로써 저장했고, 저장 내용은 getImage()로 확인할 수 있었으나, 
			 로그인 시 loginMember의 저장 내용을 확인해보면 image가 null임을 확인할 수 있음. 왤까. 
			 왜냐면! mapper로 쿼리문 작성할 때, <collection>태그와 join문을 사용하지 않았으니까!
			 
		-->
			
        	</c:when>
        	<c:when test="${empty loginMember.image.imgNo}">
        		<img class="profileImg" src="${path}/resources/img/icons/person-fill.svg" alt="profileImg">
        		<hr>
        	</c:when> 	
        </c:choose>
        	
        	
		</div>
		
			<div class="update-info-container">
			<form id="update-info-frm" name="infoFrm" action="${path }/member/myInfoEnd.do" 
			enctype="multipart/form-data" onsubmit="return fn_infoValidate();">
			
				<div class="info-container">
				<input type="text" class="form-control" placeholder="${loginMember.memberId}" readonly>	
				<button type="button" class="btn btn-primary btn-lg btn-block" style="margin-left:10px;" data-toggle="modal" data-target="#updatePwdBox">비밀번호 수정하기</button>
				<input type="text" class="form-control" placeholder="이메일" value="${loginMember.email }" name="email" id="email_" required>
				<input type="text" class="form-control" placeholder="전화번호" value="${loginMember.phone }" name="phone" id="phone_" required>
				<textarea name="introduce" id="introduce_" placeholder="${loginMember.introduce }"></textarea>
				</div>
				
				<div class="input-file-container">
					<div style="display:flex;">
					<h5 style="font-size:18px; text-align:left;">프로필 사진</h5>
					
					<!-- 프로필 사진 삭제 기능-->
					<c:if test="${not empty loginMember.image.imgNo}">
						<button type="button" class="btn btn-secondary btn-sm" onclick="location.assign('${path}/member/deletePic.do?memberId=${loginMember.memberId}')">삭제하기</button>
					</c:if>
						
					</div>
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
					
				<select class="custom-select custom-select-sm" name="areaCode" id="areacode_">
				
					
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

						
				</select>
				<select class="custom-select custom-select-sm" name="sigunguCode" id="sigungucode_">
				  <option selected value="0">-- 선택 --</option>
				</select>
					
					
				</div>
				<div class="btn-container">
					<button type="button" class="btn btn-primary btn-lg">수정하기</button>
					<button type="button" class="btn btn-outline-danger btn-lg" onclick="location.assign('${path}/member/deleteMember.do?memberId=${loginMember.memberId}')">탈퇴하기</button>
				</div>
			</form>

		</div>
		
	</div>
			
</section>

<!-- 모달 : "비밀번호 수정하기" 버튼 클릭 시 -->

<div class="modal fade" id="updatePwdBox" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">비밀번호 수정하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      		<div style="text-align:center;margin:10px;">
		        <form action="${path }/member/updatePwd.do?memberId=${loginMember.memberId}" method="post"
		        onsubmit="return fn_pwdValidate();">
		        		<p style="float:left">현재 비밀번호</p>
		        		<input type="password" class="form-control" placeholder="현재 비밀번호" name="nowPwd" id="nowPwd_" required>
		        		<span id="ckRes"></span>
		        		<p style="float:left;margin-top:10px;">수정할 비밀번호</p>
						<input type="password" class="form-control" placeholder="비밀번호(숫자, 문자 1개 포함 최소 8글자 입력)" name="memberPwd" id="password_" required>
						<input type="password" class="form-control" placeholder="비밀번호 확인" id="password_2" required>
						<span style="float:left"; id="pwRes"></span>
		        		<input style="float:right;margin-top:50px;" class="btn btn-primary" type="submit" value="수정하기">
		        </form>
	        </div>
      </div>
    </div>
  </div>
</div>
<script>


	/* 유효성 체크 */



	/* 비밀번호 수정 관련 로직 구현하기 */
	
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
	
	/* 비밀번호 유효성 체크 */
	const fn_pwdValidate = ()=>{
		
		const exr = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
		const password=document.getElementById("password_").value;
		console.log("내가 입력한 패스워드 ",password);
		
		if(password.trim()<8||!exr.test(password)){
			alert("최소 한 개의 숫자와 문자가 포함된 8글자 이상의 비밀번호를 입력하세요");
			document.getElementById("password_").value="";
			document.getElementById("password_2").value="";
			document.getElementById("password_").focus();
			return false;
			
		}
	}
	
	
</script>





<script>


		//관심 지역 : 옵션 선택하기
		//const area = document.getElementById("areacode_");
		const areas = document.querySelectorAll("#areacode_ option");
		const sigunguContainer = document.getElementById("sigungucode_");
		const sigungu = document.getElementById("sigungucode_");
		
		console.log("//////////", sigunguContainer);
		
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
		
		
		let seoul = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구",
			         "금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구",
			         "서초구","성동구","성북구","송파구","양천구","영등포구","용산구",
			         "은평구","종로구","중구","중랑구"];
		let incheon = ["강화군","계양구","미추홀구","남동구","동구","부평구","서구","연수구","옹진군","중구"];
		let daejeon = ["대덕구","동구","서구","유성구","중구"];
		let daegu = ["남구","달서구","달성군","동구","북구","서구","수성구","중구"];
		let gwangju = ["광산구","남구","동구","북구","서구"];
		let busan = ["강서구","금정구","기장군","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"];
		let ulsan = ["중구","남구","동구","북구","울주군"];
		const sejong = ()=>{
			
			sigungu.innerHTML = "";		
			let option = document.createElement("option");
			option.innerText = "세종특별자치시";
			option.value = 1;
			sigungu.appendChild(option);
			
		}
			let gyeonggi = ["가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시",
					"동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시",
					"양평군","여주시","연천군","오산시","용인시","의왕시","의정부시","이천시","파주시",
					"평택시","포천시","하남시","화성시"];
			let gangwon = ["강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군",
				   "정선군","철원군","춘천시","태백시","평창군","홍천군","화천군","횡성군"]
			
		
		
			let chungbuk = ["괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","진천군","청원군","청주시","충주시","증평군"];		
			let chungnam = ["공주시","금산군","논산시","당진시","보령시",
				"부여군","서산시","서천군","아산시","예산군",
				"천안시","청양군","태안군","홍성군","계룡시"];
			let gyeongbuk = ["경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군","안동시","영덕군",
				"영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군","포항시"];
		
			const gyeongnam = ()=>{
				
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
				
				
			}
		
			let jeonbuk = ["고창군","군산시	","김제시","남원시","무주군","부안군","순창군",
			    "완주군","익산시","임실군","장수군","전주시","정읍시","진안군"];
			
			const jeonnam = ()=>{
				
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
				
			}
		
			let jeju = ["남제주군","북제주군","서귀포시","제주시"];
		
		
			
		
		for(let i=0;i<areas.length;i++){
			
			if(areas[i].value==${loginMember.areaCode}){
				areas[i].selected="true";
				
	 				switch(areas[i].value){
					
					case '1' : insertInfo(seoul);break;
					case '2' : insertInfo(incheon);break;
					case '3' : insertInfo(daejeon);break;
					case '4' : insertInfo(daegu);break;
					case '5' : insertInfo(gwangju);break;
					case '6' : insertInfo(busan);break;
					case '7' : insertInfo(ulsan);break;
					case '8' : sejong();break;
					case '31' : insertInfo(gyeonggi);break;
					case '32' : insertInfo(gangwon);break;
					case '33' : insertInfo(chungbuk);break;
					case '34' : insertInfo(chungnam);break;
					case '35' : insertInfo(gyeongbuk);break;
					case '36' : gyeongnam();break;
					case '37' : insertInfo(jeonbuk);break;
					case '38' : jeonnam();break;
					case '39' : insertInfo(jeju);break;
					
					} 
					
					break;
			}		
		}
		
		//클라이언트가 가입 시 설정했던 관심 sigungucode 설정하기
		const sigungus = document.querySelectorAll("#sigungucode_ option");
		console.log(sigungus);
		for(let i=0;i<sigungus.length;i++){
			if(sigungus[i].value==${loginMember.sigunguCode}){
				sigungus[i].selected="true";
			}
		}
		
		
		
		//areacode기준으로 sigungucode 생성 및 선택하기
		const area = document.getElementById("areacode_");
		console.log("//////////////////",area.value);

		
		area.addEventListener("change", e=>{
			
			if(e.target.value==1){ //서울
			
				insertInfo(seoul);
			 
			} else if (e.target.value==2){ //인천

				insertInfo(incheon);
			
			} else if (e.target.value==3){ //대전
				
				insertInfo(daejeon);

			} else if (e.target.value==4){ //대구
				
				insertInfo(daegu);
				
			} else if (e.target.value==5){ //광주
				
				insertInfo(gwangju);				
				
 			} else if (e.target.value==6){ //부산
 								
 				insertInfo(busan);
 				
			} else if (e.target.value==7){ //울산
				
 				insertInfo(ulsan);
			
			} else if (e.target.value==8){ //세종
				
					sejong();
				
			} else if (e.target.value==31){ //경기
				
				insertInfo(gyeonggi);
				
			} else if (e.target.value==32){ //강원도

				insertInfo(gangwon);
				
			} else if (e.target.value==33){ //충북

				insertInfo(chungbuk);
				
			} else if (e.target.value==34){ //충남
				
				insertInfo(chungnam);
			
			} else if (e.target.value==35){ //경북

				insertInfo(gyeongbuk);				
				
			} else if (e.target.value==36){ //경남
				
				gyeongnam();				
				
			} else if (e.target.value==37){ //전북

				insertInfo(jeonbuk);
				
			} else if (e.target.value==38){ //전남
				
				jeonnam();
				
			} else if (e.target.value==39){ //제주
				
				insertInfo(jeju);

			} else sigungu.innerHTML = "";
			
	}); 
		
		console.log(sigungu);

	
		//프로필 이미지 사진 출력하기
		if(${loginMember.image.renamedFileName!=null}){

			async function getImg(){
				let response = await fetch("${path}/resources/member/profile/${loginMember.image.renamedFileName}");
				let blob = await response.blob(); //응답을 blob형태로 가져옴
				let img = document.createElement("img");
				const container = document.getElementById("myPic-container");
				container.append(img);
				container.append(document.createElement("hr"));
				img.className = "profileImg";
				img.src = URL.createObjectURL(blob);
			}
			
			getImg();
	
		}
		
		//작성 내용 유효성 체크 관련
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
		//이메일 양식 준수 여부 체크
		function emailCk(email) {    
		    var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		    return (email != '' && email != 'undefined' && regex.test(email)); 
		}
	
		

		email.addEventListener("blur", e=>{
			const emailVal = email.value;
			if (emailVal==''||email=='undefined') return;
			
			//유효성 체크 (정규표현식 기준)
			if(!emailCk(emailVal)){
				alert("이메일 양식에 맞춰 작성해주세요!");
				email.value = "${loginMember.email}";
				email.focus();
				return false;
			}
		});
		

</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

