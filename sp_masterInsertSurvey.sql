ALTER PROCEDURE sp_createAll
     (
     @SurveyJSON nvarchar(MAX),     
     @SurveyID int output)
as 
begin
     DECLARE @ClientID int , @SLK char(14);
     DECLARE @AssessmentType varchar(40);
     DECLARE @Program varchar(10);
--     DECLARE @SurveyID int output;

     DECLARE @t TABLE (Program varchar(10), Staff varchar(40)
                    -- , SurveyDataJSON nvarchar(max)
                    , AssessmentType NVARCHAR(50), SLK CHAR(14)
                    );
     insert into @t
     SELECT  Program, Staff --,  SurveyDataJSON
            , AssessmentType
            , SLK
        FROM OPENJSON(@SurveyJSON)
        WITH (
            Program VARCHAR(10) '$.Program',
            Staff varchar(40) '$.Staff',
            SurveyDataJSON nvarchar(max) '$.SurveyData',
            AssessmentType NVARCHAR(50) '$.SurveyName',
            SLK VARCHAR(14) '$.PartitionKey'
        );

     set @SLK = (select SLK from @t);
     EXEC dbo.sp_createClient @SLK=@SLK, @clientID=@clientID OUTPUT

     set @AssessmentType = (select AssessmentType from @t);
     set @Program = (select Program from @t);
    -- note : see simple way to go fomr JSON to SQL table example 5 : https://docs.microsoft.com/en-us/sql/t-sql/functions/openjson-transact-sql?view=sql-server-ver15
     EXEC dbo.sp_createSurvey @SurveyJSON=@SurveyJSON
                         , @clientID=@clientID
                         , @assessType=@AssessmentType
                         , @Program=@Program
                         , @surveyId=@surveyID output

     declare @OtherDrugsOfConcernIDsTable table(DrugOfConcernID int);
     DECLARE @PDCId int;

     insert @OtherDrugsOfConcernIDsTable
     EXEC sp_insertDrugs  @json = @SurveyJSON,  @PDCId = @PDCId output;

     update DrugOfConcern
                    set SurveyID = @SurveyID
               where ID in (select ID
          from @OtherDrugsOfConcernIDsTable)
          or ID = @PDCId;

     -- for easy stats
     insert into PrincipalDrugOfConcern
          (ClientId, SurveyId, PDCDrugId)
     values
          (@ClientID, @SurveyID, @PDCId)

    exec sp_insertRecentLifestyleImpactConcern @SurveyID=@SurveyID, @SurveyJSON=@SurveyJSON
    --, @insertedId=@ret output

end