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
<link rel="stylesheet" type="text/css" href="${path }/resources/css/mapStyle.css"/>
<link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@1,800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<%-- <script src="${path}/resources/js/bootstrap.js"></script> --%>
<script src="${path}/resources/js/jquery-3.6.0.min.js"></script>

	<!-- 지도 관련 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=LIBRARY"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69ad1295dea4b05c5c134dce63cc80fc&libraries=services,clusterer,drawing"></script>

</head>

<body>
<style>
	.main-container{
		border:1px solid red;
		/* margin-top : 50px; */
		display:flex;
		overflow:hidden;
		height:100vh;
	}
	.editor-container{
		float:left;
		border: 1px solid blue;
		width: 300px;
		background-color: #E6F0F8;
		padding:10px;
		text-align:center;
	}
	.map-container{
		float:right;
		border:1px solid red;
		width:100%;
		margin-right:-300px;
		padding-right:300px;
	}
	div.title-container{
		margin:10px;
		margin-top:10px;
		text-align:left;
	}
	
	.planner-container{
		border:1px solid red;
		height: 75vh;
		overflow-y:scroll;
	}
	.planner-container::-webkit-scrollbar{
		display:none;
	}
	.btn-container{
		margin-top:15px;
	}
	div#dropZone{
		border:1px solid blue;
		margin-top: 10px;
	}
	.btn-controller{
		/* position:absolute; */
		left:10px;
		display:flex;
		padding:10px;
		background-color: rgba( 255, 255, 255, 0.5 );
	}
	.btn-controller button{
		margin:2px;
	}
	#myLikes{
		height: 600px;
	}
</style>

<section>

<%-- 	${tempPlanner.plannerTitle}
	${tempCrew.crewTitle} --%>
	<div class="main-container">
		<div class="editor-container">
			<div class="title-container">
				${tempPlanner.plannerTitle}
				플래너 제목
			</div>
			<div class="planner-container">
					<div class="daysOpt input-group mb-3">
						  <div class="input-group-prepend">
						    <label class="input-group-text" for="inputGroupSelect01">여행일자</label>
						  </div>
						  <select class="custom-select" id="inputGroupSelect01">
						    <option selected>Choose...</option>
						    <option value="1">One</option>
						    <option value="2">Two</option>
						    <option value="3">Three</option>
						  </select>
					</div>
				
					<div id="dropZone">
						<!-- 드래그 앤 드롭 카드가 배치될 영역 -->
					</div>
			 </div>
				<div class="btn-container">
					<button class="btn btn-primary" type="button">작성 완료</button>
					<button class="btn btn-primary" type="button">작성 취소</button>
				</div>
			</div>
		<!-- 지도 영역 -->	
		<div id="map" class="map-container">
		</div>
		
		
		
		
		
		
		
		
		
		
		
		    <div id="menu_wrap" class="bg_white">
		        <div class="option">
		            <div>
		            	<h1 id="listTitle" style="text-align:left;padding:10px;margin-bottom:0px;margin-left:5px;font-family:Rubik;">SEARCH!</h1>
		                <form onsubmit="searchPlaces(); return false;" id="searchBox">
		                    	<input type="text" value="" id="keyword" size="40" placeholder="검색어를 입력하세요"> 
		                    	<button id="searchBtn" type="submit">검색하기</button> 
		                </form>
		            </div>
		        </div>
		        <hr id="listLine">
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>  
    		</div>
		
		
		
		
		
		
		
		
		
		

		<!-- 지도 관련 컨트롤러 -->
		<div class="btn-controller" style="left:10px;">
			<button id="searchListBtn" class="btn btn-primary btn-sm" type="button" onclick="showList();">검색하기</button>
			<button tyle="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">나의 도구들</button>
		
				<!-- dropdown : 사용자 아이템 드롭다운 -->
			  <div class="dropdown-menu">
			    <a class="dropdown-item" href="#">나의 좋아요</a>
			    <a class="dropdown-item" href="#">나의 그룹</a>
			    <a class="dropdown-item" href="#">나의 체크 리스트</a>
			    <div class="dropdown-divider"></div>
			    <a class="dropdown-item" href="#">날씨</a>
			    <a class="dropdown-item" href="#">길 찾기</a>
			  </div>

		</div>
		
		
	</div>
	

  
<!-- Modal : 좋아요 -->
<div class="modal fade" id="myLikes" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">나의 좋아요</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        "좋아요"를 클릭했던 장소들
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>





	
</section>


	<script>
	
		//● "사용자 편의 콘테이너" 기능 관련 함수들
		const showList = (()=>{ //"검색하기" 버튼 클릭 時, "검색 리스트"가 보이거나, 보이지 않도록 구현함
	
		const searchList = document.getElementById("menu_wrap");
	
	 	let cnt = 1;
		return()=>{
			
			if(++cnt%2!=0){
				searchList.style.display="";
			} else {
				searchList.style.display="none";
			}
			
		}
		
		})();
	
	
		//● "지도" 기능 관련 함수들
		//1. 지도 출력 -----------------------------------------------------------------------------------------
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		//2. 지도에 컨트롤러 올리기 ---------------------------------------------------------------------------------
		const btnController = document.getElementsByClassName("btn-controller");
		map.addControl(btnController[0], kakao.maps.ControlPosition.TOPLEFT);
		
		//3. 클릭 시, 해당 위치에 마커 꽂기 ---------------------------------------------------------------------------
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    //alert("위도 "+latlng.getLat()+" "+"경도 "+latlng.getLng());
		    
		});
		
		
		//4. 마커 및 검색 기능 ----------------------------------------------------------------------------------------
		// 마커를 담을 배열입니다
		var markers = [];
		
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();  
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		// 키워드로 장소를 검색합니다
		searchPlaces();
		
		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {
		
		    var keyword = document.getElementById('keyword').value;
		
		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		
		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);
		
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);
		
		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		
		        alert('검색 결과가 존재하지 않습니다.');
		        return;
		
		    } else if (status === kakao.maps.services.Status.ERROR) {
		
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
		
		    }
		}
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
		
		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);
		
		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);
		
		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });
		
		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
		
		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };
		
		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
		
		        fragment.appendChild(itemEl);
		    }
		
		    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
		
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
		
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
		
		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';
		
		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           
		
		    el.innerHTML = itemStr;
		    el.className = 'item';
		
		    return el;
		}
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });
		
		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
		
		    return marker;
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 
		
		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }
		
		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;
		
		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }
		
		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}
		
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
		
		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}
		
		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
		
		//0. 테스트 : 지도 상 마커 생성과 polyline 그리기 -----------------------------------------------------------------------
		//기능 내용 : 지도 위 특정 지점 클릭 시, 마커가 생성되고 마커 간에 선이 그어진다. 
		var path =  []; 
		var clickLine = new kakao.maps.Polyline({
		    map: map,
		    strokeWeight: 3, // 선의 두께입니다
		    strokeColor: '#db4040', // 선의 색깔입니다
		    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid' // 선의 스타일입니다
		});
		
		// 지도에 클릭 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    // 마우스로 클릭한 위치입니다
		    var clickPosition = mouseEvent.latLng;
		    path.push(clickPosition);
		});
		
		setInterval(function() {
		    clickLine.setPath(path);
		}, 1000);
		
		//-------------------------------------------------------------------------------------------------------------------
		
	</script>

	
	
	
<%@ include file="/WEB-INF/views/common/footer.jsp"%>