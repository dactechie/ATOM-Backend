



DECLARE @all NVARCHAR(MAX);


--set @all = '{"asd":1, "Past4WkEngagedInOtheractivities":{"Paid Work":{"Frequency":"Not at all","Days":"4"}}}'

--exec sp_insertClientEngagement @surveyId =1 ,@fullJSON = @all

--select * from ClientEngagement

-- "Units": "cones / joints"
   --"Units": "points",

set @all= 
'{"ClientType":"ownuse","PDC":[{"PDCSubstanceOrGambling":"Alcohol","PDCMethodOfUse":"Ingest","PDCDaysInLast28":"15","PDCUnits":"standard drinks","PDCHowMuchPerOccasion":"4","PDCGoals":"Reduce Use", "PDCAgeFirstUsed": 9,"PDCAgeLastUsed": 11}],"Anyodc": "yes","ODC":[
    {
    "OtherSubstancesConcernGambling": "Amphetamines",
    "MethodOfUse": "Inject",
    "DaysInLast28": "9",
 
    "HowMuchPerOccasion": "30-39",
    "AgeFirstUsed": 11,
    "AgeLastUsed": 22
    },
    {
    "OtherSubstancesConcernGambling": "MDMA / Ecstacy",
    "MethodOfUse": "Transdermal",
    "DaysInLast28": "15",
    "Units": "Standard Drinks"
    },
    {},
    {},
    {}
  ]
}'

-- Msg 13608, Level 16, State 2, Procedure sp_insertDrugs, Line 25
-- Property cannot be found on the specified JSON path. 

DECLARE @PDCJSON NVARCHAR(MAX);
DECLARE @ODCsJSON NVARCHAR(MAX);
DECLARE @PDCId int;

		-- set @PDCJSON =   JSON_QUERY(@all, '$.PDC[0]')
		--select @PDCJSON
		-- exec sp_insertDrug  @surveyId = 2
		-- 						,@DrugJSON = @PDCJSON
		-- 						,@concernRank =1

declare @OtherDrugsOfConcernIDsTable table(DrugOfConcernID int)
insert @OtherDrugsOfConcernIDsTable
EXEC sp_insertDrugs  @json = @all	, @PDCId= @PDCId output		

select @PDCId;

select * from @OtherDrugsOfConcernIDsTable
---- delete from DrugOfConcern
-- select * from DrugOfConcern






-- set @datestring =  SUBSTRING(@SLK, 6, 8)
-- select CONVERT(
--   date,
--   SUBSTRING(@datestring, 5, 4) + SUBSTRING(@datestring, 3, 2) + SUBSTRING(@datestring, 1, 2)
-- )

--DECLARE @all1 NVARCHAR(MAX);
--set @all1 = JSON_VALUE(@all, '$.DoYouFeelSafeWhereYouLive');
--select F.ID from dbo.lk_DegreesOfSafety F where F.Name = @all1

DECLARE @ret int;



exec  sp_insertRecentLifestyleImpactConcern @json=@all, @insertedId=@ret output


select @ret


--select * from lk_DegreesOfSafety
select * from  RecentLifestyleImpactConcern;
