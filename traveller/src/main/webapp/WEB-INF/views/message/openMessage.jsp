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
	border : 0.3px solid #dcdcdc;
	border-radius:10px;
}

.text-area {
	height: 50px;
    width: 313px;
    resize: none;
	border : 0.3px solid #dcdcdc;
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
.text-container{
	overflow-y: scroll;	
}
.text-container::-webkit-scrollbar{
	display:none;
}

div#your-container{
    width: 230px;
    margin-left: 10px;
    margin-top: 10px;
    margin-bottom: 10px;
}
div#your-id{
	margin-bottom: 2px;
}
div#your-msg{
	background-color: #D2D2FF;
    border-radius: 10px;
    padding: 10px;
}

div#my-container{

    width: 230px;
    margin-left: 150px;
    margin-top: 10px;
}
div#my-msg{
	background-color: #FFEB46;
    border-radius: 10px;
    padding: 10px;
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
			<!-- 메시지가 출력될 영역 -->
			
			
<!--
			출력 샘플
 			<div id="your-container">
				<div id="your-id">상대방</div>
				<div id="your-msg">
					메시지출력 메시지출력메시지출력메시지출력메시지출력메시지출력메시지출력메시지출력메시지출력
				</div>
			</div>
			<div id="my-container">
				<div id="my-msg">
					메시지출력 메시지출력메시지출력메시지출력메시지출력메시지출력메시지출력메시지출력메시지출력
				</div>
			</div> -->
			
		</div>
		<div class="input-container">
			<input type="hidden" id="myId" value="${loginMember.memberId}">
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
		//TODO 0811) 전체 발송 : websocket.send(JSON.stringify(new Message("access","${loginMember.memberId}","","")));
		websocket.send(JSON.stringify(new Message("access","${loginMember.memberId}",receiver,"","")));
				
	}
	//2. "메시지 (WebSocket서버로) 발송" = WebSocketHandler의 handleTextMessage()메소드가 실행될 것임
	document.getElementsByClassName("msgImg")[0].addEventListener("click",e=>{
		
		const msgText = document.getElementById("text").value;
		console.log(msgText);
		console.log("수신자? ", receiver);
		//const msg = new Message("msg","${loginMember.memberId}",receiver,msgText,"");
		//websocket.send(JSON.stringify(new Message("msg","${loginMember.memberId}","",msgText,"")));
		//console.log("객체?",msg)
		//websocket.send(JSON.stringify(msg));
		websocket.send(JSON.stringify(new Message("msg","${loginMember.memberId}",receiver,msgText,"")));
		
	});
	//3. WebSocketHandler클래스의 sendMessage()메소드가 보낸 데이터를, 
	//websocket객체.onmessage()메소드가 처리할 수 있음
	websocket.onmessage = e=>{ //TODO 0810) 방, 귓속말 등 분기처리하기
		
		console.log(e);
		const msg = JSON.parse(e.data); //서버에서 writeValueAsString()으로 전송한 문자열 데이터를, JS객체로 변환하기
		const textContainer = document.getElementById("textContainer");
		
		//------------------------------------------------------------------------------------
		
		const myId = document.getElementById("myId").value;
		
		
		//메시지 컨테이너 구성하기
		if(msg['receiver']==''){ //1. 일반적인 메시지 ('수신자'가 별도로 설정되지 않은 경우)
			
			if(msg['sender']== myId){ //발신자 메시지 처리하기
				
				//발신자가 '나'일 때 -> 말풍선 오른쪽에 출력하기
				const myContainer = document.createElement("div");
				myContainer.id="my-container";
				const myMsg = document.createElement("div");
				myMsg.id="my-msg";
				
				myMsg.innerText = msg['msg'];
				myContainer.append(myMsg);
				textContainer.append(myContainer);
				
			} else { //발신자가 '상대방'일 때 -> 말풍선 왼편에 출력하기
				
				const yourContainer = document.createElement("div");
				yourContainer.id="your-container";
				const yourId = document.createElement("div");
				yourId.id="your-id";
				yourId.innerText= msg['sender'];
				yourContainer.append(yourId);
				const yourMsg = document.createElement("div");
				yourMsg.id="your-msg";
				yourMsg.innerText= msg['msg'];
				yourContainer.append(yourMsg);
				textContainer.append(yourContainer);
				
			}
			
		} else if (msg['receiver']==myId) { //'귓속말'발신자로 지정된 경우 -> 왼쪽에 보라색 배경으로 출력. '귓속말'기능
			
			const yourContainer = document.createElement("div");
			yourContainer.id="your-container";
			const yourId = document.creataeElement("div");
			yourId.id="your-id";
			yourId.innerText= msg['sender'];
			yourContainer.append(yourId);
			const yourMsg = document.createElement("div");
			yourMsg.id="your-msg";
			yourMsg.innerText= msg['msg'];
			yourMsg.color=red;
			yourContainer.append(yourMsg);
			textContainer.append(yourContainer);
			
			
		}
		
		
	}
	
</script>

</html>