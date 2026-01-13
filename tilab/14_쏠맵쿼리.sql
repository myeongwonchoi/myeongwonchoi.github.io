/***********************************************************************
	- 제     목: 14_쏠맵관련
	- 최초작성일: 2024-11-01
	- 최초작성자: 최명원
	- 최종수정일: 2026-01-13
	- 최종작성자: 최명원
************************************************************************/
/*
쏠맵 작업대상 추출 (기준: 3단계 4차 작업도엽)
*/

USE POI_MAIN_PRACT

SELECT DISTINCT E.MAP_ID, A.POI_ID,  B.CLASS_CODE, C.CA_NAME, C.CB_NAME, C.CC_NAME, C.CD_NAME, 
A.FNAME, A.CNAME, A.CENTER_X1, A.CENTER_Y1,
A.ADDR, A.SAN_BUN, A.PRIMARY_BUN, A.SECONDARY_BUN,
A.ADDR +' '+ CAST(A.PRIMARY_BUN AS varchar(10)) + '-' + CAST(A.SECONDARY_BUN AS varchar(10)) AS 주소
FROM vPOI_I_COMMON_ALL_GRS A, PTC_POI_CLASS B, PTC_CLASS C, PTN_ADDR D, POI_MAIN_ETC..[22y_2150_INDEX_220401] E
WHERE A.POI_ID = B.POI_ID AND B.CLASS_CODE = C.CLASS_CODE AND A.POI_ID = D.POI_ID AND LEFT(A.TILE_ID,4) = E.MAP_ID
-- 괄호 안에 MAP_ID를 입력
AND E.MAP_ID IN 
(

)
ORDER BY E.MAP_ID, A.ADDR, A.SAN_BUN, A.PRIMARY_BUN, A.SECONDARY_BUN