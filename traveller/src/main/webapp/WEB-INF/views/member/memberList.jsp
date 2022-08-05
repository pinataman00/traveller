<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
	.admin-container{
		border:1px solid red;
		margin-top : 70px;
		display:flex;
		overflow:hidden;
		height:500px;
	}
	.menu-container{
		float:left;
		border:1px solid blue;
		width:200px;
		background-color:#333333;
	}
	.contents-container{
		float:right;
		border:1px solid orange;	
		width:100%;
		margin-right:-200px;
		padding-right:200px;
	}
	.list-container{
		padding-right:50px;
		padding-left:50px;
		padding-top:20px;
		text-align:center;
	}
	.content-title-container{
		margin-top:30px;
		margin-left: 50px;
	}
	.list-title-container{
		margin-top:30px;
		margin-left: 10px;
	}
	.list-item{
		/* color:white; */
		background-color:#333333;
		color:white;
		font-size:13px;
	}
	.list-title-container{
		color:white;
		margin-left : 15px;
	}
	#msgImg{
		text-align:center;
	}
</style>

<section>
<div class="admin-container">

	<div class="menu-container">
	
		<div class="list-title-container">
			<p>ADMIN</p>
		</div>		
			<ul class="list-group list-group-flush" style="backgroundColor:black;">
				<li class="list-group-item list-item" style="font-size:15px;font-weight:bolder;">회원 관리</li>
				<li class="list-group-item list-item active">전체 회원 목록</li>
				<li class="list-group-item list-item">신고 관리</li>
				<hr>
				<li class="list-group-item list-item" style="font-size:15px;font-weight:bolder;">콘텐츠 관리</li>
				<li class="list-group-item list-item">장소 등록</li>
			</ul>
		</div>
	
	<div class="contents-container">

			<div class="content-title-container">
				<h5 style="font-weight:bolder;">전체 회원 목록</h5>
				<p> 사이트에 가입한 회원의 전체 목록을 확인해보세요</p>
			</div>

			<div class="list-container">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">ID</th>
							<th scope="col">EMAIL</th>
							<th scope="col">PHONE</th>
							<th scope="col">GRADE</th>
							<th scope="col">INTRODUCE</th>
							<th scope="col">관심지역 1</th>
							<th scope="col">관심지역 2</th>
							<th scope="col">ENROLL DATE</th>
							<th scope="col">MESSAGE</th>
							<th scope="col">탈퇴처리</th>							
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty list}">
							<c:forEach var="m" items="${list}">
								<c:set var="i" value="${i+1}"/>
								<tr>
									<td>${i }</td>
									<td>${m.memberId }</td>
									<td>${m.email }</td>
									<td>${m.phone }</td>
									<td>${m.grade }</td>
									<td>${m.introduce }</td>
									<td>${m.areaCode }</td>
									<td>${m.sigunguCode }</td>
									<td>${m.enrollDate }</td>
									<td><img id="msgImg" src="${path}/resources/img/icons/msg.svg" alt="msgImg"></td>
									<td><img id="msgImg" src="${path}/resources/img/icons/person-x.svg" alt="msgImg"></td>								
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty list }">
							<td colspan="11">회원이 존재하지 않습니다</td>
						</c:if>
					</tbody>
				</table>
				<div id="pageBar">
					${pageBar }
				</div>
			</div>



		</div>

</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

