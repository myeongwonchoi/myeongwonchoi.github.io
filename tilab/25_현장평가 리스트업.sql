/***********************************************************************
	- 제     목: 25_현장평가 리스트업
	- 최초작성일: 2025-09-239
	- 최초작성자: 최명원
	- 최종수정일: 
	- 최종작성자: 
************************************************************************/

/*
 1. CORE 대상 추출해서 엑셀 파일에 기입하기
*/
USE POI_MAIN_PRACT

SELECT DISTINCT POI_ID, FNAME, CNAME, CP_ID,
ADDR +' '+ CAST(PRIMARY_BUN AS varchar(10)) + '-' + CAST(SECONDARY_BUN AS varchar(10)) AS 구주소,
TELE_A + '-' + TELE_B +  '-' +TELE_C AS 전화번호
FROM vPOI_I_COMMON_ALL_GRS
-- 가고자 하는 동 입력
WHERE ADDR LIKE '%'
-- 가고자 하는 지번 입력
AND PRIMARY_BUN IN ()
-- 가고자 하는 부번 입력
AND SECONDARY_BUN IN ()
ORDER BY FNAME, CNAME, 구주소


/*
 2. CORE가 아닌 CP 대상 추출해서 엑셀 파일에 기입하기
 */
SELECT POI_ID, FNAME, CNAME, CP_ID,
ADDR +' '+ CAST(PRIMARY_BUN AS varchar(10)) + '-' + CAST(SECONDARY_BUN AS varchar(10)) AS 구주소,
TELE_A + '-' + TELE_B +  '-' +TELE_C AS 전화번호
FROM CP_MAIN_CONV_OBN_BAK..MID_CP_COMMON_9월2차_20250918
-- 가고자 하는 동 입력
WHERE ADDR LIKE '%'
-- 가고자 하는 지번 입력
AND PRIMARY_BUN IN ()
-- 가고자 하는 부번 입력
AND SECONDARY_BUN IN ()
AND POI_ID NOT IN
(
-- 1번 쿼리 복붙하기
SELECT DISTINCT POI_ID
FROM vPOI_I_COMMON_ALL_GRS
WHERE ADDR LIKE '%'
AND PRIMARY_BUN IN ()
AND SECONDARY_BUN IN ()
)
ORDER BY FNAME, CNAME, 구주소

/*
 3. 기삭제 대상 찾아내서 엑셀 파일에서 지우기
*/
SELECT POI_ID, ERR_CODE
FROM PTM_COMMON
WHERE POI_ID IN ( )
AND ERR_CODE IN (2, 34, 6, 262, 66, 98, 354, 258, 770, 514, 1, 4, 68, 100, 324, 356, 836, 580, 612, 260, 292, 772, 516)
