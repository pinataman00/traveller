<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<style>
.footer-title {
	cursor: pointer;
	font-size: 13px;
	color:gray;
}
.footer-container{
	text-align:center;
	margin-top:10px;
	margin-bottom:10px;
}
.footer-main-container {
	margin-top: 30px;
	background-color: #f8f9fa;
	height: 100px;
	padding-top: 30px;
}
</style>

<footer class="footer-main-container navbar-fixed-bottom">
	<div class="footer-container container container-fluid">
		<p class="footer-title" onclick="location.assign('${path}/member/aboutTraveller');">ABOUT TRAVELLER <br>서비스 소개</p>	
	</div>
</footer>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>