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
    width: 100%;
    height: 100%;
    max-width: 30px;
    max-height: 30px;
    border-radius: 50px;
    border: 1px solid red;
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
</html>