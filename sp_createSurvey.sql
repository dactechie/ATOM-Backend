ALTER PROCEDURE sp_createSurvey ( @SurveyJSON nvarchar(MAX), @ClientID int, @SurveyID int output)
as 
begin
     -- resources : https://www.sqlshack.com/how-to-implement-error-handling-in-sql-server/
-- BEGIN TRY

  DECLARE @IDs TABLE(ID INT);
  DECLARE @aDate VARCHAR(14), @assessmentDate date;
  DECLARE @team VARCHAR(10), @programId smallint;           -- not in the JSON ?
  set @programId  = 1; -- TSS   

  set @aDate = JSON_VALUE(@SurveyJSON, '$.AssessmentDate'); -- convert to date 
  set @assessmentDate = CONVERT(DATE, @aDate, 102);

  select @SurveyID = S.ID from Survey S 
      where S.ClientId = @ClientID AND  --composite key with the below predicates        
            S.AssessmentDate = @assessmentDate AND
            S.ProgramId = @programId

	IF @SurveyID is not null
		RETURN

  -- if survey with same Assessmentdate and ClientId exists.. return

  DECLARE @cType VARCHAR(10), @clientType tinyint;
  DECLARE @assessmentType TINYINT;                               -- not in the JSON ?
  DECLARE @haveEverInjected VARCHAR(10),
          @custodialSenten VARCHAR(10), @everDiagMental VARCHAR(10);
  
  set @assessmentType = 1;  -- initial assessement
  
  set @cType = JSON_VALUE(@SurveyJSON, '$.ClientType');
  select @clientType = case when @cType = 'ownuse' then 1 else 2 end;

--   set @whenMentalDiag = JSON_VALUE(@SurveyJSON, '$.WhenMentalHealthDiagnosis');
  set @haveEverInjected = JSON_VALUE(@SurveyJSON, '$.HaveYouEverInjected');
  set @custodialSenten = JSON_VALUE(@SurveyJSON, '$.HaveYouServedCustodialSentenceInPast');
  set @everDiagMental = JSON_VALUE(@SurveyJSON, '$.EverDiagnosedMentalHealthIssue');

     BEGIN TRANSACTION
          insert into Survey (ClientId, AssessmentType, AssessmentDate, ClientType, ProgramId,                       
                              HaveYouEverInjected, HaveYouServedCustodialSentenceInPast, 
                              EverDiagnosedMentalHealthIssue) 	
               OUTPUT inserted.ID INTO @IDs(ID)
               values (
                    @ClientID,  @assessmentType,  @assessmentDate,  @clientType, @programId,      
               case when @haveEverInjected ='No' then 0 
                    when @haveEverInjected is not null then 1 end,
               case when @custodialSenten ='No' then 0 
                    when @custodialSenten is not null then 1 end,
               case when @everDiagMental ='No' then 0 
                    when @everDiagMental is not null then 1 end
               );

               SELECT @SurveyID = ID FROM @IDs;   -- OUTPUT is ready

               -- DRUGS of concern are many-to-one and require SurveyID
               -- which we have now
               
               declare @OtherDrugsOfConcernIDsTable table(DrugOfConcernID int);
               DECLARE @PDCId int;

               insert @OtherDrugsOfConcernIDsTable
               EXEC sp_insertDrugs  @json = @SurveyJSON,  @PDCId= @PDCId output;

               update DrugOfConcern
                    set SurveyID = @SurveyID
               where ID in (select * from @OtherDrugsOfConcernIDsTable) 
                         or ID = @PDCId;

               -- for easy stats
               insert into PrincipalDrugOfConcern 
                    (ClientId, SurveyId, PDCDrugId) values 
                    (@ClientID, @SurveyID, @PDCId)
     COMMIT TRANSACTION
--   END TRY
--   BEGIN CATCH
--      PRINT 'An Error Occurred, inside catch block'
--      -- Transaction uncommittable
--      IF (XACT_STATE()) = -1
--           ROLLBACK TRANSACTION
     
--      -- Transaction committable
--      IF (XACT_STATE()) = 1
--           COMMIT TRANSACTION

--      -- DECLARE @Message varchar(MAX) = ERROR_MESSAGE(),
--      --      @Severity int = ERROR_SEVERITY(),
--      --      @State smallint = ERROR_STATE()
     
--      -- RAISEERROR (@Message, @Severity, @State)
--   END CATCH
END