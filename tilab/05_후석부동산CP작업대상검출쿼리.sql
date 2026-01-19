/***************************************
	- 제     목: 후석부동산CP 작업대상 검출 쿼리
	- 최초작성일: 2024-05-08
	- 최초작성자: 최명원
	- 최종수정일: 2024-07-22
	- 최종작성자: 최명원
	- 특이사항
	 -- SERVER 명: 10.5.239.167
             -- SERVER 명: partners
             -- PASSWORD 명: partners!1
****************************************/

-- DB명: MCP_REALESTATE

USE MCP_REALESTATE

SELECT * FROM MCP_REALESTATE_WORKLIST
WHERE B_LARGE IN ('대전광역시','세종특별자치시','충청남도','충청북도')
ORDER BY WORKLIST_GEN_DATE DESC
