**Navigation POI Data Engineering & Management (T-SQL)**
1. H사 및 K사 자동차 서비스 네트워크 및 주요 프랜차이즈 브랜드의 POI(Point of Interest) 데이터를 정제
2. 내비게이션 데이터베이스의 정합성을 확보하기 위한 Data Cleansing 및 ETL 쿼리 모음

**Project Overview**
1. 목적: 전국 단위 대규모 POI 데이터 중 특정 서비스망(H사 및 K사) 및 핵심 브랜드 데이터의 추출, 표준화 및 품질 관리
2. 환경: Microsoft SQL Server
3. 주요 대상: 자동차 서비스 거점(지정공장, 부분정비, 상용 거점), 대형 프랜차이즈 브랜드 등

**Key Responsibilities & Technical Achievements**
1. 데이터 표준화 및 텍스트 마이닝 (Data Cleansing)
 - 원천 데이터 명칭(FNAME, CNAME)에 포함된 불필요한 태그([상용], 부분정비, 지정공장 등)와 특수문자를 중첩 함수를 사용하여 일괄 제거
 - 사용자 검색 효율성을 극대화하기 위해 명칭 정제 로직을 설계하여 데이터 가독성 100% 확보
2. 복합 부가정보 무결성 검증 (QA & Validation)
 - POI 기본 정보와 부가정보(주차 여부, 정기 휴무일, 영업시간) 간의 관계를 분석하여 누락 데이터(NULL) 식별
 - INNER JOIN과 LEFT JOIN 전략을 병행하여 정보 미등록 대상에 대한 전수 조사 및 예외 처리 쿼리 구현
3. 성능 최적화 및 SARGable Query 설계
 - TILE_ID와 같은 대량 데이터 조인 시, 함수 가공(LEFT, SUBSTRING) 대신 Index Seek를 유도하는 LIKE 패턴 매칭을 적용하여 쿼리 성능 개선
 - 운영 환경의 동시성 확보를 위해 WITH (NOLOCK) 힌트를 적용하여 데이터 조회 시 데드락(Deadlock) 위험 최소화
4. 데일리 데이터 파이프라인 관리
- 일일 단위로 생성되는 LINK-POI 관계 테이블(LINK_POI_REL_YYYYMMDD)을 통합 관리
- UNION ALL 및 Dynamic SQL을 활용하여 다수의 시계열 테이블을 효율적으로 통합 조회하고 중복을 제거하는 로직 구축
