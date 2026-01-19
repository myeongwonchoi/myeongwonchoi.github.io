/***************************************
	- 제     목: 수작업 입력 지번 주소와 좌표 기준 지번 주소가 서로 상이한 대상 검출
	- 최초작성일: 2024-04-08
	- 최초작성자: 최명원
	- 최종수정일: 
	- 최종작성자: 
****************************************/

USE POI_MAIN_PRACT;
GO

SELECT 
      A.POI_ID
    , A.PNAME
    , A.INSERT_DATE
    , A.INSERT_USER
    , A.UPDATE_DATE
    , A.UPDATE_USER
    , B.USER_NAME
    , C.ADDRESS AS [수작업_주소]
    , C.JIBUN_M AS [수작업_본번], C.JIBUN_S AS [수작업_부번]
    , E.LNBR_MNNM AS [매칭_본번], E.LNBR_SLNO AS [매칭_부번]
FROM PTM_COMMON AS A WITH (NOLOCK)
INNER JOIN GTN_USER AS B WITH (NOLOCK) 
    ON A.UPDATE_USER = B.USER_SEQ
INNER JOIN PTN_ADDR AS C WITH (NOLOCK) 
    ON A.POI_ID = C.POI_ID
INNER JOIN CTX_PTC_ROAD_ADDR_BULD_MATCHING AS D WITH (NOLOCK) 
    ON A.POI_ID = D.POI_ID
INNER JOIN PTN_NEAD_BULD AS E WITH (NOLOCK) 
    ON D.SIG_CD = E.SIG_CD 
   AND D.ROAD_ID = E.ROAD_ID 
   AND D.BULD_ID = E.BULD_ID
WHERE B.USER_SEQ = 3286
  AND A.ERR_CODE NOT IN (4, 260)
  /* 지번 불일치 조건: 본번 혹은 부번이 하나라도 다르면 검출 */
  AND (C.JIBUN_M <> E.LNBR_MNNM OR C.JIBUN_S <> E.LNBR_SLNO)
ORDER BY A.UPDATE_DATE DESC;
