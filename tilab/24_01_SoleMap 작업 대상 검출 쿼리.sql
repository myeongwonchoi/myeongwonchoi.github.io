/***************************************
	- 제     목: SolMap 작업 대상 검출 쿼리
	- 최초작성일: 2025-08-07
	- 최초작성자: 최명원
	- 최종수정일: 2026-01-13
	- 최종작성자: 최명원
****************************************/

/*  데일리로 추출하는 경우 */

USE SOLEMAP;
GO

SELECT *, CONCAT(ADDRESS, ' ', JIBUN_M, '-', JIBUN_S) AS [주소]
 -- YYYYMMDD 날짜만 변경해서 추출 ex) 20250807
FROM LINK_POI_REL_20260112 WITH (NOLOCK)
WHERE 관할업체 = '티아이랩'
-- 삭제 POI는 검출 대상 제외
AND ERR_CODE NOT IN (1, 4, 6, 68, 70, 100, 260, 262, 292, 324, 356, 516, 580, 612, 772, 836, 868)
ORDER BY ADDRESS, JIBUN_M, JIBUN_S;

/*  주말 및 공휴일이 포함되어 여러 날짜를 한번에 추출하는 경우 */

USE SOLEMAP;
GO

-- 중복 제거가 필요한 경우 UNION 유지, 속도가 중요하다면 UNION ALL 권장
SELECT * FROM (
    SELECT *, CONCAT(ADDRESS, ' ', JIBUN_M, '-', JIBUN_S) AS [주소]
    FROM LINK_POI_REL_20260117 WITH (NOLOCK) -- 날짜 1
    WHERE 관할업체 = '티아이랩'
      AND ERR_CODE NOT IN (1, 4, 6, 68, 70, 100, 260, 262, 292, 324, 356, 516, 580, 612, 772, 836, 868)

    UNION 

    SELECT *, CONCAT(ADDRESS, ' ', JIBUN_M, '-', JIBUN_S) AS [주소] 
    FROM LINK_POI_REL_20260118 WITH (NOLOCK) -- 날짜 2
    WHERE 관할업체 = '티아이랩'
      AND ERR_CODE NOT IN (1, 4, 6, 68, 70, 100, 260, 262, 292, 324, 356, 516, 580, 612, 772, 836, 868)

    UNION 

    SELECT *, CONCAT(ADDRESS, ' ', JIBUN_M, '-', JIBUN_S) AS [주소]  
    FROM LINK_POI_REL_20260119 WITH (NOLOCK) -- 날짜 3
    WHERE 관할업체 = '티아이랩'
      AND ERR_CODE NOT IN (1, 4, 6, 68, 70, 100, 260, 262, 292, 324, 356, 516, 580, 612, 772, 836, 868)
) AS Unified_POI
ORDER BY ADDRESS, JIBUN_M, JIBUN_S;
