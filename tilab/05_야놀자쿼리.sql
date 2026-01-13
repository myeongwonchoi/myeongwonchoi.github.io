/***************************************
	- 제     목: 야놀자검출쿼리
	- 최초작성일: -
	- 최초작성자: 최보름과장
	- 특이사항
	 -- DB명: CP_TILAB_NEW
****************************************/

use CP_TILAB_NEW

--매칭된 대상 18.662건
select *
from (
     select row_number() over(partition by a.POI_ID order by b.LDGS_CD asc) RN, *
   from [dbo].[원도_숙박종별_231025] as a left join [dbo].[야놀자DATA_9월_원도재매칭_231025] as b
   on a.ADDR = b.주소 and a.PRIMARY_BUN = b.주번 and a.SECONDARY_BUN = b.부번
   where LDGS_CD is not null) aa
   where aa.RN = 1 

 --미매칭 대상(매칭 고도화 작업 필요한 대상) 31,542건
   select *
   from [dbo].[원도_숙박종별_231025]  a left join [dbo].[야놀자DATA_9월_원도재매칭_231025] b
   on a.ADDR = b.주소 and a.PRIMARY_BUN = b.주번 and a.SECONDARY_BUN = b.부번
   where LDGS_CD is null  