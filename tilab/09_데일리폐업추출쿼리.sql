/***************************************
	- 제     목: 데일리폐업추출쿼리
	- 최초작성일: 2024-05-20
	- 최초작성자: 최명원
	- 최종수정일: 2024-05-28
	- 최종작성자: 최명원
****************************************/

USE POI_MAIN_PRACT

SELECT * 
FROM [$HPOI_CLOSED_DASHBOARD]
WHERE 할당권역 = '티아이랩'
AND SOURCE IN ('state20','state30')
ORDER BY INSERT_DATE DESC