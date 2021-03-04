



DECLARE @all NVARCHAR(MAX);


--set @all = '{"asd":1, "Past4WkEngagedInOtheractivities":{"Paid Work":{"Frequency":"Not at all","Days":"4"}}}'

--exec sp_insertClientEngagement @surveyId =1 ,@fullJSON = @all

--select * from ClientEngagement

-- "Units": "cones / joints"
   --"Units": "points",

set @all= 
'{"ClientType":"ownuse","PDC":[{"PDCSubstanceOrGambling":"Alcohol","PDCMethodOfUse":"Ingest","PDCDaysInLast28":"15","PDCUnits":"standard drinks","PDCHowMuchPerOccasion":"4","PDCGoals":"Reduce Use", "PDCAgeFirstUsed": 9,"PDCAgeLastUsed": 11}],"Anyodc": "yes","ODC":[
    {
    "OtherSubstancesConcernGambling": "Amphetamines",
    "MethodOfUse": "Inject",
    "DaysInLast28": "9",
 
    "HowMuchPerOccasion": "30-39",
    "AgeFirstUsed": 11,
    "AgeLastUsed": 22
    },
    {
    "OtherSubstancesConcernGambling": "MDMA / Ecstacy",
    "MethodOfUse": "Transdermal",
    "DaysInLast28": "15",
    "Units": "Standard Drinks"
    },
    {},
    {},
    {}
  ]
}'

-- Msg 13608, Level 16, State 2, Procedure sp_insertDrugs, Line 25
-- Property cannot be found on the specified JSON path. 

--DECLARE @PDCJSON NVARCHAR(MAX);
--DECLARE @ODCsJSON NVARCHAR(MAX);

--		-- set @PDCJSON =   JSON_QUERY(@all, '$.PDC[0]')
--		--select @PDCJSON
--		-- exec sp_insertDrug  @surveyId = 2
--		-- 						,@DrugJSON = @PDCJSON
--		-- 						,@concernRank =1

--EXEC sp_insertDrugs @surveyId = 6, @json = @all			

---- delete from DrugOfConcern
--select * from DrugOfConcern




set @all= 
'{"SLK":"ALLFT210719812","ID":"ALLFT210719812","AssessmentDate":"2021-03-04","ClientType":"ownuse","PDC":[{"PDCSubstanceOrGambling":"Methadone","PDCMethodOfUse":"Sniff (powder)","PDCDaysInLast28":"15","PDCGoals":"Reduce Harms"}],"Anyodc":"no","HaveYouEverInjected":"No","SDSDoesMissingFixMakeAnxious":"0","SDSDoYouWishToStop":"0","Past4WkAodRisks":["Driving with drugs and/or alcohol in your system","Blackouts"],"Past4WkEngagedInOtheractivities":{"Paid Work":{"Frequency":"Once or twice per week","Days":"16"}},"HowDoYouSpendTime":{"HobbiesSportsRecreation":"Yes","MeTime":"Too Little "},"Past4WkDailyLivingImpacted":"Once or twice a week","PrioritiseCare":"Reasonably well","EverydayLivingITSPIssues":"everyday living issues notese","EverydayLivingITSPGoals":"everyday living issues goals","UsualAccommodation":"Domestic-scale supported living facility","LivingArrangement":"Friend(s)/parent(s)/relative(s) and child(ren)","YourCurrentHousing":"Some issues - but mostly ok","Past4WkDifficultyFindingHousing":"Once or twice per week","DoYouFeelSafeWhereYouLive":"Often feel unsafe / Occasionally experience violence","Past4WkPhysicalHealth":"5","Past4WkHowOftenPhysicalHealthCausedProblems":"Less than weekly","Past4WkBeenHospCallAmbulance":"No","AreYouCurrentlyTakingMeds":"Yes","MedicationsNotes":"some meds","HealthChecklist_STAFF":["Vaccinations"],"Past4WkMentalHealth":"2","Past4WkHowOftenMentalHealthCausedProblems":"Once or twice per week","EverDiagnosedMentalHealthIssue":"No","MHRecentRiskIssues":["Suicide of significant other","Recent sexual abuse"],"MHHistoricalRiskIssues":["Serious, ongoing physical illness"],"Past4WkUseLedToProblemsWithFamilyFriend":"Daily or almost daily","HaveAnySocialSupport":"Quite a lot","HaveDVOrFamilySafetyConcerns":"Yes - in the past 4 weeks (risk assessment required)","Past4WkHaveYouViolenceAbusive":"No","Past4WkHadCaregivingResponsibilities":"Yes","PrimaryCaregiver":["Yes - parenting responsibilities for children other than my own","Yes - primary caregiver: children 5 - 15 years old"],"ChildProtectionConcerns":"Yes","ChildProtectionDetails":"some prot issues with children","RelationshipsITSPGoals":"relationsship goals","Past4WkBeenArrested":"Yes","HaveYouServedCustodialSentenceInPast":"No","Past4WkHowOftenIllegalActivities":"Less than weekly","SubjectToCourtOrdersOrPendingCharges":"No","NeedHelpWrkDevlpmntOrdrPayingOutstndngFines":"Yes","HowCloseToManagingSubstanceUse":"4","HowImportantIsChangeToYou":"Really important. I''d like to change","Past4WkQualityOfLifeScore":"8","HowSatisfiedWithProgress":"Slightly","AreYouAccessingOtherServices":"Yes","SupportFromWhichOtherServices":["Other community health care service"],"SupportTypeBestMatchesNeedsGoals":["Case Management","Aboriginal Health Worker"],"ExternalReferrals":["Everyday Living","Relationships / Parenting / Social Wellbeing"],"RiskAssessmentChecklist":["IndicationSuicide"],"FinalChecklist":["ConsentToShareInfo"],"RiskAssessmentNotes":"ris k notes","SDSIsAODUseOutOfControl":"2","SDSHowDifficultToStopOrGoWithout":"2","SDSHowMuchDoYouWorryAboutAODUse":"3","SDS_Score":7,"CreatedDatetime":"04/03/2021 12:50:49 PM"}'


--DECLARE @all1 NVARCHAR(MAX);
--set @all1 = JSON_VALUE(@all, '$.DoYouFeelSafeWhereYouLive');
--select F.ID from dbo.lk_DegreesOfSafety F where F.Name = @all1

DECLARE @ret int;



exec  sp_insertRecentLifestyleImpactConcern @json=@all, @insertedId=@ret output


select @ret


--select * from lk_DegreesOfSafety
select * from  RecentLifestyleImpactConcern;
