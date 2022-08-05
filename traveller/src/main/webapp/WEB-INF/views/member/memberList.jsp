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
		height:800px;
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
	
	.member-search-container{
		display: flex;
	    text-align: center;
	    justify-content: center;
	    margin-bottom: 20px;
	    margin-top: 30px;
	}
	
	input#searchBox{
	    width: 200px;
	    padding-left: 12px;
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
							<th scope="col">관심지역1</th>
							<th scope="col">관심지역2</th>
							<th scope="col">가입일</th>
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
									<td data-toggle="modal" data-target="#updateGrade" onclick="getInfo('${m.memberId}','${m.grade }');">${m.grade }</td>
									<td>${m.introduce }</td>
									<td>${m.areaCode }</td>
									<td>${m.sigunguCode }</td>
									<td>${m.enrollDate }</td>
									<td><img id="msgImg" src="${path}/resources/img/icons/msg.svg" alt="msgImg"></td>
									<td data-toggle="modal" data-target="#deleteMember" onclick="getId('${m.memberId}');"><img id="msgImg" src="${path}/resources/img/icons/person-x.svg" alt="msgImg"></td>								
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty list }">
							<td colspan="11">회원이 존재하지 않습니다</td>
						</c:if>
					</tbody>
				</table>
				<div>
					<form class="member-search-container">
						<input id="searchBox" class="form-control" type="text" placeholder="아이디">
						<input type="submit" class="btn btn-primary" value="검색">
					</form>
				</div>
				<div id="pageBar">
					${pageBar }
				</div>
			</div>
		</div>
</div>

<!-- 회원 등급 조정 -->
<div class="modal fade" id="updateGrade" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">회원 등급 수정하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="${path}/member/updateGrade.do" method="post">
      <div class="modal-body">
			<input class="form-control" type="text" name="memberId" id="memberId_" readonly>
			<br> 
			<select class="custom-select custom-select-sm" name="grade" id="grade_">				
				<option value="normal">normal</option>
				<option value="planner">planner</option>
				<option value="manager">manager</option>			
			</select>
	  </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input value="변경하기" type="submit" class="btn btn-primary">
      </div>
      </form>
    </div>
  </div>
</div>

<!-- 회원 탈퇴 처리 -->
<div class="modal fade" id="deleteMember" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">회원 탈퇴 처리</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="${path}/member/deleteMemberByAdmin.do" method="post">
      <div class="modal-body">
			<input class="form-control" type="text" name="memberId" id="memberId_2" readonly>
			<br> 
			<p>회원의 탈퇴 처리를 원하십니까?</p>
	  </div>
      <div class="modal-footer">
		<input type="submit" class="btn btn-danger" value="탈퇴처리">
		<button type="button" class="btn btn-primary" data-dismiss="modal">취소하기</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script>

	const getInfo = (id,grade)=>{

		document.getElementById("memberId_").value=id;
		
		const opt = document.querySelectorAll("#grade_ option");
		for(let i=0;i<opt.length;i++){
			if(opt[i].value==grade){
				opt[i].selected="true";
			}
		}
	}
	
	const getId = (id)=>{
		console.log(id);
		document.getElementById("memberId_2").value=id;		
	}
</script>

</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

