<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>API 테스트</title>
</head>
<body>

	<div class="text-container">
		테스트		
	</div>

<script>

	//const id = 126508;
	
/* 	function getId(){
		return ${126508};
	}
	console.log(getId()); */
	//공공 api
/* 	const url = "https://apis.data.go.kr/B551011/KorService/detailCommon?MobileOS=ETC&MobileApp=traveller&serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D&_type=json&contentId=126508&defaultYN=y&firstImageYN=y&areacodeYN=y&catcodeYN=y&addrinfoYN=y&mapinfoYN=y&overviewYN=y";
	
	
	fetch(url)
		.then(res=>console.log(res)); */
		
	const url = "https://apis.data.go.kr/B551011/KorService/detailCommon?serviceKey=elB%2BRI1Qb32rIFvCv63J%2FI7Tc7CNydheC6%2BgTHJNP3TAiREJhR6WkEu5GXN8OGWj9Fcwzdvw7z72B6hQRKHdGw%3D%3D&MobileOS=ETC&MobileApp=AppTest&_type=json&contentId=126508&contentTypeId=12&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y";
	//fetch(url).then(res=>console.log(res));
	fetch(url)
	.then(res=>res.json())
	.then(myJson=>{
		console.log(myJson);
		const obj = myJson.response.body.items.item[0]; //개별 아이템 가져오기
		//obj.overview
		console.log(obj);
		
		document.getElementsByClassName("text-container")[0].innerHTML = obj.overview;
		
	})

</script>

</body>
</html>