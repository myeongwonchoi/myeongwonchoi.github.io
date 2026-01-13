/*
    1. 전체 데이터 검출
*/
SELECT A.POI_ID, A.FNAME, A.CNAME, '','', A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR, A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D,
C.ADDRESS, C.BULD_MNNM, C.BULD_SLNO, '', D.PARKING_YN, E.DATE, F.WEEKDAY, F.ST_HOUR, F.ST_MIN, F.ED_HOUR, F.ED_MIN, '','','','','','',''
FROM vPOI_I_COMMON_ALL_GRS A, POI_MAIN_ETC..[22y_2150_INDEX_220401] B, PTN_ROAD_ADDR C, PTN_PARKING D, PTN_OFFDAY_DATE E, PTN_WORK_HOUR_REGULAR F
WHERE LEFT(TILE_ID,4) = B.MAP_ID
AND B.관할업체 = '티아이랩'
AND A.POI_ID = C.POI_ID
AND A.POI_ID = D.POI_ID
AND A.POI_ID = E.POI_ID
AND A.POI_ID = F.POI_ID
AND REPLACE(A.FNAME,'/','') IN ('60계치킨', 'AK플라자', 'BHC치킨', 'CGV', 'CU', 'GS25', 'KFC', 'NC백화점', '갤러리아백화점', '공임나라', '공차', '굽네치킨',
'기아오토큐', '기아', '나인블럭', '노브랜드버거', '다이소', '달콤커피', '던킨', '도미노피자', '뚜레쥬르', '롯데리아', '롯데마트', '롯데백화점', '롯데시네마',
'롯데아울렛', '마일레오토서비스', '만도플라자', '맘스터치', '맥도날드', '메가박스', '메가MGC커피', '미스터피자', '바나프레소', '배스킨라빈스31', '현대블루핸즈', '빕스', 
'빽다방', '상무초밥', '샤브20', '샤브마니아', '세븐일레븐', '소담촌', '쉐이크쉑', '스타벅스', '스피드메이트', '신세계백화점', '쌍교숯불갈비', '써브웨이', '씨스페이스',
'아웃백스테이크하우스', '아파트지인', '엔제리너스커피', '오봉집', '오토오아시스', '이디야', '이마트', '이마트24', '이마트에브리데이', '이차돌', '제주은희네해장국',
'짬뽕지존', '채선당', '초중고', '카페베네', '커피빈', '컴포즈커피', '코스트코홀세일', '탐앤탐스', '투썸플레이스', '트레이더스홀세일클럽', '파리바게뜨', '파스쿠찌',
'폴바셋', '프랭크버거', '피자헛', '하나로마트', '할리스커피', '현대백화점', '현대프리미엄아울렛', '현대자동차', '홈플러스', '홈플러스익스프레스')
ORDER BY A.POI_ID

/*
    2. 1번에서 나오지 않은 대상 출력 (PTN_PARKING , PTN_OFFDAY_DATE, PTN_WORK_HOUR_REGULAR 테이블과 조인 없이)
*/
SELECT A.POI_ID, A.FNAME, A.CNAME, '','', A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR, A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D,
C.ADDRESS, C.BULD_MNNM, C.BULD_SLNO, ''
FROM vPOI_I_COMMON_ALL_GRS A, POI_MAIN_ETC..[22y_2150_INDEX_220401] B, PTN_ROAD_ADDR C
WHERE LEFT(TILE_ID,4) = B.MAP_ID
AND A.POI_ID = C.POI_ID
AND B.관할업체 = '티아이랩'
AND REPLACE(A.FNAME,'/','') IN ('60계치킨', 'AK플라자', 'BHC치킨', 'CGV', 'CU', 'GS25', 'KFC', 'NC백화점', '갤러리아백화점', '공임나라', '공차', '굽네치킨',
'기아오토큐', '기아', '나인블럭', '노브랜드버거', '다이소', '달콤커피', '던킨', '도미노피자', '뚜레쥬르', '롯데리아', '롯데마트', '롯데백화점', '롯데시네마',
'롯데아울렛', '마일레오토서비스', '만도플라자', '맘스터치', '맥도날드', '메가박스', '메가MGC커피', '미스터피자', '바나프레소', '배스킨라빈스31', '현대블루핸즈', '빕스', 
'빽다방', '상무초밥', '샤브20', '샤브마니아', '세븐일레븐', '소담촌', '쉐이크쉑', '스타벅스', '스피드메이트', '신세계백화점', '쌍교숯불갈비', '써브웨이', '씨스페이스',
'아웃백스테이크하우스', '아파트지인', '엔제리너스커피', '오봉집', '오토오아시스', '이디야', '이마트', '이마트24', '이마트에브리데이', '이차돌', '제주은희네해장국',
'짬뽕지존', '채선당', '초중고', '카페베네', '커피빈', '컴포즈커피', '코스트코홀세일', '탐앤탐스', '투썸플레이스', '트레이더스홀세일클럽', '파리바게뜨', '파스쿠찌',
'폴바셋', '프랭크버거', '피자헛', '하나로마트', '할리스커피', '현대백화점', '현대프리미엄아울렛', '현대자동차', '홈플러스', '홈플러스익스프레스')
ORDER BY A.POI_ID

