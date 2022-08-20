<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.admin-container{
		display:flex;
		overflow:hidden;
	}
	.menu-container{
		float:left;
		width:200px;
		background-color:#333333;
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
</style>

<div class="menu-container">

<div class="list-title-container" style="margin-top:100px;">
<p>ADMIN</p>
</div>		
	<ul class="list-group list-group-flush" style="backgroundColor:black;">
		<li class="list-group-item list-item" style="font-size:15px;font-weight:bolder;">회원 관리</li>
		<li class="member-list list-group-item list-item active">전체 회원 목록</li>
		<li class="list-group-item list-item">신고 관리</li>
		<hr>
		<li class="list-group-item list-item" style="font-size:15px;font-weight:bolder;">콘텐츠 관리</li>
		<li class="proposal-list list-group-item list-item">장소 등록</li>
	</ul>
</div>

<script>
	/* 분명 더 좋은 방법이 있는데... */
	const proposal = document.getElementsByClassName("proposal-list")[0];
	const member = document.getElementsByClassName("member-list")[0];
	
	proposal.addEventListener("click",e=>{
		//alert("클릭!");
		member.classList.remove("active");
		e.target.classList.add("active");
	});
	
	member.addEventListener("click",e=>{
		//alert("클릭!");
		proposal.classList.remove("active");
		e.target.classList.add("active");
	});
</script>
