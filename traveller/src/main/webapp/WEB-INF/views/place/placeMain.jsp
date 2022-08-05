<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
	
	.container{
		margin-top:80px;
		border:1px solid red;
	}
	.container div{
		border: 1px solid blue;
	}
	.search-container{
	    justify-content: center;
	    display: flex;
	    margin-top : 50px;
	    margin-bottom: 30px;
	}
	.main-title-container{
		margin-top : 50px;
	}
	.btn-container{
		margin:20px;
	}
	
</style>

	<section>
		<div class="container">
			<div class="main-title-container">
				<h3>여행지 탐색하기</h3>
				<p>직접 검색하거나, 버튼을 클릭해 멋진 장소를 추천받아 보세요!</p>
			</div>
			<div class="search-container">
				<form class="form-inline my-2 my-lg-0">
					<input class="form-control mr-sm-2" style="width:444px;" type="search" placeholder="Search" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
				</form>
			</div>
			
			<div class="theme-search-container">
				<p style="float:left">테마별 추천 여행지</p>
				<br>
				<div class="btn-container">
					<button type="button" class="btn btn-outline-info">자연</button>
					<button type="button" class="btn btn-outline-info">인문</button>
					<button type="button" class="btn btn-outline-info">추천코스</button>
					<button type="button" class="btn btn-outline-info">레포츠</button>
					<button type="button" class="btn btn-outline-info">숙박</button>
					<button type="button" class="btn btn-outline-info">쇼핑</button>
					<button type="button" class="btn btn-outline-info">음식</button>
				</div>
				
			</div>
			<div class="area-search-container">
				<p>지역별 추천 여행지</p>				
			</div>
	</div>
	</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>
