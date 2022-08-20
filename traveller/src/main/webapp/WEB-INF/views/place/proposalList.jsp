<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>
 	.admin-container{

		display:flex;
		overflow:hidden;
		height:100vh;
	}
	.menu-container{
		float:left;
		width:200px;
		background-color:#333333;
	}
	.contents-container{
		margin-top: 100px;
		float:right;
		width:100%;
		margin-right:-200px;
		padding-right:200px;
		height:100vh;
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
	
 		<div class="list-title-container" style="margin-top:100px;">
			<p>ADMIN</p>
		</div>		
			<ul class="list-group list-group-flush" style="backgroundColor:black;">
				<li class="list-group-item list-item" style="font-size:15px;font-weight:bolder;">회원 관리</li>
				<li class="list-group-item list-item">전체 회원 목록</li>
				<li class="list-group-item list-item">신고 관리</li>
				<hr>
				<li class="list-group-item list-item" style="font-size:15px;font-weight:bolder;">콘텐츠 관리</li>
				<li class="list-group-item list-item active">장소 등록</li>
			</ul>
		</div>
	<div class="contents-container">

			<div class="content-title-container">
				<h5 style="font-weight:bolder;">장소 제안 목록</h5>
				<p>새로운 장소 등록 제안을 확인해보세요</p>
			</div>

			<div class="list-container">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">제안코드</th>
							<th scope="col">회원ID</th>
							<th scope="col">장소명</th>
							<th scope="col">지역분류</th>
							<th scope="col">테마</th>							
							<th scope="col">등록일</th>
							<th scope="col">수리/반려</th>					
							<th scope="col">삭제하기</th>					
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty list}">
							<c:forEach var="p" items="${list}">
								<c:set var="i" value="${i+1}"/>
								<tr>
									<td>${i }</td>
									<td>${p.proposalId }</td>
									<td>${p.memberId }</td>
									<td onclick="location.assign('${path }/place/proposalView/${p.proposalId}')">${p.title }</td>
									<td>
									<c:choose>										
										<c:when test="${p.areaCode=='1'}">서울</c:when>
										<c:when test="${p.areaCode=='2'}">인천</c:when>
										<c:when test="${p.areaCode=='3'}">대전</c:when>
										<c:when test="${p.areaCode=='4'}">대구</c:when>
										<c:when test="${p.areaCode=='5'}">광주</c:when>
										<c:when test="${p.areaCode=='6'}">부산</c:when>
										<c:when test="${p.areaCode=='7'}">울산</c:when>
										<c:when test="${p.areaCode=='8'}">세종</c:when>
										<c:when test="${p.areaCode=='31'}">경기</c:when>
										<c:when test="${p.areaCode=='32'}">강원</c:when>
										<c:when test="${p.areaCode=='33'}">충북</c:when>
										<c:when test="${p.areaCode=='34'}">충남</c:when>
										<c:when test="${p.areaCode=='35'}">경북</c:when>
										<c:when test="${p.areaCode=='36'}">경남</c:when>
										<c:when test="${p.areaCode=='37'}">전북</c:when>
										<c:when test="${p.areaCode=='38'}">전남</c:when>
										<c:when test="${p.areaCode=='39'}">제주</c:when>																			
									</c:choose>
									</td>	
									<td>
									<c:choose>
										<c:when test="${p.cat2=='A0101'}">자연 관광지</c:when>
										<c:when test="${p.cat2=='A0102'}">관광 자원</c:when>
										<c:when test="${p.cat2=='A0201'}">역사</c:when>
										<c:when test="${p.cat2=='A0202'}">휴양</c:when>
										<c:when test="${p.cat2=='A0203'}">체험</c:when>
										<c:when test="${p.cat2=='A0204'}">산업</c:when>
										<c:when test="${p.cat2=='A0205'}">건축/조형</c:when>
										<c:when test="${p.cat2=='A0206'}">문화시설</c:when>
										<c:when test="${p.cat2=='A0207'}">축제</c:when>
										<c:when test="${p.cat2=='A0208'}">공연/행사</c:when>
										<c:when test="${p.cat2=='C0112'}">가족</c:when>
										<c:when test="${p.cat2=='C0113'}">나홀로</c:when>
										<c:when test="${p.cat2=='C0114'}">힐링</c:when>
										<c:when test="${p.cat2=='C0115'}">도보</c:when>
										<c:when test="${p.cat2=='C0116'}">캠핑</c:when>
										<c:when test="${p.cat2=='C0117'}">맛</c:when>
										<c:when test="${p.cat2=='A0301'}">일반</c:when>
										<c:when test="${p.cat2=='A0302'}">육상</c:when>
										<c:when test="${p.cat2=='A0303'}">수상</c:when>
										<c:when test="${p.cat2=='A0304'}">항공</c:when>
										<c:when test="${p.cat2=='A0305'}">복합</c:when>
										<c:when test="${p.cat2=='A0401'}">쇼핑하기</c:when>
										<c:when test="${p.cat2=='A0502'}">먹기</c:when>
										<c:when test="${p.cat2=='free'}">자유여행</c:when>
									</c:choose>
									</td>
									
									
									<td>${p.uploadDate }</td>
									<td data-toggle="modal" data-target="#approval" onclick="getInfo('${p.proposalId}','${p.title}','${p.approval }');">${p.approval}</td>																
									<td data-toggle="modal" data-target="#delete" onclick="getInfo2('${p.proposalId}','${p.title}');"><img id="msgImg" src="${path}/resources/img/icons/trash.svg" alt="msgImg"></td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty list }">
							<td colspan="9">장소 제안이 존재하지 않습니다</td>
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


