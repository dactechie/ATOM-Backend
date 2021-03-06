CREATE PROCEDURE sp_createSurvey ( @SurveyJSON nvarchar(MAX), @ClientID int, @SurveyID int output)
as 
begin

  DECLARE @IDs TABLE(ID INT);
  DECLARE @aDate VARCHAR(14), @assessmentDate date;
  DECLARE @team VARCHAR(10), @programId smallint;           -- not in the JSON ?
  set @programId  = 1; -- TSS   

  set @aDate = JSON_VALUE(@SurveyJSON, '$.AssessmentDate'); -- convert to date 

  select @SurveyID = S.ID from Survey S 
      where S.ClientId = @ClientID AND  --composite key with the below predicates        
            S.AssessmentDate = @assessmentDate AND
            S.ProgramId = @programId

	IF @SurveyID is not null
		RETURN

  -- if survey with same Assessmentdate and ClientId exists.. return

  DECLARE @cType VARCHAR(10), @clientType tinyint;
  DECLARE @assessmentType TINYINT;                               -- not in the JSON ?
  
  DECLARE @pdcDrug VARCHAR(50), @pdcDrugId smallint;
  DECLARE @whenMentalDiag VARCHAR(50), @haveEverInjected VARCHAR(10),
          @custodialSenten VARCHAR(10), @everDiagMental VARCHAR(10);
  
  set @assessmentType = 1;  -- initial assessement
  
  set @cType = JSON_VALUE(@SurveyJSON, '$.ClientType');
  select @clientType = case when @cType = 'ownuse' then 1 else 2 end;
  
  set @pdcDrug = JSON_VALUE(@SurveyJSON, N'strict $.PDC[0].' + 'PDCSubstanceOrGambling');
  
  set @whenMentalDiag = JSON_VALUE(@SurveyJSON, '$.WhenMentalHealthDiagnosis');
  set @haveEverInjected = JSON_VALUE(@SurveyJSON, '$.HaveYouEverInjected');
  set @custodialSenten = JSON_VALUE(@SurveyJSON, '$.HaveYouServedCustodialSentenceInPast');
  set @everDiagMental = JSON_VALUE(@SurveyJSON, '$.EverDiagnosedMentalHealthIssue');

  insert into Survey (ClientId,AssessmentType, AssessmentDate, ClientType, ProgramId,
                       PDCDrugId ,PDCAgeFirstUsed, WhenMentalHealthDiagnosisId,
                       HaveYouEverInjected, HaveYouServedCustodialSentenceInPast, 
                       EverDiagnosedMentalHealthIssue) 	
      OUTPUT inserted.ID INTO @IDs(ID)
	values (
          @ClientID,  @assessmentType,  @assessmentDate,  @clientType, @programId,
      
          (select ID from lk_Drugs where Name = @pdcDrug),
          cast (
               JSON_VALUE(@SurveyJSON, N'strict $.PDC[0].' + 'PDCAgeFirstUsed') as tinyint),
          (select ID from lk_HowLongAgo where Name = @whenMentalDiag),      
      
      case when @haveEverInjected ='No' then 0 
           when @haveEverInjected is not null then 1 end,
      case when @custodialSenten ='No' then 0 
           when @custodialSenten is not null then 1 end,
      case when @everDiagMental ='No' then 0 
           when @everDiagMental is not null then 1 end
     );

     SELECT @SurveyID = ID FROM @IDs;

END