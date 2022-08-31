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
	.title-container{
		text-align:left;
	}
	
	.jumbotron{
		/* background-image:url("${path}/resources/img/pink.jpg"); */
		background-color:white;
		border: 1px solid red;
		height:300px;
		padding-left:30px;
	}
	#profileImg{
		width:100px;
		height:100px;
	}
	select#catList{
		width:300px;
		float:right;
		margin-right:30px;
		margin-bottom:30px;
	
	}
	
	
</style>

<section>
	<div id="container">

		<div class="jumbotron jumbotron-fluid">
			<div class="container title-container">
				<img id="profileImg" src="${path}/resources/img/icons/person-fill.svg">
				<p class="display-4" style="font-size:30px;font-weight:400;">나의 여행</p>
				<p class="lead">${loginMember.memberId}님의 여행 미리보기</p>
			</div>
		</div>


		<div class="card text-center" style="margin-top:0px;">
			<div class="card-header">
				<ul class="nav nav-tabs card-header-tabs">
					<li class="nav-item"><a class="nav-link active" href="#">나의 장소</a></li>
					<li class="nav-item"><a class="nav-link" href="#">나의 플랜</a></li>
					<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a></li>
				</ul>
			</div>
			
<%-- 			<div class="card-body">
				<h5 class="card-title">나의 장소</h5>
				<p class="card-text">${loginMember.memberId}님이 "좋아요"한 장소들 모아보기</p>
				<a href="#" class="btn btn-primary">Go somewhere</a>
			</div> --%>
			
			<div class="content-body" style="border:1px solid red; margin-bottom:30px;">
				<div class="content-title-container">
					제목이 들어갈 곳
				</div>
				<div class="option-container">
					<select name="likesId" id="catList" class="custom-select">
						<option selected>Open this select menu</option>
						<option value="1">One</option>
						<option value="2">Two</option>
						<option value="3">Three</option>
					</select>
				</div>
			</div>
			
			
		</div>
	</div>
	
	
	
	
	
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>