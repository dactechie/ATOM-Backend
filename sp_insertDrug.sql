alter PROCEDURE sp_insertDrug(
						@surveyId int
						,@DrugJSON nvarchar(max)
						,@concernRank tinyint
						)
as 
begin 
	 DECLARE @DrugKey as varchar(40);
	 DECLARE @MethodOfUseKey as varchar(40); 
	 set @MethodOfUseKey =   'MethodOfUse';
	 DECLARE @DaysInLast28Key  as varchar(40); set  @DaysInLast28Key =  'DaysInLast28';
	 DECLARE @UnitsKey  as varchar(40); set  @UnitsKey =   'Units';
	 DECLARE @HowMuchPerOccasionKey  as varchar(40); set @HowMuchPerOccasionKey = 'HowMuchPerOccasion';
	 DECLARE @AgeFirstUsedKey  as varchar(40); set @AgeFirstUsedKey  =   'AgeFirstUsed';
	 DECLARE @AgeLastUsedKey  as varchar(40); set @AgeLastUsedKey =   'AgeLastUsed';
	 DECLARE @GoalKey  as varchar(40); set @GoalKey =   'Goals';

	 if @DrugJSON is null
	 begin
		return -1
	 end
	 if @concernRank = 1
	 begin
		 set @DrugKey = 'PDCSubstanceOrGambling';
		 set @MethodOfUseKey = 'PDC' + @MethodOfUseKey;
		 set @DaysInLast28Key = 'PDC' + @DaysInLast28Key;
		 set @UnitsKey = 'PDC' + @UnitsKey;
		 set @HowMuchPerOccasionKey = 'PDC' + @HowMuchPerOccasionKey;
		 set @AgeFirstUsedKey = 'PDC' + @AgeFirstUsedKey;
		 set @AgeLastUsedKey = 'PDC' + @AgeLastUsedKey;
		 set @GoalKey = 'PDC' + @GoalKey;
	 end
	 else
	     set @DrugKey ='OtherSubstancesConcernGambling'

	  DECLARE @drug as varchar(150)
	  DECLARE @methodOfUse as varchar(50)
	  DECLARE @units as varchar(30)
	  DECLARE @howMuchPerOccasion as varchar(30)
	  
	  DECLARE @ageFirstUsed as tinyint
	  DECLARE @ageLastUsed as tinyint
	  DECLARE @daysInLast28 as varchar(2)
	  DECLARE @goal as varchar(20)

	  set @drug =  JSON_VALUE(@DrugJSON, '$."' + @DrugKey + '"')
	  set @methodOfUse =  JSON_VALUE(@DrugJSON, '$."' + @MethodOfUseKey + '"')
	  set @units =  JSON_VALUE(@DrugJSON, '$."' + @UnitsKey + '"')
	  set @howMuchPerOccasion =  JSON_VALUE(@DrugJSON, '$."' + @HowMuchPerOccasionKey + '"')
	  set @ageFirstUsed =  JSON_VALUE(@DrugJSON, '$."' + @AgeFirstUsedKey + '"')
	  set @ageLastUsed =  JSON_VALUE(@DrugJSON, '$."' + @AgeLastUsedKey + '"')
	  set @daysInLast28 =  JSON_VALUE(@DrugJSON, '$."' + @DaysInLast28Key + '"')
	  set @goal =  JSON_VALUE(@DrugJSON, '$."' + @GoalKey + '"')
	  
    -- TODO
    -- if @concernRank = 1
    -- BEGIN
    --   update Survey
    --     set PDC = @drug,
    --         PDCMethodOfUse = @methodOfUse,
    --         PDCUnits = @units,
    --         PDCHowMuchPerOccasion = @howMuchPerOccasion,
    --         PDCGoal = @goal
    --   where ID = @surveyId
    -- END

	  insert into DrugOfConcern
	  (
      SurveyId,
      DrugId, MethodOfUseId, DrugUnitId, ConcernRank, 
      AgeFirstUsed, AgeLastUsed, DaysInlast28, GoalId
    )
    values
	  (
        @surveyId,
        --DrugId:
        (select ID from DrugType where Name = @drug),
        --MethodOfUseId:
        (select ID from MethodOfUseTypes where Name = @methodOfUse),        
        -- Units
        (select ID from DrugUnitTypes where Name = @units),
        @concernRank,
        @ageFirstUsed,
        @ageLastUsed,
        cast (@daysInLast28 as tinyint),
        -- Goals
        (select ID from DrugUseGoalTypes where Name = @goal)
	  )

	return 0;
end