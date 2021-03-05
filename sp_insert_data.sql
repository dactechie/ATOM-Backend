--CREATE PROCEDURE sp_InsertClientSurvey  
--  @assessmentDate varchar(10),
--  @program varchar(20),
--  @surveyJSON varchar(MAX)
--)
--AS
--BEGIN
  DECLARE	@ClientID int, @SurveyID int, @Program smallint,
			@SLK varchar(14),
          --@assessmentD datetime = CONVERT(DATE, @assessmentDate, 102),
          @surveyJSON varchar(MAX);

  set @surveyJSON= '{"SLK":"ALLFT210719812","ID":"ALLFT210719812","AssessmentDate":"2021-03-04","ClientType":"ownuse","PDC":[{"PDCSubstanceOrGambling":"Methadone","PDCMethodOfUse":"Sniff (powder)","PDCDaysInLast28":"15","PDCGoals":"Reduce Harms"}],"Anyodc":"no","HaveYouEverInjected":"No","SDSDoesMissingFixMakeAnxious":"0","SDSDoYouWishToStop":"0","Past4WkAodRisks":["Driving with drugs and/or alcohol in your system","Blackouts"],"Past4WkEngagedInOtheractivities":{"Paid Work":{"Frequency":"Once or twice per week","Days":"16"}},"HowDoYouSpendTime":{"HobbiesSportsRecreation":"Yes","MeTime":"Too Little "},"Past4WkDailyLivingImpacted":"Once or twice a week","PrioritiseCare":"Reasonably well","EverydayLivingITSPIssues":"everyday living issues notese","EverydayLivingITSPGoals":"everyday living issues goals","UsualAccommodation":"Domestic-scale supported living facility","LivingArrangement":"Friend(s)/parent(s)/relative(s) and child(ren)","YourCurrentHousing":"Some issues - but mostly ok","Past4WkDifficultyFindingHousing":"Once or twice per week","DoYouFeelSafeWhereYouLive":"Often feel unsafe / Occasionally experience violence","Past4WkPhysicalHealth":"5","Past4WkHowOftenPhysicalHealthCausedProblems":"Less than weekly","Past4WkBeenHospCallAmbulance":"No","AreYouCurrentlyTakingMeds":"Yes","MedicationsNotes":"some meds","HealthChecklist_STAFF":["Vaccinations"],"Past4WkMentalHealth":"2","Past4WkHowOftenMentalHealthCausedProblems":"Once or twice per week","EverDiagnosedMentalHealthIssue":"No","MHRecentRiskIssues":["Suicide of significant other","Recent sexual abuse"],"MHHistoricalRiskIssues":["Serious, ongoing physical illness"],"Past4WkUseLedToProblemsWithFamilyFriend":"Daily or almost daily","HaveAnySocialSupport":"Quite a lot","HaveDVOrFamilySafetyConcerns":"Yes - in the past 4 weeks (risk assessment required)","Past4WkHaveYouViolenceAbusive":"No","Past4WkHadCaregivingResponsibilities":"Yes","PrimaryCaregiver":["Yes - parenting responsibilities for children other than my own","Yes - primary caregiver: children 5 - 15 years old"],"ChildProtectionConcerns":"Yes","ChildProtectionDetails":"some prot issues with children","RelationshipsITSPGoals":"relationsship goals","Past4WkBeenArrested":"Yes","HaveYouServedCustodialSentenceInPast":"No","Past4WkHowOftenIllegalActivities":"Less than weekly","SubjectToCourtOrdersOrPendingCharges":"No","NeedHelpWrkDevlpmntOrdrPayingOutstndngFines":"Yes","HowCloseToManagingSubstanceUse":"4","HowImportantIsChangeToYou":"Really important. I''d like to change","Past4WkQualityOfLifeScore":"8","HowSatisfiedWithProgress":"Slightly","AreYouAccessingOtherServices":"Yes","SupportFromWhichOtherServices":["Other community health care service"],"SupportTypeBestMatchesNeedsGoals":["Case Management","Aboriginal Health Worker"],"ExternalReferrals":["Everyday Living","Relationships / Parenting / Social Wellbeing"],"RiskAssessmentChecklist":["IndicationSuicide"],"FinalChecklist":["ConsentToShareInfo"],"RiskAssessmentNotes":"ris k notes","SDSIsAODUseOutOfControl":"2","SDSHowDifficultToStopOrGoWithout":"2","SDSHowMuchDoYouWorryAboutAODUse":"3","SDS_Score":7,"CreatedDatetime":"04/03/2021 12:50:49 PM"}'
  set @SLK = JSON_VALUE(@surveyJSON, '$.SLK');
  
  select @ClientID = C.ID from Client C where  C.SLK = @SLK;
  if @ClientID is null
    exec sp_createClient @SLK = @SLK, @ClientID=@ClientID output

	

  --exec sp_createSurveyWithProgramPDC @surveyJSON=@surveyJSON, @ClientId = @ClientID, @SurveyID  output

  --insert into Survey (ClientId,AssessmentType AssessmentDate, ClientType, ProgramId, PDCDrugId ,PDCAgeFirstUsed
		--			 , WhenMentalHealthDiagnosis, HaveYouEverInjected, HaveYouServedCustodialSentenceInPast
		--			 , EverDiagnosedMentalHealthIssue) values ()



--END;
