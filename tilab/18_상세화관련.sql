/***********************************************************************
	- 제     목: 18_상세화관련
	- 최초작성일: 2025-04-01
	- 최초작성자: 최명원
	- 최종수정일: 2025-04-09
	- 최종작성자: 최명원
************************************************************************/

/*
 상세종별_구조일반 (간단하게 생각하면 종별세분화)
*/
SELECT TOP 100 * 
FROM PTC_FEATURE_GROUP

/*
 상세종별_구조상세 (간단하게 생각하면 메뉴)
*/
SELECT TOP 100 * 
FROM PTC_FEATURE_LIST

/*
 상세종별_구조상세 (메뉴의 서브이름)
*/
SELECT TOP 100 *
FROM PTD_SUB_FEATURE_LIST

/*
 POI 별 상세화 작업 현황
*/
SELECT A.POI_ID, B.SUB_FEATURE_NAME, C.USER_NAME, D.UPDATE_DATE
FROM PTC_POI_SUB_FEATURE_LIST A, PTD_SUB_FEATURE_LIST B, GTN_USER C, vPOI_I_COMMON_ALL_GRS D
WHERE A.SUB_FEATURE_ID = B.SUB_FEATURE_ID AND A.INSERT_USER = C.USER_SEQ AND A.POI_ID = D.POI_ID
AND C.USER_NAME IN ('이제희','최명원','양연경','강인애','김태진','이해수','윤성민','허민경')
ORDER BY D.UPDATE_DATE, A.POI_ID DESC