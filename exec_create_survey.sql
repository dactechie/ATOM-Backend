DECLARE @json nvarchar(max) ;
DECLARE @SurveyJSON nvarchar(MAX);
DECLARE @AssessmentType varchar(40);
DECLARE @Program varchar(10);
DECLARE @surveyID int;
DECLARE @SLK char(14);
DECLARE @ClientID int;

set @json = N'{
  "Program": "TSS",
  "Staff": "Lexxie.Jury",
  "SurveyID": "8a434de3-a367-42ea-a5a2-21a95cb1d65c",
  "Status": "Complete",
  "SurveyData": "{\"SLK\":\"KESUS180119811\",\"AssessmentDate\":\"2021-03-09\",\"ClientType\":\"ownuse\",\"PDC\":[{\"PDCSubstanceOrGambling\":\"Alcohol\",\"PDCMethodOfUse\":\"Ingest\",\"PDCDaysInLast28\":\"0\",\"PDCUnits\":\"standard drinks\",\"PDCHowMuchPerOccasion\":\"0\",\"PDCAgeFirstUsed\":15,\"PDCAgeLastUsed\":40,\"PDCGoals\":\"Cease Use\"}],\"PDCnotes\":\"Reduce quit .\",\"Anyodc\":\"yes\",\"ODC\":[{\"OtherSubstancesConcernGambling\":\"Cannabinoids and related drugs\",\"MethodOfUse\":\"Smoke\",\"DaysInLast28\":\"0\",\"Units\":\"cones / joints\",\"HowMuchPerOccasion\":\"5\",\"AgeFirstUsed\":15,\"AgeLastUsed\":38,\"Goals\":\"Maintain Abstinence\"},{},{},{},{}],\"NotesODC\":\"Stopped using 2 years ago.\",\"HaveYouEverInjected\":\"No\",\"SDSIsAODUseOutOfControl\":\"2\",\"SDSDoesMissingFixMakeAnxious\":\"0\",\"SDSHowMuchDoYouWorryAboutAODUse\":\"0\",\"SDSDoYouWishToStop\":\"1\",\"SDSHowDifficultToStopOrGoWithout\":\"0\",\"SDS_Score\":3,\"Past4WkAodRisks-Comment\":\"Stopped drinking 4 weeks ago.\",\"Past4WkAnyOtherAddictiveB\":\"No\",\"SubstanceUseITSPGoals\":\"To competly stop. just need support with that.\",\"Past4WkEngagedInOtheractivities\":{\"Paid Work\":{\"Frequency\":\"Daily or almost daily\",\"Days\":\"20\"},\"Voluntary Work\":{\"Frequency\":\"Not at all\"},\"Study - college, school or vocational education\":{\"Frequency\":\"Less than weekly\",\"Days\":\"1\"},\"Looking after children\":{\"Frequency\":\"Daily or almost daily\",\"Days\":\"20\"},\"Other caregiving activities\":{\"Frequency\":\"Not at all\"}},\"HowDoYouSpendTime\":{\"HobbiesSportsRecreation\":\"Yes\",\"FamilyHome\":\"Yes\",\"MeTime\":\"Yes\",\"OtherBehavioursDependence\":\"Too Much\",\"WorkOrStudy\":\"Yes\"},\"Past4WkDailyLivingImpacted\":\"Not at all\",\"PrioritiseCare\":\"Reasonably well\",\"EverydayLivingITSPIssues\":\"Childhood trauma. Sexual abuse as a child.\",\"EverydayLivingITSPGoals\":\"Wanting to get to the point where he can stop taking medication.\",\"UsualAccommodation\":\"Private residence\",\"LivingArrangement\":\"Spouse/partner and child(ren)\",\"HousingSafetyITSPIssues\":\"Stays at property by himself about once or twice a week.\",\"YourCurrentHousing\":\"Stable permanent housing\",\"Past4WkDifficultyFindingHousing\":\"Not at all\",\"DoYouFeelSafeWhereYouLive\":\"Yes - Completely safe\",\"Past4WkPhysicalHealth\":\"5\",\"Past4WkHowOftenPhysicalHealthCausedProblems\":\"Not at all\",\"Past4WkBeenHospCallAmbulance\":\"No\",\"AreYouCurrentlyTakingMeds\":\"Yes\",\"MedicationsNotes\":\"Efelon, fluoxatine, \",\"Past4WkMentalHealth\":\"6\",\"Past4WkHowOftenMentalHealthCausedProblems\":\"Less than weekly\",\"EverDiagnosedMentalHealthIssue\":\"Yes\",\"WhenMentalHealthDiagnosis-Comment\":\"PTSD 2020, childhood trauma 2020, childhood trauma/abuse 2020,\",\"MHHistoricalRiskIssues\":[\"History of mental health issues\",\"Past sexual abuse\",\"History of impulsive and/or aggressive actions\"],\"MHHistoricalRiskIssues-Comment\":\"History of suicidal thought, never acted on them.\",\"MentalHealthITSPGoals\":\"Help with the past trauma. Would like help to rewire his brain.\",\"WhenMentalHealthDiagnosis\":\"More than 12 months ago\",\"HaveAnySocialSupport\":\"Some\",\"Past4WkUseLedToProblemsWithFamilyFriend\":\"Less than weekly\",\"HaveDVOrFamilySafetyConcerns\":\"No\",\"Past4WkHaveYouViolenceAbusive\":\"No\",\"Past4WkHadCaregivingResponsibilities\":\"Yes\",\"PrimaryCaregiver\":[\"Yes - parenting responsibilities for children other than my own\"],\"PrimaryCaregiver-Comment\":\"No\",\"ChildProtectionConcerns\":\"No\",\"HaveYouServedCustodialSentenceInPast\":\"No\",\"Past4WkBeenArrested\":\"No\",\"Past4WkHowOftenIllegalActivities\":\"Not at all\",\"SubjectToCourtOrdersOrPendingCharges\":\"No\",\"NeedHelpWrkDevlpmntOrdrPayingOutstndngFines\":\"No\",\"HowImportantIsChangeToYou\":\"Critical for me. I need to change\",\"HowCloseToManagingSubstanceUse\":\"6\",\"HowSatisfiedWithProgress\":\"Slightly\",\"Past4WkQualityOfLifeScore\":\"7\",\"AreYouAccessingOtherServices\":\"No\",\"SupportTypeBestMatchesNeedsGoals\":[\"AOD counselling & support (3 - 6 sessions, then review)\"],\"CreatedDatetime\":\"09/03/2021 3:46:31 PM\"}",
  "SurveyName": "ATOM Initial Assessment",
  "IsActive": 1,
  "RowKey": "TSS_INAS_20210309",
  "PartitionKey": "KESUS180119811"
}';


