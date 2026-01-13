/***************************************
	- 제     목: 폐업대상_기존 작업 대 상추출 쿼리
	- 최초작성일: 2024-04-09
	- 최초작성자: 최명원
****************************************/

use POI_MAIN_PRACT

select  a.poi_id, a.UPDATE_DATE, a.ERR_CODE, a.pname, c.user_seq, c.USER_NAME
from PTM_COMMON a, PTC_POI_CLASS b, GTN_USER c,  PTN_NAME e
where a.POI_ID = b.POI_ID and a.UPDATE_USER = c.USER_SEQ and c.USER_SEQ = e.NAME_SEQ
and a.poi_id in ()
and a.update_date > '2024-02-29 17:21:44.763'
-- and a.ERR_CODE not in (4, 260)
order by a.poi_id
