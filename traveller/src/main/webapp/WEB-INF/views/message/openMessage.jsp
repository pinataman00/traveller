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
    cursor:pointer;
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
		<div class="text-container" id="textContainer">
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

					async function getImg(){
						let response = await fetch("${path}/resources/member/profile/"+data.image.renamedFileName);
						let blob = await response.blob(); //응답을 blob형태로 가져옴
						document.getElementById("basicImg").src = URL.createObjectURL(blob);
					}					
					getImg();			
				}
			  
			});
		
	})();
	
	//수신자 정보 > 아이디 받아오기
	const receiver = document.getElementById("receiver_id").value;
	
	class Message { //WebSocket서버 접속한 클라이언트 관련 정보 저장 객체
		
		constructor(type,sender,receiver,msg,room){
			this.type=type;
			this.sender=sender;
			this.receiver=receiver;
			this.msg=msg;
			this.room=room;
		}
	}
	
	//1. WebSocket 객체 생성 
	const websocket = new WebSocket("ws://localhost:9090/message");
	//2. WebSocket 서버 접속 時 실행
	websocket.onopen = e => { //-> WebSocketHandler의 afterConnectionEstablished()가 실행될 것임
		
		
		console.log("수신자 : ",receiver);
		//※ send()메소드 실행 -> WebSocketHandler의 handleTextMessage()메소드가 실행될 것임
		websocket.send(JSON.stringify(new Message("access","${loginMember.memberId}","","")));
				
	}
	//2. "메시지 (WebSocket서버로) 발송" = WebSocketHandler의 handleTextMessage()메소드가 실행될 것임
	document.getElementsByClassName("msgImg")[0].addEventListener("click",e=>{
		
		const msgText = document.getElementById("text").value;
		console.log(msgText);
		websocket.send(JSON.stringify(new Message("msg","${loginMember.memberId}","",msgText,"")));
		
	});
	//3. WebSocketHandler클래스의 sendMessage()메소드가 보낸 데이터를, 
	//websocket객체.onmessage()메소드가 처리할 수 있음
	websocket.onmessage = e=>{
		
		console.log(e);
		const msg = JSON.parse(e.data); //서버에서 writeValueAsString()으로 전송한 문자열 데이터를, JS객체로 변환하기
		const textContainer = document.getElementById("textContainer");
		//const temp = document.getElementById("textContainer").innerHTML; //메시지 출력 컨테이너에 담긴 태그 일체 소환
		
		const sender = document.createElement("p");
		sender.innerText = msg['sender'];
		textContainer.append(sender);
		
		const msgText = document.createElement("p");
		msgText.innerText = msg['msg'];
		textContainer.append(msgText);
		
		//textContainer.append(+msg['sender']+"</p>:<p>"+msg['msg']+"</p>");
		
	}
	
</script>

</html>