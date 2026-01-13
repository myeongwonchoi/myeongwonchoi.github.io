/**************************************
	- 제     목: 공사중 POI 추출 쿼리
	- 최초작성일: 2024-04-17
	- 최초작성자: 최명원
****************************************/

use POI_MAIN_PRACT

select distinct a.POI_ID, a.UPDATE_DATE, c.CC_NAME, e.N_NAME AS 명칭, g.USER_NAME, h.CONSTRUCT_DATE, h.MEMO, a.err_code
from PTM_COMMON a, PTC_POI_CLASS b,  PTC_CLASS c, PTD_NAME d, PTN_NAME e, PTN_TELEPHONE f, GTN_USER g, POI_MAIN_ETC..[22y_2150_INDEX_220401] x, PTN_CONSTRUCT h
where a.POI_ID = b.POI_ID and b.CLASS_CODE = c.CLASS_CODE and a.POI_ID = d.POI_ID and d.NAME_SEQ = e.NAME_SEQ and a.POI_ID = f.POI_ID and a.POI_ID = h.POI_ID and g.USER_SEQ = h.USER_SEQ
and d.NAME_KIND = 0
and left(a.TILE_ID,4) = x.MAP_ID
and x.관할업체= '티아이랩'
and a.err_code not in (4,260,516) -- 에러코드 4:ER, 260:ER+TE, 516:ER+UC
order by h.CONSTRUCT_DATE


