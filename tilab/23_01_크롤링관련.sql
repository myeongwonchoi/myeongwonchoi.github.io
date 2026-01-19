/* 1. 전체 데이터 검출 */
SELECT A.POI_ID, A.FNAME, A.CNAME, A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR
    , A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D
    , C.ADDRESS AS [도로명주소], C.BULD_MNNM, C.BULD_SLNO
    , D.PARKING_YN
    , E.DATE AS [OFF_DATE]
    , F.WEEKDAY, F.ST_HOUR, F.ST_MIN, F.ED_HOUR, F.ED_MIN
FROM vPOI_I_COMMON_ALL_GRS AS A WITH (NOLOCK)
INNER JOIN POI_MAIN_ETC..[22y_2150_INDEX_220401] AS B 
    ON LEFT(TILE_ID,4) =  B.MAP_ID
INNER JOIN PTN_ROAD_ADDR AS C WITH (NOLOCK) 
    ON A.POI_ID = C.POI_ID
-- 부가정보가 없는 POI도 확인하려면 LEFT JOIN으로 변경 권장
LEFT JOIN PTN_PARKING AS D WITH (NOLOCK) ON A.POI_ID = D.POI_ID
LEFT JOIN PTN_OFFDAY_DATE AS E WITH (NOLOCK) ON A.POI_ID = E.POI_ID
LEFT JOIN PTN_WORK_HOUR_REGULAR AS F WITH (NOLOCK) ON A.POI_ID = F.POI_ID
WHERE B.관할업체 = '티아이랩'
  AND REPLACE(A.FNAME, '/', '') IN (
      '60계치킨', 'AK플라자', 'BHC치킨', 'CGV', 'CU', 'GS25', 'KFC', 'NC백화점', '갤러리아백화점', '공임나라', '공차', '굽네치킨',
      '기아오토큐', '기아', '나인블럭', '노브랜드버거', '다이소', '달콤커피', '던킨', '도미노피자', '뚜레쥬르', '롯데리아', '롯데마트', '롯데백화점', '롯데시네마',
      '롯데아울렛', '마일레오토서비스', '만도플라자', '맘스터치', '맥도날드', '메가박스', '메가MGC커피', '미스터피자', '바나프레소', '배스킨라빈스31', '현대블루핸즈', '빕스', 
      '빽다방', '상무초밥', '샤브20', '샤브마니아', '세븐일레븐', '소담촌', '쉐이크쉑', '스타벅스', '스피드메이트', '신세계백화점', '쌍교숯불갈비', '써브웨이', '씨스페이스',
      '아웃백스테이크하우스', '아파트지인', '엔제리너스커피', '오봉집', '오토오아시스', '이디야', '이마트', '이마트24', '이마트에브리데이', '이차돌', '제주은희네해장국',
      '짬뽕지존', '채선당', '초중고', '카페베네', '커피빈', '컴포즈커피', '코스트코홀세일', '탐앤탐스', '투썸플레이스', '트레이더스홀세일클럽', '파리바게뜨', '파스쿠찌',
      '폴바셋', '프랭크버거', '피자헛', '하나로마트', '할리스커피', '현대백화점', '현대프리미엄아울렛', '현대자동차', '홈플러스', '홈플러스익스프레스'
  )
ORDER BY A.POI_ID;

/* 2. 크롤링 중 부가정보(주차/휴무/영업) 누락 대상 검출 */
SELECT A.POI_ID, A.FNAME, A.CNAME, A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, C.ADDRESS AS [도로명주소]
    -- 어떤 정보가 누락되었는지 확인하기 위한 컬럼들
    , CASE WHEN D.POI_ID IS NULL THEN '주차X' ELSE '주차O' END AS [주차여부]
    , CASE WHEN E.POI_ID IS NULL THEN '휴무X' ELSE '휴무O' END AS [휴무여부]
    , CASE WHEN F.POI_ID IS NULL THEN '영업시간X' ELSE '영업시간O' END AS [시간여부]