<!-- 제안 수리/반려 처리 -->
<div class="modal fade" id="approval" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">수리/반려 처리</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="" method="post" onsubmit="return fn_enrollValidate()">
      <div class="modal-body">
      		<input class="form-control" type="text" name="title" id="title_1" readonly>
			<input type="hidden" id="proposalId_1" name="proposalId">
			<input type="hidden" id="approval_">
			<br> 
			<p>제안을 승인하시겠습니까?</p>
	  </div>
      <div class="modal-footer">
		<input type="submit" class="btn btn-danger" value="처리하기">
		<button type="button" class="btn btn-primary" data-dismiss="modal">취소하기</button>
      </div>
      </form>
    </div>
  </div>
</div>


<!-- 제안 삭제 처리 -->
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">제안 삭제하기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form action="" method="post">
      <div class="modal-body">
      		<input class="form-control" type="text" name="title" id="title_2" readonly>
			<input type="hidden" id="proposalId_2" name="proposalId">
			<br> 
			<p>제안을 삭제할까요?</p>
	  </div>
      <div class="modal-footer">
		<input type="submit" class="btn btn-danger" value="삭제하기">
		<button type="button" class="btn btn-primary" data-dismiss="modal">취소하기</button>
      </div>
      </form>
    </div>
  </div>
</div>


<script>


	//제안 수리하기 > 제안ID, 제안 장소명, 승인 여부 받아오기	
	const getInfo = (id, title, approval)=>{
		
		document.getElementById("proposalId_1").value=id;		
		document.getElementById("title_1").value=title;
		document.getElementById("approval_").value=approval;
	
	}
	
	//삭제하기 > 제안ID 받아오기	
	const getInfo2 = (id, title)=>{
		
		document.getElementById("proposalId_2").value=id;		
		document.getElementById("title_2").value=title;
	
	}
	
	//유효성 체크 > 이미 승인된 제안은 재승인할 수 없음
	const fn_enrollValidate = ()=>{
		
		const flag = document.getElementById("approval_").value;
		if(flag=='Y'){
			alert("이미 승인된 제안입니다");
			return false;
		}
	}
	
	
	
</script>

</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

