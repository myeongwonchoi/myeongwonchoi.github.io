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

USE POI_MAIN_PRACT;
GO

SELECT DISTINCT 
      E.MAP_ID
    , A.POI_ID
    , B.CLASS_CODE
    , C.CA_NAME, C.CB_NAME, C.CC_NAME, C.CD_NAME
    , A.FNAME, A.CNAME
    , A.CENTER_X1, A.CENTER_Y1
    , A.ADDR, A.SAN_BUN, A.PRIMARY_BUN, A.SECONDARY_BUN
    , CONCAT(A.ADDR, ' ', A.PRIMARY_BUN, '-', A.SECONDARY_BUN) AS [주소]
FROM vPOI_I_COMMON_ALL_GRS AS A WITH (NOLOCK)
INNER JOIN PTC_POI_CLASS AS B WITH (NOLOCK) ON A.POI_ID = B.POI_ID
INNER JOIN PTC_CLASS AS C     WITH (NOLOCK) ON B.CLASS_CODE = C.CLASS_CODE
INNER JOIN PTN_ADDR AS D      WITH (NOLOCK) ON A.POI_ID = D.POI_ID
INNER JOIN POI_MAIN_ETC..[22y_2150_INDEX_220401] AS E ON A.TILE_ID LIKE E.MAP_ID + '%'
WHERE E.MAP_ID IN ( )
ORDER BY E.MAP_ID, A.ADDR, A.SAN_BUN, A.PRIMARY_BUN, A.SECONDARY_BUN;