FROM vPOI_I_COMMON_ALL_GRS AS A WITH (NOLOCK)
INNER JOIN POI_MAIN_ETC..[22y_2150_INDEX_220401] AS B ON A.TILE_ID LIKE B.MAP_ID + '%'
INNER JOIN PTN_ROAD_ADDR AS C WITH (NOLOCK) ON A.POI_ID = C.POI_ID
-- 부가정보 테이블들을 LEFT JOIN으로 연결
LEFT JOIN PTN_PARKING AS D WITH (NOLOCK) ON A.POI_ID = D.POI_ID
LEFT JOIN PTN_OFFDAY_DATE AS E WITH (NOLOCK) ON A.POI_ID = E.POI_ID
LEFT JOIN PTN_WORK_HOUR_REGULAR AS F WITH (NOLOCK) ON A.POI_ID = F.POI_ID
WHERE B.관할업체 = N'티아이랩'
  AND REPLACE(A.FNAME, '/', '') IN (
      '60계치킨', 'AK플라자', 'BHC치킨', 'CGV', 'CU', 'GS25', 'KFC', 'NC백화점', '갤러리아백화점', '공임나라', '공차', '굽네치킨',
      '기아오토큐', '기아', '나인블럭', '노브랜드버거', '다이소', '달콤커피', '던킨', '도미노피자', '뚜레쥬르', '롯데리아', '롯데마트', '롯데백화점', '롯데시네마',
      '롯데아울렛', '마일레오토서비스', '만도플라자', '맘스터치', '맥도날드', '메가박스', '메가MGC커피', '미스터피자', '바나프레소', '배스킨라빈스31', '현대블루핸즈', '빕스', 
      '빽다방', '상무초밥', '샤브20', '샤브마니아', '세븐일레븐', '소담촌', '쉐이크쉑', '스타벅스', '스피드메이트', '신세계백화점', '쌍교숯불갈비', '써브웨이', '씨스페이스',
      '아웃백스테이크하우스', '아파트지인', '엔제리너스커피', '오봉집', '오토오아시스', '이디야', '이마트', '이마트24', '이마트에브리데이', '이차돌', '제주은희네해장국',
      '짬뽕지존', '채선당', '초중고', '카페베네', '커피빈', '컴포즈커피', '코스트코홀세일', '탐앤탐스', '투썸플레이스', '트레이더스홀세일클럽', '파리바게뜨', '파스쿠찌',
      '폴바셋', '프랭크버거', '피자헛', '하나로마트', '할리스커피', '현대백화점', '현대프리미엄아울렛', '현대자동차', '홈플러스', '홈플러스익스프레스'
  )
  /* 핵심 조건: 3개 테이블 중 하나라도 정보가 없는(NULL) 대상만 출력 */
  AND (D.POI_ID IS NULL OR E.POI_ID IS NULL OR F.POI_ID IS NULL)
ORDER BY A.POI_ID;

/* 3. 2번에서 출력한 대상들의 PTN_PARKING , PTN_OFFDAY_DATE, PTN_WORK_HOUR_REGULAR 반영 값 조회 */
SELECT A.POI_ID, A.FNAME, A.CNAME, B.ADDRESS AS [도로명주소], B.BULD_MNNM, B.BULD_SLNO
    -- 1. 주차 정보 (PTN_PARKING)
    , ISNULL(C.PARKING_YN, '기록없음') AS [주차_반영값]
    -- 2. 휴무일 정보 (PTN_OFFDAY_DATE)
    , ISNULL(CONVERT(VARCHAR, D.DATE, 120), '기록없음') AS [휴무_반영값]
    -- 3. 영업시간 정보 (PTN_WORK_HOUR_REGULAR)
    , CASE 
        WHEN E.POI_ID IS NULL THEN '기록없음'
        ELSE CONCAT(N'요일:', E.WEEKDAY, ' / ', E.ST_HOUR, ':', E.ST_MIN, ' ~ ', E.ED_HOUR, ':', E.ED_MIN)
      END AS [영업시간_반영값]
