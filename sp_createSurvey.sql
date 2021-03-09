ALTER PROCEDURE sp_createSurvey
     (
     @SurveyJSON nvarchar(MAX),
     @ClientID int,
     @AssessType varchar(40),
     @Program varchar(15),
     @SurveyID int output)     
as 
begin
     -- resources : https://www.sqlshack.com/how-to-implement-error-handling-in-sql-server/
     -- BEGIN TRY

     DECLARE @IDs TABLE(ID INT);
     DECLARE @aDate VARCHAR(14), @assessmentDate date;
     DECLARE @team VARCHAR(10), @programId smallint;     
     DECLARE @cType VARCHAR(10), @clientType tinyint;
     DECLARE @assessmentType TINYINT;
     DECLARE @haveEverInjected VARCHAR(10),
          @custodialSenten VARCHAR(10), @everDiagMental VARCHAR(10);

     -- not in the JSON ?
     
     set @programId  = (select ID from lk_Program where Name = @Program);
     set @aDate = JSON_VALUE(@SurveyJSON, '$.AssessmentDate');
     set @assessmentDate = CONVERT(DATE, @aDate, 102);

     select @SurveyID = S.ID
     from Survey S
     where S.ClientId = @ClientID AND --composite key with the below predicates        
          S.AssessmentDate = @assessmentDate AND
          S.ProgramId = @programId

     IF @SurveyID is not null
     begin
          print 'Survey ID was not null ' + @SurveyID
		RETURN
     end

     set @assessmentType = case when @AssessType like '%Initial%' then 1 else 2 END;
     set @cType = JSON_VALUE(@SurveyJSON, '$.ClientType');
     select @clientType = case when @cType = 'ownuse' then 1 else 2 end;
     --   set @whenMentalDiag = JSON_VALUE(@SurveyJSON, '$.WhenMentalHealthDiagnosis');
     set @haveEverInjected = JSON_VALUE(@SurveyJSON, '$.HaveYouEverInjected');
     set @custodialSenten = JSON_VALUE(@SurveyJSON, '$.HaveYouServedCustodialSentenceInPast');
     set @everDiagMental = JSON_VALUE(@SurveyJSON, '$.EverDiagnosedMentalHealthIssue');

     BEGIN TRANSACTION
          insert into Survey
               (ClientId, AssessmentType, AssessmentDate, ClientType, ProgramId,
               HaveYouEverInjected, HaveYouServedCustodialSentenceInPast,
               EverDiagnosedMentalHealthIssue)
          OUTPUT inserted.ID INTO @IDs(ID)
          values
               (
               @ClientID, @assessmentType, @assessmentDate, @clientType, @programId,
               case when @haveEverInjected ='No' then 0 
                    when @haveEverInjected is not null then 1 end,
               case when @custodialSenten ='No' then 0 
                    when @custodialSenten is not null then 1 end,
               case when @everDiagMental ='No' then 0 
                    when @everDiagMental is not null then 1 end
               );

          -- OUTPUT variable is ready
          SELECT @SurveyID = ID FROM @IDs;

          -- DRUGS of concern are many-to-one and require SurveyID
          -- which we have now

          declare @OtherDrugsOfConcernIDsTable table(DrugOfConcernID int);
          DECLARE @PDCId int;

          insert @OtherDrugsOfConcernIDsTable
          EXEC sp_insertDrugs  @json = @SurveyJSON,  @PDCId = @PDCId output;

          update DrugOfConcern
          set SurveyID = @SurveyID
          where ID in (
                    select ID
                    from @OtherDrugsOfConcernIDsTable)
               or ID = @PDCId;

          -- for easy stats
          insert into PrincipalDrugOfConcern
               (ClientId, SurveyId, PDCDrugId)
          values
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