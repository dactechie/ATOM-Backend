


DECLARE @all NVARCHAR(MAX);
DECLARE @SLK VARCHAR(24);

set @all= 
'{"SLK":"ALLFT210719812","ID":"ALLFT210719812","AssessmentDate":"2021-03-04","ClientType":"ownuse","PDC":[{"PDCSubstanceOrGambling":"Methadone",
"PDCMethodOfUse":"Sniff (powder)","PDCDaysInLast28":"15","PDCGoals":"Reduce Harms"}],"Anyodc":"no",
"ODC": [{
      "AgeFirstUsed": 20,
      "AgeLastUsed": 22,
      "DaysInLast28": "0",
      "Goals": "No Goals - Ceased Use",
      "HowMuchPerOccasion": "1",
      "MethodOfUse": "Ingest",
      "OtherSubstancesConcernGambling": "Amphetamines",
      "Units": "points"
    },
    {
      "AgeFirstUsed": 21,
      "AgeLastUsed": 23,
      "DaysInLast28": "0",
      "Goals": "No Goals - Ceased Use",
      "HowMuchPerOccasion": "1",
      "MethodOfUse": "Ingest",
      "OtherSubstancesConcernGambling": "Psychostimulants",
      "Units": "pills"
    }],


"HaveYouEverInjected":"No","SDSDoesMissingFixMakeAnxious":"0",
"SDSDoYouWishToStop":"0","Past4WkAodRisks":["Driving with drugs and/or alcohol in your system","Blackouts"],
"Past4WkEngagedInOtheractivities":{"Paid Work":{"Frequency":"Once or twice per week","Days":"16"}},
"HowDoYouSpendTime":{"HobbiesSportsRecreation":"Yes","MeTime":"Too Little "},"Past4WkDailyLivingImpacted":"Once or twice a week",
"PrioritiseCare":"Reasonably well","EverydayLivingITSPIssues":"everyday living issues notese","EverydayLivingITSPGoals":"everyday living issues goals",
"UsualAccommodation":"Domestic-scale supported living facility","LivingArrangement":"Friend(s)/parent(s)/relative(s) and child(ren)",
"YourCurrentHousing":"Some issues - but mostly ok","Past4WkDifficultyFindingHousing":"Once or twice per week","DoYouFeelSafeWhereYouLive":"Often feel unsafe / Occasionally experience violence",
"Past4WkPhysicalHealth":"5","Past4WkHowOftenPhysicalHealthCausedProblems":"Less than weekly","Past4WkBeenHospCallAmbulance":"No","AreYouCurrentlyTakingMeds":"Yes","MedicationsNotes":"some meds",
"HealthChecklist_STAFF":["Vaccinations"],"Past4WkMentalHealth":"2","Past4WkHowOftenMentalHealthCausedProblems":"Once or twice per week",

"EverDiagnosedMentalHealthIssue":"Yeo",

"MHRecentRiskIssues":["Suicide of significant other","Recent sexual abuse"],"MHHistoricalRiskIssues":["Serious, ongoing physical illness"],
"Past4WkUseLedToProblemsWithFamilyFriend":"Daily or almost daily","HaveAnySocialSupport":"Quite a lot","HaveDVOrFamilySafetyConcerns":"Yes - in the past 4 weeks (risk assessment required)",
"Past4WkHaveYouViolenceAbusive":"No","Past4WkHadCaregivingResponsibilities":"Yes","PrimaryCaregiver":["Yes - parenting responsibilities for children other than my own",
"Yes - primary caregiver: children 5 - 15 years old"],"ChildProtectionConcerns":"Yes","ChildProtectionDetails":"some prot issues with children","RelationshipsITSPGoals":"relationsship goals",
"Past4WkBeenArrested":"Yes",

"HaveYouServedCustodialSentenceInPast":"No",

"Past4WkHowOftenIllegalActivities":"Less than weekly","SubjectToCourtOrdersOrPendingCharges":"No",
"NeedHelpWrkDevlpmntOrdrPayingOutstndngFines":"Yes","HowCloseToManagingSubstanceUse":"4","HowImportantIsChangeToYou":"Really important. I''d like to change",
"Past4WkQualityOfLifeScore":"8","HowSatisfiedWithProgress":"Slightly","AreYouAccessingOtherServices":"Yes","SupportFromWhichOtherServices":["Other community health care service"],
"SupportTypeBestMatchesNeedsGoals":["Case Management","Aboriginal Health Worker"],"ExternalReferrals":["Everyday Living","Relationships / Parenting / Social Wellbeing"],
"RiskAssessmentChecklist":["IndicationSuicide"],"FinalChecklist":["ConsentToShareInfo"],"RiskAssessmentNotes":"ris k notes","SDSIsAODUseOutOfControl":"2","SDSHowDifficultToStopOrGoWithout":"2",
"SDSHowMuchDoYouWorryAboutAODUse":"3","SDS_Score":7,"CreatedDatetime":"04/03/2021 12:50:49 PM"}'


DECLARE @datestring varchar (10);
DECLARE @clientID int, @surveyID int;
set @SLK  = 'ALLFT210719812'

EXEC dbo.sp_createClient @SLK=@SLK, @clientID=@clientID OUTPUT


-- note : see simple way to go fomr JSON to SQL table example 5 : https://docs.microsoft.com/en-us/sql/t-sql/functions/openjson-transact-sql?view=sql-server-ver15
EXEC dbo.sp_createSurvey @SurveyJSON=@all, @clientID=@clientID, @surveyId=@surveyID output

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