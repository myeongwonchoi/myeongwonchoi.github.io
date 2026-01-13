/**************************************
	- 제     목: 공사중 POI 추출 쿼리
	- 최초작성일: 2024-04-17
	- 최초작성자: 최명원
****************************************/

USE POI_MAIN_PRACT

SELECT DISTINCT a.POI_ID, a.UPDATE_DATE, c.CC_NAME, e.N_NAME AS 명칭, g.USER_NAME, h.CONSTRUCT_DATE, h.MEMO, a.err_code
FROM PTM_COMMON a, PTC_POI_CLASS b,  PTC_CLASS c, PTD_NAME d, PTN_NAME e, PTN_TELEPHONE f, GTN_USER g, POI_MAIN_ETC..[22y_2150_INDEX_220401] x, PTN_CONSTRUCT h
WHERE a.POI_ID = b.POI_ID AND b.CLASS_CODE = c.CLASS_CODE AND a.POI_ID = d.POI_ID AND d.NAME_SEQ = e.NAME_SEQ AND a.POI_ID = f.POI_ID AND a.POI_ID = h.POI_ID AND g.USER_SEQ = h.USER_SEQ
AND d.NAME_KIND = 0
AND LEFT(a.TILE_ID,4) = x.MAP_ID
AND x.관할업체= '티아이랩'
AND a.err_code NOT IN (4,260,516) -- 에러코드 4:ER, 260:ER+TE, 516:ER+UC
ORDER BY h.CONSTRUCT_DATE