FROM vPOI_I_COMMON_ALL_GRS AS A WITH (NOLOCK)
INNER JOIN PTN_ROAD_ADDR AS B WITH (NOLOCK) ON A.POI_ID = B.POI_ID
/* 부가정보 테이블 조인 (정보가 없어도 조회되도록 LEFT JOIN 유지) */
LEFT JOIN PTN_PARKING AS C WITH (NOLOCK) ON A.POI_ID = C.POI_ID
LEFT JOIN PTN_OFFDAY_DATE AS D WITH (NOLOCK) ON A.POI_ID = D.POI_ID
LEFT JOIN PTN_WORK_HOUR_REGULAR AS E WITH (NOLOCK) ON A.POI_ID = E.POI_ID
WHERE A.POI_ID IN ( ) -- 여기에 2번 단계에서 나온 POI_ID 리스트 입력. 만약 브랜드 필터를 그대로 쓰고 싶다면 아래 주석을 해제 */
ORDER BY A.POI_ID;

/*  4. 3번에서도 안 나온 대상의 명칭을 바꿔서 재 출력 */
-- 1. 부가정보가 하나라도 매핑된 명칭 누락 POI 상세 조회
SELECT A.POI_ID, A.FNAME, A.CNAME, C.ADDRESS AS [도로명주소]
    -- 주차 정보 존재 여부
    , CASE WHEN EXISTS (SELECT 1 FROM PTN_PARKING P WHERE P.POI_ID = A.POI_ID) THEN 'O' ELSE 'X' END AS [주차_있음]
    -- 휴무일 정보 존재 여부
    , CASE WHEN EXISTS (SELECT 1 FROM PTN_OFFDAY_DATE O WHERE O.POI_ID = A.POI_ID) THEN 'O' ELSE 'X' END AS [휴무_있음]
    -- 영업시간 정보 존재 여부
    , CASE WHEN EXISTS (SELECT 1 FROM PTN_WORK_HOUR_REGULAR W WHERE W.POI_ID = A.POI_ID) THEN 'O' ELSE 'X' END AS [시간_있음]
FROM vPOI_I_COMMON_ALL_GRS AS A WITH (NOLOCK)
INNER JOIN POI_MAIN_ETC..[22y_2150_INDEX_220401] AS B ON A.TILE_ID LIKE B.MAP_ID + '%'
INNER JOIN PTN_ROAD_ADDR AS C WITH (NOLOCK) ON A.POI_ID = C.POI_ID
WHERE B.관할업체 = N'티아이랩'
  AND (ISNULL(LTRIM(RTRIM(A.FNAME)), '') = '') -- 실제 명칭이 공백이거나 NULL인 경우
ORDER BY A.POI_ID;

-- 2. 만약 특정 테이블의 실제 '값'이 궁금하다면 아래처럼 조인하여 확인 (영업시간 예시)
SELECT A.POI_ID, A.FNAME, F.WEEKDAY, F.ST_HOUR, F.ST_MIN, F.ED_HOUR, F.ED_MIN
FROM vPOI_I_COMMON_ALL_GRS AS A WITH (NOLOCK)
INNER JOIN PTN_WORK_HOUR_REGULAR AS F WITH (NOLOCK) ON A.POI_ID = F.POI_ID
WHERE (ISNULL(LTRIM(RTRIM(A.FNAME)), '') = '')
  AND EXISTS (SELECT 1 FROM POI_MAIN_ETC..[22y_2150_INDEX_220401] B WHERE A.TILE_ID LIKE B.MAP_ID + '%' AND B.관할업체 = N'티아이랩')
ORDER BY A.POI_ID;
