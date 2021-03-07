
alter procedure sp_insertDrugs(
                     @json varchar(max)
                   , @PDCId int OUTPUT              
                   )
as 
begin
    DECLARE @PDCJSON as VARCHAR(MAX);
    DECLARE @ODCnJSON as VARCHAR(MAX);

    set @PDCJSON =   JSON_QUERY(@json, '$.PDC[0]')
    exec sp_insertDrug @DrugJSON = @PDCJSON
    						,@concernRank = 1
                , @drugOfConcernId = @PDCId output
  
    set @ODCnJSON = JSON_QUERY(@json, '$.ODC')
    if @ODCnJSON is null
      RETURN

    DECLARE @t TABLE (OtherSubstancesConcernGambling nvarchar(100), AgeFirstUsed int,
                    AgeLastUsed int, MethodOfUse NVARCHAR(50), DaysInLast28 CHAR(5), 
                    HowMuchPerOccasion NVARCHAR(25), Units VARCHAR(20)
                    , Goals VARCHAR(100), Concern tinyint);

    insert into @t
   SELECT  OtherSubstancesConcernGambling, AgeFirstUsed,  AgeLastUsed, MethodOfUse
            , DaysInLast28,  HowMuchPerOccasion, Units, Goals
            , ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Concern
        FROM OPENJSON(@ODCnJSON)
        WITH (
            OtherSubstancesConcernGambling NVARCHAR(100) '$.OtherSubstancesConcernGambling',
            AgeFirstUsed INT '$.AgeFirstUsed',        
            AgeLastUsed int '$.AgeLastUsed',
            MethodOfUse NVARCHAR(50) '$.MethodOfUse',
            DaysInLast28 VARCHAR(5) '$.DaysInLast28',        
            HowMuchPerOccasion NVARCHAR(25) '$.HowMuchPerOccasion',        
            Units NVARCHAR(20) '$.Units',
            Goals NVARCHAR(100) '$.Goals'
        );
        
    DECLARE @IDs TABLE(ID INT);
    insert into DrugOfConcern
        (          
          DrugId, MethodOfUseId, DrugUnitId, ConcernRank, 
          AgeFirstUsed, AgeLastUsed, DaysInlast28, GoalId
        )
      OUTPUT inserted.ID INTO @IDs(ID)
      select 
              --DrugId:
            (select ID from lk_Drugs where Name = OtherSubstancesConcernGambling),
            --MethodOfUseId:
            (select ID from lk_MethodOfUse where Name = MethodOfUse),        
            -- Units
            (select ID from lk_DrugUnit where Name = Units),
            Concern + 1,
            AgeFirstUsed,
            AgeLastUsed,
            cast (DaysInLast28 as tinyint),
            -- Goals
            (select ID from lk_DrugUseGoal where Name = Goals)
    from @t;

   select * from @IDs;

END

-- select * from DrugOfConcern

-- declare @json varchar(max);

-- set @json = '{
--   "ODC": [
--     {},
--     {
--       "AgeFirstUsed": 15,
--       "AgeLastUsed": 34,
--       "DaysInLast28": "16",
--       "Goals": "Cease Use",
--       "HowMuchPerOccasion": "1",
--       "MethodOfUse": "Smoke",
--       "OtherSubstancesConcernGambling": "Cannabinoids and related drugs",
--       "Units": "grams"
--     },

--     {
--       "AgeFirstUsed": 15,
--       "AgeLastUsed": 3,
--       "DaysInLast28": "18",
--       "Goals": "Reduce Harms",
--       "HowMuchPerOccasion": "7",
--       "MethodOfUse": "Smoke",
--       "OtherSubstancesConcernGambling": "Nicotine",
--       "Units": "cigarettes / darts"
--     },

--     {
--       "AgeFirstUsed": 30,
--       "AgeLastUsed": 34,
--       "DaysInLast28": "28",
--       "Goals": "Cease Use",
--       "HowMuchPerOccasion": "10",
--       "MethodOfUse": "Ingest",
--       "OtherSubstancesConcernGambling": "Benzodiazepines",
--       "Units": "dosage (mgs)"
--     },
--     {
--       "AgeFirstUsed": 20,
--       "AgeLastUsed": 22,
--       "DaysInLast28": "0",
--       "Goals": "No Goals - Ceased Use",
--       "HowMuchPerOccasion": "1",
--       "MethodOfUse": "Ingest",
--       "OtherSubstancesConcernGambling": "Amphetamines",
--       "Units": "points"
--     },
--     {
--       "AgeFirstUsed": 21,
--       "AgeLastUsed": 23,
--       "DaysInLast28": "0",
--       "Goals": "No Goals - Ceased Use",
--       "HowMuchPerOccasion": "1",
--       "MethodOfUse": "Ingest",
--       "OtherSubstancesConcernGambling": "Psychostimulants",
--       "Units": "pills"
--     }
--   ],

--   "PDC": [
--     {
--       "PDCAgeFirstUsed": 17,
--       "PDCAgeLastUsed": 34,
--       "PDCDaysInLast28": "16",
--       "PDCGoals": "Reduce Use",
--       "PDCHowMuchPerOccasion": "15-19",
--       "PDCMethodOfUse": "Ingest",
--       "PDCSubstanceOrGambling": "Alcohol",
--       "PDCUnits": "standard drinks"
--     }
--   ]
-- }'