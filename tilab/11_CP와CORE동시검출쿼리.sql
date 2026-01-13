/***************************************
	- 제     목: CP와 CORE 데이터를 동시에 검출하는 쿼리
	- 최초작성일: 2024-06-11
	- 최초작성자: 최명원
	- 최종수정일: 2025-05-07	
	- 최종작성자: 최명원
****************************************/

USE CP_MAIN_CONV_OBN_BAK

SELECT A.POI_ID, C.MAP_ID, C.관할업체 -- CP_ID가 77이면 CORE, 그 외에는 CP
FROM MID_CP_COMMON_5월1차_20250428 A, POI_MAIN_PRACT..PTC_CLASS B, POI_MAIN_ETC..[22y_2150_INDEX_220401] C-- 제일 최신걸 써야 함 (비고: 데이터들은 MID에서 정제해서 RAW로 넘어가는 형태)
WHERE A.CLASS_CODE = B.CLASS_CODE
AND LEFT(A.TILE_ID,4) = C.MAP_ID
AND A.POI_ID IN ()