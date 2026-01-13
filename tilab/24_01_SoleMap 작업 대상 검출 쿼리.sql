/***************************************
	- 제     목: SolMap 작업 대상 검출 쿼리
	- 최초작성일: 2025-08-07
	- 최초작성자: 최명원
	- 최종수정일: 2026-01-13
	- 최종작성자: 최명원
****************************************/

/*
 데일리로 추출하는 경우
*/

USE SOLEMAP

SELECT *, ADDRESS +' '+ CAST(JIBUN_M AS varchar(10)) + '-' + CAST(JIBUN_S AS varchar(10)) AS 주소
 -- YYYYMMDD 날짜만 변경해서 추출 ex) 20250807
FROM LINK_POI_REL_20260112
WHERE 관할업체 = '티아이랩'
-- 삭제 POI는 검출 대상 제외
AND ERR_CODE NOT IN (1,4,6,68,70,100,260,262,292,324,356,516,580,612,772,836,868)
ORDER BY ADDRESS, JIBUN_M, JIBUN_S

/*
 주말 및 공휴일이 포함되어 여러 날짜를 한번에 추출하는 경우
*/

USE SOLEMAP

SELECT *, ADDRESS +' '+ CAST(JIBUN_M AS varchar(10)) + '-' + CAST(JIBUN_S AS varchar(10)) AS 주소
 -- YYYYMMDD 날짜만 변경해서 추출 ex) 20250808
FROM LINK_POI_REL_YYYYMMDD
WHERE 관할업체 = '티아이랩'
AND ERR_CODE NOT IN (1,4,6,68,70,100,260,262,292,324,356,516,580,612,772,836,868)

-- 테이블 간의 중복 데이터는 검출되지 않도록 UNION 사용 // 중복 검출 필요한 경우 "UNION ALL" 로 변경
UNION 

SELECT *, ADDRESS +' '+ CAST(JIBUN_M AS varchar(10)) + '-' + CAST(JIBUN_S AS varchar(10)) AS 주소
 -- YYYYMMDD 날짜만 변경해서 추출 // 위의 날짜와 상이하여야함 ex) 20250809
FROM LINK_POI_REL_YYYYMMDD
WHERE 관할업체 = '티아이랩'
AND ERR_CODE NOT IN (1,4,6,68,70,100,260,262,292,324,356,516,580,612,772,836,868)

-- 테이블 간의 중복 데이터는 검출되지 않도록 UNION 사용 // 중복 검출 필요한 경우 "UNION ALL" 로 변경
UNION 

SELECT *, ADDRESS +' '+ CAST(JIBUN_M AS varchar(10)) + '-' + CAST(JIBUN_S AS varchar(10)) AS 주소
 -- YYYYMMDD 날짜만 변경해서 추출 // 위의 날짜와 상이하여야함 ex) 20250810
FROM LINK_POI_REL_YYYYMMDD
WHERE 관할업체 = '티아이랩'
AND ERR_CODE NOT IN (1,4,6,68,70,100,260,262,292,324,356,516,580,612,772,836,868)
ORDER BY ADDRESS, JIBUN_M, JIBUN_S