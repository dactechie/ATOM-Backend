
ALTER procedure sp_insertDrugs(
                    @surveyId as int
                   , @json varchar(max))
as 
begin
    DECLARE @PDCJSON as VARCHAR(MAX);
    DECLARE @ODCnJSON as VARCHAR(MAX);
    DECLARE @i as int;
    DECLARE @rank as tinyint;

    set @rank = 1;

    set @PDCJSON =   JSON_QUERY(@json, '$.PDC[0]')
    exec sp_insertDrug  @surveyId = @surveyId
    						,@DrugJSON = @PDCJSON
    						,@concernRank = @rank

    set @rank = 2;
    DECLARE @str as VARCHAR (20);
    set @i = 0;

    while @i < 5 
    begin
        set @ODCnJSON =   JSON_QUERY(@json, N'strict $.ODC['+   cast( @i  as varchar(1))  + ']');      
        if @ODCnJSON = '{}'
        begin
          set @i = @i +1
          continue
        end
  
        exec sp_insertDrug  @surveyId = @surveyId
              ,@DrugJSON = @ODCnJSON
              ,@concernRank = @rank

        set @rank = @rank + 1;
        set @i = @i + 1;
    end

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