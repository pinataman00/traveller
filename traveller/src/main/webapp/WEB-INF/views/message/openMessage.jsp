<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메시지 | ${receiver}</title>
</head>
<style>
.container div {
/* 	border: 1px solid red; */
}
.title-container{
	height: 70px;
    text-align: center;
    border: 10px;
    margin-top: 10px;
    margin-bottom: 10px;
}
.text-container {
	height: 300px;
	border : 0.3px solid black;
	border-radius:10px;
}

.text-area {
	height: 50px;
    width: 313px;
    resize: none;
	border : 0.3px solid black;
	border-radius:5px;
}
img.profileImg {
	margin-top: 8px;
    margin-bottom: 2px;
    width: 40px;
    height: 40px;
    max-width: 40px;
    max-height: 40px;
    border-radius: 50px;
/*     border: 1px solid red; */
}
.input-container{
	display: flex;
    align-items: center;
    margin-top: 10px;
}
.msgImg{
	width: 30px;
    height: 30px;
    float: right;
    margin-left: 15px;
}

</style>
<body>
	<section class="container">
		<div class="title-container">
			<div class="receiver-img">
				<img id="basicImg" class="profileImg" src="${path}/resources/img/icons/person-fill.svg" alt="profileImg">
			</div>
			<div class="receiver-id">
				${receiver}
				<input type="hidden" id="receiver_id" value=${receiver}>
			</div>
		</div>
		<div class="text-container">
			메시지가 출력될 영역
		</div>
		<div class="input-container">
			<textarea class="text-area" id="text" rows="3"></textarea>
			<img id="basicImg" class="msgImg" src="${path}/resources/img/icons/send-plus.svg" alt="sendImg">
		</div>
		
	</section>
	
</body>

<script>

	(()=>{ //메시지 수신자 프로필 사진 가져오기
		
		let receiver = document.getElementById("receiver_id").value;
		
		fetch('${path}/member/receiverInfo/'+receiver, {
			  method: 'POST', 
			  headers: {
			    'Content-Type': 'application/json',
			  },
			  body: JSON.stringify({"memberId":receiver}),
			})
			.then((response) => response.json())
			.then((data) => {
			  
				console.log('성공:', data);
	
 				if(data.image.renamedFileName!=null){

 					console.log('사진 있어');
					async function getImg(){
						let response = await fetch("${path}/resources/member/profile/"+data.image.renamedFileName);
						let blob = await response.blob(); //응답을 blob형태로 가져옴
						document.getElementById("basicImg").src = URL.createObjectURL(blob);

					}
					
					getImg();
			
				}
				
				
			  
			});
		
	})(); 
</script>

</html>