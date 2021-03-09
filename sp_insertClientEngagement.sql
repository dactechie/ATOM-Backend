CREATE PROCEDURE sp_insertClientEngagement(
						@surveyId int
						,@fullJSON nvarchar(max)
						)
as 
begin 
	 DECLARE @engagementJSON NVARCHAR(MAX);
	 set @engagementJSON =   JSON_QUERY(@fullJSON, '$.Past4WkEngagedInOtheractivities')
	 if @engagementJSON is null
      return
	
    DECLARE @EngagementFrequency nvarchar(30)
            , @EngagementDays nvarchar(5)
            , @EngagementDaysInt tinyint
            , @EngagementType varchar(50);
    DECLARE @EngagementTypes table(idx int identity(1,1), [Name] varchar(50))              
    declare @i int = 0,  @cnt INT = 0;

    insert into @EngagementTypes ([Name])
      select 'Paid Work' union
      select 'Voluntary Work' union
      select 'Study - college, school or vocational education' union
      select 'Looking after children' union
      select 'Other caregiving activities'

    select @i = min(idx) - 1, @cnt = max(idx) from @EngagementTypes

    while @i < @cnt
    begin 
      select @i = @i + 1
      set @EngagementType = (select Name from @EngagementTypes where idx = @i)		
      set @EngagementDays =  JSON_VALUE(@engagementJSON, '$."' + @EngagementType + '".Days') 

      if @EngagementDays is not null     
        set @EngagementDaysInt = cast (@EngagementDays as tinyint)
	  
  	  set @EngagementFrequency = JSON_VALUE(@engagementJSON, '$."' + @EngagementType + '".Frequency')

      if @EngagementFrequency is not null or @EngagementDaysInt is not null		
        insert into ClientEngagement ( 
						SurveyId,
						EngagementTypeId, EngagementDays, EngagementFrequency) values 
          (
            @surveyId,
            (select ID from lk_Engagement where Name = @EngagementType),
            @EngagementDaysInt,
            (select F.Score from lk_FrequencyHighGood F where F.Name = @EngagementFrequency)
          )
	
	  set @EngagementFrequency = null;
	  set @EngagementDaysInt = null;
	end
end