/***************************************
	- 제     목: 폐업대상_기존 작업 대 상추출 쿼리
	- 최초작성일: 2024-04-09
	- 최초작성자: 최명원
****************************************/

USE POI_MAIN_PRACT;
GO

SELECT 
      A.POI_ID
    , A.UPDATE_DATE
    , A.ERR_CODE
    , A.PNAME
    , C.USER_SEQ
    , C.USER_NAME
FROM PTM_COMMON AS A WITH (NOLOCK)
INNER JOIN PTC_POI_CLASS AS B WITH (NOLOCK) 
    ON A.POI_ID = B.POI_ID
INNER JOIN GTN_USER AS C WITH (NOLOCK) 
    ON A.UPDATE_USER = C.USER_SEQ
INNER JOIN PTN_NAME AS E WITH (NOLOCK) 
    ON C.USER_SEQ = E.NAME_SEQ
WHERE A.POI_ID IN (
      /* 추출할 POI_ID 리스트 */
  )
  AND A.UPDATE_DATE > '2024-02-29 17:21:44' -- ISO 표준 형식
  -- AND A.ERR_CODE NOT IN (4, 260)        -- 필요시 주석 해제
ORDER BY A.POI_ID;
