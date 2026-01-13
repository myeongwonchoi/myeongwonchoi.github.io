/***************************************
	- 제     목: P-C관계추출쿼리
	- 최초작성일: 2024-06-17
	- 최초작성자: 최명원
	- 최종수정일: 2025-12-17
	- 최종작성자: 최명원
****************************************/

SELECT DISTINCT B.REP_POI_ID AS 상위POI_ID, A.POI_ID AS 하위POI_ID, A.CLASS_CODE, C.FNAME, C.CNAME, C.ADDR, C.SAN_BUN, C.PRIMARY_BUN, C.SECONDARY_BUN, C.TELE_A, C.TELE_B, C.TELE_C, C.TELE_D
FROM PTC_POI_CLASS A, PTD_REP_POI B, vPOI_I_COMMON_ALL_GRS C
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND B.REP_POI_ID IN () -- 상위 POI 입력
ORDER BY B.REP_POI_ID, A.POI_ID