/*
   3. 2번에서 출력한 대상들의 PTN_PARKING , PTN_OFFDAY_DATE, PTN_WORK_HOUR_REGULAR 반영 값 조회
*/

SELECT A.POI_ID, A.FNAME, A.CNAME, '','', A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR, A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D,
B.ADDRESS, B.BULD_MNNM, B.BULD_SLNO,'', C.PARKING_YN, '', '' ,'' ,'' ,'', '', '','','','','','',''
FROM vPOI_I_COMMON_ALL_GRS A, PTN_ROAD_ADDR B, PTN_PARKING C
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID IN ()
ORDER BY A.POI_ID

SELECT A.POI_ID, A.FNAME, A.CNAME, '','', A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR, A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D,
B.ADDRESS, B.BULD_MNNM, B.BULD_SLNO, '', '', C.DATE, '', '', '', '', '', '','','','','','',''
FROM vPOI_I_COMMON_ALL_GRS A, PTN_ROAD_ADDR B, PTN_OFFDAY_DATE C
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID IN ()
ORDER BY A.POI_ID

SELECT A.POI_ID, A.FNAME, A.CNAME, '','', A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR, A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D,
B.ADDRESS, B.BULD_MNNM, B.BULD_SLNO, '', '', '', C.WEEKDAY, C.ST_HOUR, C.ST_MIN, C.ED_HOUR, C.ED_MIN, '','','','','','',''
FROM vPOI_I_COMMON_ALL_GRS A, PTN_ROAD_ADDR B, PTN_WORK_HOUR_REGULAR C
WHERE A.POI_ID = B.POI_ID
AND A.POI_ID = C.POI_ID
AND A.POI_ID IN ()
ORDER BY A.POI_ID

/*
   4. 3번에서도 안 나온 대상의 명칭을 바꿔서 재 출력
*/
SELECT POI_ID, PARKING_YN
FROM PTN_PARKING

SELECT POI_ID, DATE
FROM PTN_OFFDAY_DATE

SELECT POI_ID, WEEKDAY, ST_HOUR, ST_MIN, ED_HOUR, ED_MIN
FROM PTN_WORK_HOUR_REGULAR
WHERE POI_ID IN 
(
SELECT DISTINCT A.POI_ID , A.FNAME, A.CNAME, '','', A.ADDR, A.PRIMARY_BUN, A.SECONDARY_BUN, A.SAN_BUN, A.IFLOOR, A.TELE_A, A.TELE_B, A.TELE_C, A.TELE_D,
C.ADDRESS, C.BULD_MNNM, C.BULD_SLNO, '', '', '', '', '', '', '', '', '','','','','','',''
FROM vPOI_I_COMMON_ALL_GRS A, POI_MAIN_ETC..[22y_2150_INDEX_220401] B, PTN_ROAD_ADDR C
WHERE LEFT(TILE_ID,4) = B.MAP_ID
AND A.POI_ID = C.POI_ID
AND B.관할업체 = '티아이랩'
AND A.FNAME = ''
 ORDER BY A.POI_ID
)
ORDER BY POI_ID