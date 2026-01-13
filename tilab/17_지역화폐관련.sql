/***********************************************************************
	- 제     목: 17_지역화폐관련
	- 최초작성일: 2025-02-19
	- 최초작성자: 최명원
	- 최종수정일: 2025-04-01
	- 최종작성자: 최명원
************************************************************************/


/*
원본 날리면 인생 끝나니까 복사를 하자
*/
SELECT * INTO 지역화폐_250218_origin_backup FROM 지역화폐_250218
SELECT * INTO POI매칭기준_250218_MATCHING FROM POI매칭기준_250218

/*
매칭이 되었다면 UPDATE 쿼리를 이용해서 반영을 해보자
*/
SELECT m.매칭POI_ID, p.poi_id, m.[내역(신규/수정/삭제)], m.상세내역,
m.id, m.상호명, p.fname, p.cname, m.addr, p.addr, m.san, p.san_bun, m.jibun_m, p.primary_bun, m.jibun_s, p.secondary_bun
-- update m set m.매칭poi_id = p.poi_id, m.[내역(신규/수정/삭제)] = '확인', m.상세내역='주소및명칭일치(특수문자제외대상)'
-- update m set m.매칭poi_id = p.poi_id, m.[내역(신규/수정/삭제)] = '수정', m.상세내역='secondary_bun불일치(특수문자제외대상)'
-- update m set m.매칭poi_id = p.poi_id, m.[내역(신규/수정/삭제)] = '수정', m.상세내역='primary_bun불일치(특수문자제외대상)'
-- update m set m.매칭poi_id = p.poi_id, m.[내역(신규/수정/삭제)] = '수정', m.상세내역='san_bun불일치(특수문자제외대상)'
-- update m set m.매칭poi_id = p.poi_id, m.[내역(신규/수정/삭제)] = '수정', m.상세내역='지번불일치(특수문자제외대상)'
FROM cp_tilab_new.dbo.지역화폐_250218_MATCHING m
JOIN cp_tilab_new.dbo.POI매칭기준_250218_MATCHING p
ON -- REPLACE(REPLACE(ISNULL(m.상호명_2, ''), ' ', ''), '/', '') = REPLACE(REPLACE(ISNULL(p.fname, '') + ISNULL(p.cname, ''), ' ', ''), '/', '')  -- 상호명 비교
-- AND 
REPLACE(ISNULL(m.addr, ''), ' ', '') = REPLACE(ISNULL(p.addr, ''), ' ', '')  -- addr 비교
 AND REPLACE(ISNULL(m.san, ''), ' ', '') = REPLACE(ISNULL(p.san_bun, ''), ' ', '')  -- san과 san_bun 비교
 AND REPLACE(ISNULL(m.jibun_m, ''), ' ', '') = REPLACE(ISNULL(p.primary_bun, ''), ' ', '')  -- jibun_m과 primary_bun 비교
 AND REPLACE(ISNULL(m.jibun_s, ''), ' ', '') = REPLACE(ISNULL(p.secondary_bun, ''), ' ', '')  -- jibun_s와 secondary_bun 비교
AND m.매칭POI_ID is null

/*
매칭이 안된 대상을 알아보자
*/
select * from 지역화폐_250218_MATCHING
where 매칭POI_ID IS null

/*
매칭이 안된 대상을 알아보자
*/
select * FROM POI매칭기준_250218_MATCHING
WHERE POI_ID NOT IN 
(
select 매칭POI_ID 
from 지역화폐_250218_MATCHING
where 매칭POI_ID is not null
)

/* 
상호명_2 라는 컬럼을 추가해서 명칭 제거를 마음대로 해보자
*/
ALTER TABLE 지역화폐_250218_MATCHING ADD 상호명_2 NVARCHAR(255);
UPDATE 지역화폐_250218_MATCHING SET 상호명_2 = 상호명;
select * from 지역화폐_250218_MATCHING where 매칭POI_ID is null

/*
첫 번째 괄호 및 괄호 안의 내용을 제거하는 쿼리
*/
UPDATE cp_tilab_new.dbo.지역화폐_250218_MATCHING
SET 상호명_2 = 
    CASE
        WHEN PATINDEX('%(%', 상호명_2) > 0 AND PATINDEX('%)%', 상호명_2) > 0 
        THEN REPLACE(
                 SUBSTRING(상호명_2, 1, PATINDEX('%(%', 상호명_2) - 1) + 
                 SUBSTRING(상호명_2, PATINDEX('%)%', 상호명_2) + 1, LEN(상호명_2)),
                 ' ', '')  -- 괄호 안의 내용 제거 후 공백도 제거
        ELSE 상호명_2
    END;


/*
지역화폐와 poi매칭기준 테이블의 주소를 비교하여 지역화폐 테이블이 갖고 있는 주소만을  poi매칭기준 테이블 DB에서 다 추출해보자.
그래서 더 간단한 테이블로만 쓰기 위해 POI매칭기준_250218_MATCHING_2를 만들자.
*/

SELECT * INTO POI매칭기준_250218_MATCHING_2 FROM POI매칭기준_250218_MATCHING WHERE 1 = 0

INSERT INTO POI매칭기준_250218_MATCHING_2
SELECT p.*
FROM cp_tilab_new.dbo.POI매칭기준_250218_MATCHING p
WHERE EXISTS (
    SELECT 1
    FROM cp_tilab_new.dbo.지역화폐_250218_MATCHING m
    WHERE 
        -- 각 컬럼을 varchar로 변환하여 비교
        REPLACE(REPLACE(REPLACE(REPLACE(CAST(ISNULL(m.addr, '') AS VARCHAR(255)) + '_' + 
                                          CAST(ISNULL(m.san, '') AS VARCHAR(255)) + '_' + 
                                          CAST(ISNULL(m.jibun_m, '') AS VARCHAR(255)) + '_' + 
                                          CAST(ISNULL(m.jibun_s, '') AS VARCHAR(255)), ' ', ''), '/', ''), '(', ''), ')', '') = 
        REPLACE(REPLACE(REPLACE(REPLACE(CAST(ISNULL(p.addr, '') AS VARCHAR(255)) + '_' + 
                                          CAST(ISNULL(p.san_bun, '') AS VARCHAR(255)) + '_' + 
                                          CAST(ISNULL(p.primary_bun, '') AS VARCHAR(255)) + '_' + 
                                          CAST(ISNULL(p.secondary_bun, '') AS VARCHAR(255)), ' ', ''), '/', ''), '(', ''), ')', '')
);

SELECT * FROM POI매칭기준_250218_MATCHING_2
WHERE POI_ID NOT IN
(
SELECT 매칭POI_ID
FROM 지역화폐_250218_MATCHING
WHERE 매칭POI_ID IS NOT NULL
)