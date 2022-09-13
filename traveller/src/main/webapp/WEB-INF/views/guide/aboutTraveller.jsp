<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

<style>

	.container{
		margin-top:100px;
	}
	.guide-main-title{
		/* text-align: center; */
		font-weight:800;
	}
	.sub-title{
		/* text-align: center; */
		font-weight:100;
	}
	.guide-contents p{
		font-weight:100;
		margin-bottom:3px;
		font-size:15px;
	}
	.mini-title{
		font-weight:600;
		margin-top: 15px;
		margin-bottom:5px;
	}
	.guide-text p{
		font-weight:100;
		font-size:13px;
	}
</style>
<section>
	<div class="container">
		<h3 class="guide-main-title">traveller를 소개합니다</h3>
		<div class="guide-content-container">
			<p class="sub-title">국내 여행 정보, 여행 계획 편집 툴 제공 사이트</p>
			<hr>
			<div class="guide-contents">			
			<p>여행은 손 끝에서 시작합니다. <br> 원하는 방문 장소를 검색하고, 찾아갈 장소와 장소를 별자리처럼 엮어 <br> 한 벌의 계획을 만들죠</p>
			<br>
			<p>traveller는 한국관광공사가 제공하는 자료를 토대로 지역별/주제별 여행 정보를 제공합니다</p>			
			<p>마음에 드는 장소를 찾고, 마음 맞는 친구들과 함께 여행 계획을 세워보세요!</p>			
			<p>직접 계획하는 일이 어렵다면? 여행 전문가에게 계획을 맡겨보는 것도 좋죠!</p>			
			<p>손 끝에서 시작하는 여행, traveller와 함께 시작해볼까요?</p>
			</div>			
		</div>
		<hr>
		<h5 class="guide-main-title">사용설명서</h5>
		
		<p class="mini-title">회원가입 안내</p>
		<div class="guide-text">
			<p>상단의 "회원가입" 버튼을 통해 관련 페이지로 이동 후, 간단한 정보를 기입함으로써 빠른 회원가입이 가능합니다
			<br>가입 즉시 모든 서비스를 무료로 이용하실 수 있습니다
			<br>오직 회원만이, <span style="text-decoration:underline">"좋아요"와 "플래너 편집 에디터" 기능</span>을 사용할 수 있습니다
			</p>
		</div>
		
		<br>
		<p class="mini-title">마이 페이지</p>
		<div class="guide-text">
			<p>로그인 후, 우측 상단의 버튼을 눌러보세요. 버튼에는 회원 님의 아이디가 새겨져 있어요
			<br><span style="font-weight:600;">나의 정보</span> 버튼을 통해, 비밀번호 포함 나의 정보를 수정할 수 있어요
			<br><span style="font-weight:600;">나의 여행</span> 버튼을 통해서는
			<br><span style="font-weight:600;">좋아요</span>목록에 추가했던, 내 맘에 쏙 들었던 장소들 모두를, 
			<br>그리고 내가 만들었던 <span style="font-weight:600;">플래너</span>들을 열람할 수 있어요</p>
		</div>
		
		<br>
		<p class="mini-title">여행지 검색하기</p>
		<div class="guide-text">
			<p>상단의 "여행지" 메뉴를 클릭하시면, <span style="font-weight:600;">한국관광공사</span>가 제공하는 여행지 관련 정보를 검색하실 수 있습니다
			<br>"키워드", "지역별", "테마별"
			<br>총 3가지의 검색 카테고리를 제공하며, 원하시는 항목을 기준으로 검색해보세요 
			<br>검색 이후에는, <span style="font-weight:600">결과 내 재검색</span> 기능으로, 원하시는 바에 조금 더 가까운 결과를 찾아보실 수 있어요
			<br>회원이시라면 맘에 드는 장소에 ♥를 꾹 눌러 나의 <span style="font-weight:600">좋아요</span> 목록에 추가해 보세요! 
			<br>참! "좋아요" 목록은 <span style="font-weight:600;">마이 페이지</span>에서 확인하실 수 있어요!
			</p>
			<!-- <br> -->
			<p>※ 혹시 traveller가 모르는 멋진 장소가 있나요?
			<br>검색결과가 없을 때 나타나는 <span style="font-weight:600;">추천하기</span>버튼을 꾹 눌러, 회원님만의 핫플레이스를 소개해주세요!
			<br>관리자 검토 후, 우리의 보물창고에 등록할게요!
			</p>
		</div>
		
		<br>
		<p class="mini-title">플래너 만들기</p>
		<div class="guide-text">
			<p>상단 메뉴 "플래너"의 하위 메뉴, "플래너 만들기"를 통해 여행 계획 편집 툴을 이용하실 수 있습니다
			<br>플래너의 제목을 짓고, 여행 일자, 테마를 기입해 나만의 플래너를 기획해보세요!
			<br>지도를 보며 여행을 상상하고, <span style="font-weight:600;">검색하기</span> 버튼으로 장소를 검색해보세요. 
			<br>검색결과에 따라 지도 상에 출력되는 물방울 무늬의 <span style="font-weight:600;">마커</span>를 클릭하면, 
			<br>화면 좌측의 리스트에 해당 장소가 나만의 "여행지"로서 추가됩니다!
			<br>
			<br>실시간으로 추가된 마커와 마커 사이를, 하나로 이어주는 선을 보세요. 동선을 한 눈에 조감할 수도 있답니다  
			<br>
			<br>"traveller"의 플래너는 <span style="font-weight:600;">변덕</span>을 좋아합니다
			<br>여행을 계획하다 보면, 하루에도 수십 번 마음이 바뀌죠
			<br>리스트 상의 "장소 카드"를 <span style="font-weight:600;">드래그 앤 드롭</span>하면, <span style="text-decoration:underline;">방문 순서를 손쉽게 변경</span>할 수 있어요
			<br>가고 싶지 않은 장소는? "장소 카드"를 클릭하고 "삭제하기" 버튼을 누르면, 곧바로 안녕! 계획에서 지울 수 있어요
			<br>
			<br>내가 만든 "플래너"는 <span style="font-weight:600;">마이 페이지</span>에서 확인하실 수 있어요!
			<br>플래너는 와이파이가 안 되는 곳에서도 확인할 수 있어야겠죠?
			<br>플래너 열람 페이지에서, <span style="font-weight:600;">저장하기</span>버튼을 눌러보세요
			<br><span style="font-weight:600;">엑셀 파일</span>을 다운받으실 수 있어요! 어디서든 traveller와 함께해주세요
			</p>
			<br>
			<p><span style="font-weight:600;margin-bottom:-10px;">※ 기타 기능</span> : "나의 도구들" 버튼을 눌러보세요</p>
			<p style="margin-top:-30px;">
			<br><span style="font-weight:600;">- 날씨</span>
			<br>날씨가 궁금한 장소와 일자를 선택해보세요. 기상청이 제공하는 "중기예보"로, 오늘로부터 3일 이후~ 10일까지의 날씨를 조회하실 수 있습니다
			<br><span style="font-weight:600;">- 좋아요</span>
			<br>혹시, "좋아요" 목록에 추가한 장소가 있나요? 마음에 들었던 장소들을 플래너에 불러올 수 있어요!
			</p>
		</div>
		
		<br>
		<p class="mini-title">크리에이터 구경하기</p>
		<div class="guide-text">
			<p>상단 메뉴 "플래너"의 하위 메뉴, "크리에이터 구경하기"를 통해 traveller에 <span style="font-weight:600;">여행 전문가</span>로서 등록된 회원의 플래너를 구경하실 수 있습니다
			</p>
			<p><span style="font-weight:600;">- 서비스 예정 (구현 중)</span>
			<br>- 크리에이터 신청하기 : 여행 계획의 대가로서 멋진 플랜을 공유하고 싶으신가요? "여행 전문가"로 신청해주세요! 관리자 검토 후, 연락드리겠습니다
			<br>- 여행 계획 의뢰하기 : 플래너의 포트폴리오가 마음에 드셨나요? <span style="font-weight:600;">의뢰하기</span>버튼으로 해당 전문가에게 계획을 의뢰해보세요!	
			</p>
		</div>
		
		
	</div>

</section>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>