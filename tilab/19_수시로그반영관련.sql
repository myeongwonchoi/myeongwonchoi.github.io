/***********************************************************************
	- 제     목: 19_수시로그반영관련
	- 최초작성일: 2025-04-30
	- 최초작성자: 최명원
	- 최종수정일: 2025-05-04
	- 최종작성자: 최명원
************************************************************************/

USE POI_MAIN_PRACT

SELECT A.POI_ID, A.FNAME, A.CNAME, B.CLASS_CODE, C.CA_NAME, C.CB_NAME, C.CC_NAME, C.CD_NAME, A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN
FROM vPOI_I_COMMON_ALL_GRS A, PTC_POI_CLASS B, PTC_CLASS C, PTN_ADDR D, POI_MAIN_ETC..[22y_2150_INDEX_220401] E
WHERE A.POI_ID = B.POI_ID AND B.CLASS_CODE = C.CLASS_CODE AND A.POI_ID = D.POI_ID AND LEFT(A.TILE_ID,4) = E.MAP_ID
and a.poi_id in
(
SELECT *
FROM PTN_WORK_COMMENT
WHERE COMMENT LIKE '%수시%'
AND INSERT_DATE >= '2025-04-28 15:09:46.073' 
AND USER_NAME IN ()
)
