/***************************************
	- 제     목: 야놀자검출쿼리
	- 최초작성일: -
	- 최초작성자: 최보름과장
	- 특이사항
	 -- DB명: CP_TILAB_NEW
****************************************/

USE CP_TILAB_NEW

--매칭된 대상 18.662건
SELECT *
FROM (
     SELECT row_number() over(partition BY a.POI_ID ORDER BY b.LDGS_CD ASC) RN, *
   FROM [dbo].[원도_숙박종별_231025] AS a LEFT JOIN [dbo].[야놀자DATA_9월_원도재매칭_231025] as b
   ON a.ADDR = b.주소 AND a.PRIMARY_BUN = b.주번 AND a.SECONDARY_BUN = b.부번
   WHERE LDGS_CD IS NOT NULL) aa
   WHERE aa.RN = 1 

 --미매칭 대상(매칭 고도화 작업 필요한 대상) 31,542건
   SELECT *
   FROM [dbo].[원도_숙박종별_231025]  a LEFT JOIN [dbo].[야놀자DATA_9월_원도재매칭_231025] b
   ON a.ADDR = b.주소 AND a.PRIMARY_BUN = b.주번 AND a.SECONDARY_BUN = b.부번

   where LDGS_CD IS NULL  
