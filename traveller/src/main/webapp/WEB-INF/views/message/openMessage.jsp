<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<style>
section.container {
	margin-top: 100px;
	display: grid;
}

.container div {
/* 	border: 1px solid red; */
}

.message-title-container h4 {
	float: left;
	margin-bottom:15px;
}

.message-list-container {
/* 	border: 1px solid red; */
	display: grid;
	justify-content: center;
}

.message-list-container div {
/* 	border: 1px solid red; */
}

.message-content {
	width: 500px;
	display: inline-block;
	margin: 20px;
}

.searchBtn {
	float: right;
	margin:10px;
}

img.profileImg {
	margin: 20px;
	width: 100%;
	height: 100%;
	max-width: 50px;
	max-height: 50px;
	border-radius: 50px;
/* 	border: 1px solid red; */
}

.member-container {
	display: flex;
	align-items: center;
}

.member-img-container {
	width: 100px;
	height: 100px;
/* 	border: 1px solid red; */
}

.msgMember {
	text-align: left;
	height: 50px;
	width: 400px;
}

.msgData {
	text-align: left;
	height: 50px;
	width: 400px;
}
.msg-container{
	display:flex;
	
	width: 552px;
    height: 163px;
}
.msg-info-container{
	margin-left: 18px;
}
.msg-btn-container{
	float:right;
}
.card{
	margin-top:10px;
	margin-bottom:10px;
}
</style>
<section class="container">	
	<div class="message-title-container">
		<h4>MESSAGE 메시지</h4>	
	</div>
	<div class="message-menu-container">
		<div>
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link" href="#">메시지 목록</a></li>
				<li class="nav-item"><a class="nav-link" href="#">차단한 이용자</a></li>
			</ul>
			<button type="button" class="btn btn-primary btn-sm searchBtn" data-toggle="modal" data-target="#searchFriends">시작하기</button>
		</div>
	</div>
</section>


<!-- '시작하기'버튼 클릭 Modal -->
<div class="modal fade" id="searchFriends" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">1:1 메시지 시작하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>메시지를 주고받을 친구를 찾아보세요</p>
			<div class="input-group input-group-sm mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup-sizing-sm">ID</span>
				</div>
					<input type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm">
					<button type="button" class="btn btn-primary btn-sm" onclick="findId();">검색</button>
			</div>
			
				<div class="search-res-container">
					<span class="guide ok">"시작하기" 버튼을 눌러보세요!</span> 
					<span class="guide error">존재하지 않는 회원입니다</span>
				</div>

			</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Save changes</button>
	      </div>
    </div>
  </div>
</div>




<div class="message-list-container">

<div class="card">
  <div class="card-body msg-container">
    <div class="member-img-container">
		<img id="basicImg" class="profileImg" src="${path}/resources/img/icons/person-fill.svg" alt="profileImg">
  	</div>
  	<div class="msg-info-container">
	    <h5 class="card-title">Card title</h5>
	    <h6 class="card-subtitle mb-2 text-muted">채팅방 생성 날짜</h6>
	    <p class="card-text">가장 최근 메시지</p>
 	    <div class="msg-btn-container">
		    <a href="#" class="card-link">입장하기</a>
		    <a href="#" class="card-link">방 삭제하기</a>
	    </div>	    
    </div>
  </div>
</div>
<div class="card">
  <div class="card-body msg-container">
    <div class="member-img-container">
		<img id="basicImg" class="profileImg" src="${path}/resources/img/icons/person-fill.svg" alt="profileImg">
  	</div>
  	<div class="msg-info-container">
	    <h5 class="card-title">Card title</h5>
	    <h6 class="card-subtitle mb-2 text-muted">채팅방 생성 날짜</h6>
	    <p class="card-text">가장 최근 메시지</p>
 	    <div class="msg-btn-container">
		    <a href="#" class="card-link">입장하기</a>
		    <a href="#" class="card-link">방 삭제하기</a>
	    </div>	    
    </div>
  </div>
</div>



</div>

<script>
	
	//메시지 시작하기 > 친구 찾기
	const findId = ()=>{
		
		
		
	}
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>