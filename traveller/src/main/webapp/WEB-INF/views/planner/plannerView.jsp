<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc"></script>
<style>

 div.main-container{
 	margin-top : 100px;
 	border: 1px solid red;
 }
 .container div{
 	border: 1px solid blue;
 }
 .plan-content-container{
 	display:flex;
 }	
.plan-list-container{
	width:30%;
	height:500px;
}
.map-container{
	width:70%;
	height:500px;
}
.basic-info-container p{
	text-align:left;
}

</style>
<section class="container">
	<div class="container-fluid main-container">
		<div class="basic-info-container">
			<p id="plannerTitle">내가 작성한 플래너</p>
			<p id="summary">플래너 설명</p>
		</div>

		<div class="plan-content-container">
			<div class="plan-list-container">

				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<label class="input-group-text" for="inputGroupSelect01">여행일자</label>
					</div>
					<select class="custom-select" id="inputGroupSelect01">
						<option selected disable>-- 선택 --</option>
					</select>
				</div>

				<!-- plan이 리스트로 들어감 -->
			</div>
			<div class="map-container">
				<!-- 지도가 들어가는 영역 -->
			</div>
		</div>
		<div class="controller-container" style="display:flex;float:right;">

			<div class="btn-container">
				<button type="button" class="btn btn-outline-primary btn-sm">다운받기</button>
				<button type="button" class="btn btn-outline-primary btn-sm">수정하기</button>
			</div>
		</div>	
	
	</div>
	

</section>
<script>
	
	const plannerNo = "${plannerNo}";
	
	console.log("plannerNo : ",plannerNo);
	
	fetch('${path}/planner/plannerDetail',{
		method:'POST',
		headers:{
			'Content-Type':'application/json',
		},
		body:JSON.stringify({"plannerNo":plannerNo}),
	})
	.then((response)=>response.json())
	.then((data)=>{
		
		console.log("데이터 가져왔니 ? ", data);
		
		//※ PLANNER, title, summary, theme정보는 가지고 와야 함...
		
		
	});
	
	
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>