DECLARE @datestring varchar (10);


set @SLK  = JSON_VALUE(@json, '$.PartitionKey');
set @Program  = JSON_VALUE(@json, '$.Program');
set @AssessmentType  =  JSON_VALUE(@json, '$.SurveyName');
set @SurveyJSON = JSON_VALUE(@json, '$.SurveyData')

EXEC dbo.sp_createClient @SLK=@SLK, @clientID=@ClientID OUTPUT


-- note : see simple way to go fomr JSON to SQL table example 5 : https://docs.microsoft.com/en-us/sql/t-sql/functions/openjson-transact-sql?view=sql-server-ver15
EXEC dbo.sp_createSurvey @SurveyJSON=@SurveyJSON, @ClientID=@ClientID, @AssessType=@AssessmentType, @Program=@Program, @SurveyId=@surveyID output

select @surveyID

select * from Survey

-- delete from Survey


-- select CONVERT(DATE, '2021-03-04', 102)

-- select * from DrugOfConcern
-- select * from PrincipalDrugOfConcern

-- select * from lk_DrugUseGoal



    --       "AgeFirstUsed": 15,
--       "AgeLastUsed": 34,
--       "DaysInLast28": "16",
--       "Goals": "Cease Use",
--       "HowMuchPerOccasion": "1",
--       "MethodOfUse": "Smoke",
--       "OtherSubstancesConcernGambling": "Cannabinoids and related drugs",
--       "Units": "grams"

-- select * from DrugOfConcern
-- delete from DrugOfConcern

-- delete from PrincipalDrugOfConcern