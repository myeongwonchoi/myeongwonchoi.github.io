/***********************************************************************
	- 제     목: 21_영업정보검증쿼리
	- 최초작성일: 2025-05-27
	- 최초작성자: 최명원
	- 최종수정일: 2025-10-02
	- 최종작성자: 최명원
************************************************************************/

/*
 대형마트_영업시간_휴무일확인_검출
*/
USE POI_MAIN_PRACT

SELECT A.POI_ID, B.CLASS_CODE, A.FNAME, A.CNAME, '','', C.WEEKDAY, C.ST_HOUR, C.ST_MIN, C.ED_HOUR, C.ED_MIN, '', '' ,'', D.DATE
FROM vPOI_I_COMMON_ALL_GRS A, PTC_POI_CLASS B, PTN_WORK_HOUR_REGULAR C, PTN_OFFDAY_DATE D
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID = D.POI_ID
AND A.POI_ID IN 
(

)
AND D.DATE > '2025-10-02 00:00:00.000' -- 엑셀 작업파일 내 휴무일 중 가장 빠른 날짜 하루 전날의 0시 입력
ORDER BY A.POI_ID

/*
 대형마트_영업시간_휴무일없는대상_검출
*/
USE POI_MAIN_PRACT

SELECT A.POI_ID, B.CLASS_CODE, A.FNAME, A.CNAME, '','', C.WEEKDAY, C.ST_HOUR, C.ST_MIN, C.ED_HOUR, C.ED_MIN, '', '' ,''
FROM vPOI_I_COMMON_ALL_GRS A, PTC_POI_CLASS B, PTN_WORK_HOUR_REGULAR C
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID IN 
(

)
ORDER BY A.POI_ID

/*
 하나로마트_영업시간_휴무일확인_마트_검출
*/
USE POI_MAIN_PRACT

SELECT A.POI_ID, B.CLASS_CODE,A.CNAME, A.ADDR, C.ST_HOUR, C.ST_MIN, C.ED_HOUR, C.ED_MIN, C.COMMENT, '', '', D.DATE
FROM vPOI_I_COMMON_ALL_GRS A, PTC_POI_CLASS B, PTN_WORK_HOUR_REGULAR C, PTN_OFFDAY_DATE D
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID = D.POI_ID
AND A.POI_ID IN 
(

)
AND D.DATE > '2025-10-02 00:00:00.000' -- 엑셀 작업파일 내 휴무일 중 가장 빠른 날짜 하루 전날의 0시 입력
ORDER BY A.POI_ID

/*
 하나로마트_영업시간_휴무일없는대상_마트_검출
*/
USE POI_MAIN_PRACT

SELECT A.POI_ID, B.CLASS_CODE,A.CNAME, A.ADDR, C.ST_HOUR, C.ST_MIN, C.ED_HOUR, C.ED_MIN, C.COMMENT, '', ''
FROM vPOI_I_COMMON_ALL_GRS A, PTC_POI_CLASS B, PTN_WORK_HOUR_REGULAR C
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID IN 
(

)
ORDER BY A.POI_ID