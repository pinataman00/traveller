SELECT * FROM TABS;
SELECT * FROM PLACES;

--장소 제안 관련 테이블 생성 > PROPOSAL, PROPOSAL_IMG
SELECT * FROM PROPOSAL;
SELECT * FROM PROPOSAL_IMG;
SELECT * FROM CREW;
--장소 제안 대표 이미지 PK 관련 시퀀스 만듦 
CREATE SEQUENCE SEQ_PROPOSEIMG;

SELECT SEQ_PROPOSAL.NEXTVAL FROM DUAL;
SELECT SEQ_PROPOSAL.CURRVAL FROM DUAL;

--INSERT INTO PROPOSAL VALUES(#{memberId},'P'||SEQ_PROPOSAL.NEXTVAL,#{title},#{areaCode},#{sigunguCode},#{address},#{cat2},#{mapx},#{mapy},DEFAULT,DEFAULT,#{info})

SELECT * FROM PROPOSAL P
LEFT JOIN PROPOSAL_IMG I
USING (PROPOSAL_ID)
WHERE PROPOSAL_ID='P3';

SELECT * FROM PROPOSAL;
SELECT * FROM PROPOSAL_IMG;
SELECT * FROM PLACES WHERE CONTENTID = 'PP1';

--제안한 장소를 PLACES테이블에 등록하기 위해 시퀀스를 생성함 : SEQ_CONTENTID
--PROPOSED PLACE라는 의미에서 PP를 붙이기로 함...

SELECT SEQ_CONTENTID.NEXTVAL FROM DUAL;
SELECT 'PP'||SEQ_CONTENTID.NEXTVAL FROM DUAL;

SELECT * FROM PROPOSAL WHERE PROPOSAL_ID='P10';

-- 좋아요 TABLE (사용자 정의 카테고리 추가할 때 소환)
SELECT * FROM LIKES; 
-- 좋아요 상세 TABLE (실질적으로 장소를 좋아요 목록에 '추가하기'실행 시 해당 테이블에 데이터가 추가되도록)
-- LOCDE는 SEQUENCE로 생성, LIKES_ID는 LIKES테이블의 PK를 FK로 사용한 것, CONTENTID는 장소PLACES테이블 관련
SELECT * FROM LIKES_INFO;


--SEQ_LIKES : LIKES테이블의 PK를 위해 SEQUENCE를 만듦

SELECT * FROM LIKES WHERE MEMBER_ID = 'admin08';

SELECT * FROM TABS;

SELECT * FROM PLACES WHERE CONTENTID = '2766542';

--'좋아요' 목록 PK 관련 시퀀스
SELECT SEQ_LIKES.NEXTVAL FROM DUAL;
--SELECT SEQ_LIKESINFO.NEXTVAL FROM DUAL;

--LIKES_INFO 테이블의 PK(LCODE)를 위한 SEQUENCE를 생성함
CREATE SEQUENCE SEQ_LIKESINFO;

SELECT * FROM LIKES JOIN LIKES_INFO USING(LIKES_ID) WHERE MEMBER_ID='admin08' AND CONTENTID='2750143';
SELECT * FROM LIKES JOIN LIKES_INFO USING(LIKES_ID) WHERE MEMBER_ID='admin08';
SELECT CONTENTID FROM LIKES JOIN LIKES_INFO USING(LIKES_ID) WHERE MEMBER_ID='admin08';

		SELECT * FROM LIKES L
				      JOIN LIKES_INFO I
				      USING(LIKES_ID)
				 WHERE L.MEMBER_ID='admin08';
SELECT * FROM LIKES_INFO;

		SELECT * FROM LIKES_INFO I
				      JOIN LIKES L
				      USING(LIKES_ID)
				 WHERE L.MEMBER_ID='admin08';
				 
SELECT * FROM LIKES;
SELECT * FROM LIKES_INFO;

SELECT * FROM LIKES_INFO WHERE LIKES_ID=13;

--SELECT * FROM LIKES_INFO WHERE LIKES_ID=13;

SELECT * FROM PLACES WHERE CONTENTID = 2750143;

SELECT * FROM PLACES P
			  JOIN LIKES_INFO I
			  USING(CONTENTID)
			  WHERE I.LIKES_ID =13;
			  
			 
SELECT * FROM "MEMBER" WHERE MEMBER_ID = 'admin08';
SELECT * FROM PROFILEIMG;
SELECT * FROM TABS;
SELECT * FROM CREW;
--SELECT * FROM PLACES JOIN 

SELECT * FROM PLACES P
			  JOIN LIKES_INFO I
			  USING(CONTENTID)
			  WHERE I.LIKES_ID =13 
			  AND P.TITLE LIKE '%가%';
			  
DELETE FROM LIKES WHERE LIKES_ID = 15;