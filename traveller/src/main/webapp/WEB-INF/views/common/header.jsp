<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>



<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>traveller</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css2?family=Work+Sans&display=swap" rel="stylesheet">
<!-- bootstrap css -->
<link rel="stylesheet" href="${path }/resources/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/headerStyle.css"/>
<%-- <script src="${path}/resources/js/bootstrap.js"></script> --%>
<script src="${path}/resources/js/jquery-3.6.0.min.js"></script>

</head>

<body>

<%-- <div class="container-fluid" onclick="location.replace('${path}/')">
  <h2 style="font-family:Work+Sans;text-align:center;padding:10px">traveⅡer</h2>
</div> --%>

<nav class="navbar fixed-top navbar-expand-lg navbar-light bg-light">

  <!-- <a class="navbar-brand" href="#">traveⅡer</a> -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
       <li class="nav-item">
        	<div class="container-fluid" onclick="location.replace('${path}/')">
  		<h5 style="font-family:Work+Sans;text-align:center;padding:10px">traveⅡer</h5>
	</div>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-toggle="tooltip" data-placement="bottom" title="여행지를 검색해보세요" href="${path}/place/placesMain" style="margin-top:4px;">여행지</a>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
         data-toggle="tooltip" data-placement="bottom" title="여행의 시작은 계획!" style="margin-top:4px;">
          플래너
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${path }/planner/startPlanner">플래너 만들기</a>
          <a class="dropdown-item" href="#">크리에이터 구경하기</a>
<!--           <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a> -->
        </div>
      </li>
      
      <c:if test="${loginMember.memberId=='admin08'}">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top:4px;">
          관리자
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true" style="color:gray;margin-left:5px;">회원 관리</a>
          <a class="dropdown-item" href="${path }/member/memberList.do">회원 조회</a>
          <div class="dropdown-divider"></div>
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true" style="color:gray;margin-left:5px;">콘텐츠 관리</a>
          <a class="dropdown-item" href="${path }/place/proposalList.do">장소 등록</a>
          <!-- <a class="dropdown-item" href="#">Something else here</a> -->
        </div>
      </li>
      </c:if>
      
      
      
      
<!--       <li class="nav-item">
        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">관리자</a>
      </li> -->
    </ul>
    
    <c:if test="${loginMember==null}">
	    <div class="form-inline my-2 my-lg-0" style="margin:10px"> 
	      <button class="btn btn-outline-primary btn-sm my-2 my-sm-0" type="submit"
	      data-toggle="modal" data-target="#loginBox">
	          로그인
	      </button>
	    </div>
	      <button class="btn btn-outline-primary btn-sm my-2 my-sm-0" type="submit" onclick="location.assign('${path}/member/enrollMember.do')">회원가입</button>
     </c:if>
     <c:if test="${loginMember!=null }">
     
     	<!-- TODO : 메시지, 알림이 있을 때, 아이콘 분기 처리해야 함 -->
        <img src="${path}/resources/img/icons/msg.svg" alt="msg" style="width:25px;height:25px; margin-right:10px;">
        <img src="${path}/resources/img/icons/bell.svg" alt="alarm" style="width:25px;height:25px; margin-right:10px;">
     	<span>

				<div class="dropdown" style="margin-right:10px;">
				  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    ${loginMember.memberId}
				  </button>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenu2">
				    <button class="dropdown-item" type="button" onclick="location.assign('${path}/member/myInfo.do')">정보 수정</button>
				    <button class="dropdown-item" type="button" onclick="location.assign('${path}/message/openMessageMain.do')">메시지</button>
				    <button class="dropdown-item" type="button">알림</button>
				    <button class="dropdown-item" type="button" onclick="location.assign('${path}/member/myTrip.do')">나의 여행</button>
				    <div class="dropdown-divider"></div>
				    <button class="dropdown-item" type="button" onclick="location.replace('${path}/member/logout.do')">로그아웃</button>
				    
				  </div>
				</div>

				</span>
     	<%-- <button class="btn btn-outline-primary btn-sm my-2 my-sm-0" type="submit" onclick="location.replace('${path}/member/logout.do')">로그아웃</button> --%>
     </c:if>
      
  </div>
  
  
</nav>

<!-- 모달 : 로그인 기능 -->
<div class="modal fade" id="loginBox" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">로그인</h5>
         
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        	
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <p>(관리자 계정 : admin08 | 비밀번호 : 1q2w3e4r)</p>
      		<div style="text-align:center;margin:10px;">
		        <form action="${path }/member/memberLogin.do" method="post">
		        		<input style="margin-bottom:10px;"type="text" name="memberId" placeholder="아이디"><br/>
		        		<input type="password" name="memberPwd" placeholder="비밀번호"><br/>
		        		<input style="margin-left:120px;margin-top:10px;" class="btn btn-primary" type="submit" value="로그인">
		        </form>
	        <div>
	        	<a href="#">아이디 찾기</a>
	        	<a href="#">비밀번호 찾기</a>
	        </div>
	        </div>
      </div>

    </div>
  </div>
</div>




