/***************************************
	- 제     목: WEEKLY_IBD(구.VCRM)검출쿼리
	- 최초작성일: 2024-05-21
	- 최초작성자: 최명원
	- 최종수정일: 2025-06-23
	- 최종작성자: 최명원
****************************************/

USE CP_PARTNER_NEW

SELECT A.*
FROM VCRM_CORE_MANAGE_TARGET A, POI_MAIN_ETC..[22y_2150_INDEX_220401] B 
WHERE LEFT(A.map_id, 4) = B.MAP_ID
AND B.관할업체 = '티아이랩'
AND A.POI_ID IS NOT NULL
ORDER BY A.work_date