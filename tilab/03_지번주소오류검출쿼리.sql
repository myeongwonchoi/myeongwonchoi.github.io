/***************************************
	- 제     목: 수작업 입력 지번 주소와 좌표 기준 지번 주소가 서로 상이한 대상 검출
	- 최초작성일: 2024-04-08
	- 최초작성자: 최명원
	- 최종수정일: 
	- 최종작성자: 
****************************************/

USE POI_MAIN_PRACT

SELECT a.poi_id, a.pname, a.insert_date, a.insert_user, a.update_date, a.update_user, b.user_name, c.address, c.jibun_m , c.jibun_s , e.lnbr_mnnm , e.lnbr_slno
FROM PTM_COMMON a, GTN_USER b, PTN_ADDR c, CTX_PTC_ROAD_ADDR_BULD_MATCHING d, PTN_NEAD_BULD e
WHERE a.update_user = b.user_seq AND a.poi_id = c.poi_id AND a.poi_id = d.poi_id AND d.sig_cd = e.sig_cd AND d.road_id = e.road_id AND d.buld_id = e.buld_id
AND b.user_seq = 3286
AND (c.jibun_m <> e.lnbr_mnnm OR c.jibun_s <> e.lnbr_slno)
AND ERR_CODE NOT IN (4,260)
ORDER BY a.update_date DESC

