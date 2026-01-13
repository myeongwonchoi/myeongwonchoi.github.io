/***********************************************************************
	- 제     목: 16_출입구POOL관련
	- 최초작성일: 2025-02-11
	- 최초작성자: 최명원
	- 최종수정일: 2025-04-01
	- 최종작성자: 최명원
************************************************************************/


/*
 출입구 연결 - POI 안내 정보 - 안내코드 설명
*/

SELECT * FROM PTC_GUIDE_CODE

/*
 출입구 연결 - POI 안내 정보 값
*/
SELECT *
FROM PTD_POI_GUIDE
WHERE UPDATE_USER IN 
(
SELECT USER_SEQ 
FROM GTN_USER
WHERE USER_NAME IN ( )
)
ORDER BY UPDATE_USER, UPDATE_DATE, POI_ID


/*
 안내코드에 최적탐색제외(비선호)가 포함된 대상을 검출 // 하위 POI는 최적탐색제외(비선호)를 설정해서는 아니된다
*/

USE POI_MAIN_PRACT

SELECT A.*, B.USER_NAME, C.FNAME, C.CNAME, C.ADDR, C.ADDR2, C.PRIMARY_BUN, C.SECONDARY_BUN, C.SAN_BUN, C.CENTER_X1, C.CENTER_Y1
FROM PTD_POI_GUIDE A, GTN_USER B, vPOI_I_COMMON_ALL_GRS c
WHERE A.INSERT_USER = B.USER_SEQ AND A.POI_ID = C.POI_ID
AND A.INSERT_USER IN
(
SELECT USER_SEQ 
FROM GTN_USER
WHERE USER_NAME IN ( )
)
and a.GUIDE_CODE = 16
ORDER BY ADDR, PRIMARY_BUN, SECONDARY_BUN, UPDATE_USER DESC


SELECT A.*, B.USER_NAME
FROM PTD_POI_GUIDE A, GTN_USER B
WHERE A.INSERT_USER = B.USER_SEQ
AND A.INSERT_USER IN
(
SELECT USER_SEQ 
FROM GTN_USER
WHERE USER_NAME IN ()
)
ORDER BY POI_ID, INSERT_USER DESC


/*

*/
select * 
from ptd_poi_guide
where xy_id in ()

/*

*/
select * 
from PTN_WORK_COMMENT
where COMMENT like '%%'
order by INSERT_DATE desc

/*

*/
select poi_id, fname
from vPOI_I_COMMON_ALL_GRS
where poi_id in ()


SELECT POI_ID, FNAME, SNAME, UPDATE_DATE, USER_NAME, COMMENT
FROM vPOI_I_COMMON_ALL_GRS
WHERE POI_ID IN ( )
AND USER_NAME = ''

ORDER BY UPDATE_DATE DESC
