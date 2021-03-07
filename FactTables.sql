

-- A2.
CREATE TABLE ClientCurrentSituation (
  ID int not null PRIMARY key,
  SurveyId int unique,
  CONSTRAINT FK_CurrentSit_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  ChildProtectionConcerns bit,
  Past4WkAnyOtherAddictiveB bit,
  Past4WkBeenHospCallAmbulance bit,
  AreYouCurrentlyTakingMeds bit,

  NeedHelpWrkDevlpmntOrdrPayingOutstndngFines bit,
  SubjectToCourtOrdersOrPendingCharges bit,

  PrioritiseCareId tinyint,
  CONSTRAINT FK_CurrentSitPrioritse_VWellUnableTo FOREIGN KEY (PrioritiseCareId) REFERENCES lk_VWellUnableTo(ID),

  SetBoundariesPrioritiseWellbeingId tinyint,
  CONSTRAINT FK_CurrentSitSetBound_VWellUnableTo FOREIGN KEY (SetBoundariesPrioritiseWellbeingId) REFERENCES lk_VWellUnableTo(ID),

  HaveAnySocialSupportId tinyint,
  CONSTRAINT FK_CurrentSitSocSupport_LotNone FOREIGN KEY (HaveAnySocialSupportId) REFERENCES lk_LotNone(ID),

  CreateDate datetime DEFAULT CURRENT_TIMESTAMP,
  ModifiedDate datetime DEFAULT CURRENT_TIMESTAMP
);


-- B2.  (many to one survey)
CREATE TABLE DrugOfConcern
(
  ID int not null IDENTITY PRIMARY key,
  SurveyId int,
  CONSTRAINT FK_DoC_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  ConcernRank tinyint,
  AgeFirstUsed tinyint,
  AgeLastUsed tinyint,
  DaysInLast28 tinyint,

   DrugId smallint,
   CONSTRAINT FK_DoC_Drugs FOREIGN KEY (DrugId) REFERENCES lk_Drugs(ID),

   MethodOfUseId tinyint,
   CONSTRAINT FK_DoC_Method FOREIGN KEY (MethodOfUseId) REFERENCES lk_MethodOfUse(ID),

  DrugUnitId TINYINT,
  CONSTRAINT FK_DoC_Unit FOREIGN KEY (DrugUnitId) REFERENCES lk_DrugUnit(ID),

  GoalId tinyint,
  CONSTRAINT FK_DoC_Goal FOREIGN KEY (GoalId) REFERENCES lk_DrugUseGoal(ID),
)



-- BB2.  (one to one survey)
CREATE TABLE PrincipalDrugOfConcern(
  ID int not null IDENTITY PRIMARY key,
  
  ClientId int not null,
  CONSTRAINT FK_PDC_Client FOREIGN KEY (ClientId) REFERENCES Client(ID),

  SurveyId int not null unique,
  CONSTRAINT FK_PDC_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  PDCDrugId int not null,
  CONSTRAINT FK_PDC_lkDrug FOREIGN KEY (PDCDrugId) REFERENCES DrugOfConcern(ID)
);




-- C2 one to one with survey
create table InjectingDrugDetails
(
  ID int  IDENTITY PRIMARY key,
  SurveyId int not null unique,
  CONSTRAINT FK_InjDrgDeets_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  HowLongSinceLastInjectedId tinyint,
  CONSTRAINT FK_InjDrgDeets_HowLong FOREIGN KEY (HowLongSinceLastInjectedId) REFERENCES lk_HowLongAgo(ID),
 
  HaveYouEverSharedEquipment bit,
  Past4WkNumInjectingDays tinyint
);


-- D2 many to one with Survey
CREATE Table OtherBehavioursOfDependence
(
  ID smallint not null IDENTITY PRIMARY key,
  SurveyId int not null,
  CONSTRAINT FK_OtherBehavDepend_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  NumDays tinyint,

  BehaviourOfDependenceTypeId tinyint,
  CONSTRAINT FK_OtherBehav_lkOtherBehave FOREIGN KEY (BehaviourOfDependenceTypeId) REFERENCES lk_OtherBehavioursOfDependence(ID)
  
);


-- E2 one-to-one survey
create table RecentLifestyleImpactConcern
(
  ID int not null IDENTITY PRIMARY key,

  SurveyId int not null unique,
  CONSTRAINT FK_Lifestyle_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),
  
  DoYouFeelSafeWhereYouLive tinyint,  --physical safety
  CONSTRAINT FK_Lifestyle_DegrOfSafety FOREIGN KEY (DoYouFeelSafeWhereYouLive) REFERENCES lk_DegreesOfSafety(ID),

  YourCurrentHousing tinyint, -- stable / at risk of eviction / couch surfing homeless
  CONSTRAINT FK_LifestyleCurrentHousing_FreqLowGood FOREIGN KEY (YourCurrentHousing) REFERENCES lk_HousingStability(ID),
  
  Past4WkDifficultyFindingHousing tinyint,
  CONSTRAINT FK_LifestyleFindingHousing_FreqLowGood FOREIGN KEY (Past4WkDifficultyFindingHousing) REFERENCES lk_FrequencyLowGood(Score),

  Past4WkHowOftenPhysicalHealthCausedProblems tinyint,
  CONSTRAINT FK_LifestylePhysicalProb_FreqLowGood FOREIGN KEY (Past4WkHowOftenPhysicalHealthCausedProblems) REFERENCES lk_FrequencyLowGood(Score),

  Past4WkHowOftenMentalHealthCausedProblems tinyint,
  CONSTRAINT FK_LifestyleMentalProb_FreqLowGood FOREIGN KEY (Past4WkHowOftenMentalHealthCausedProblems) REFERENCES lk_FrequencyLowGood(Score),

  WhenMentalHealthDiagnosisId tinyint,
  CONSTRAINT FK_LifestyleMentalDiag_lkHowLongAgo FOREIGN KEY (WhenMentalHealthDiagnosisId) REFERENCES lk_HowLongAgo(ID),

  Past4WkUseLedToProblemsWithFamilyFriend tinyint,
  CONSTRAINT FK_LifestyleFamFriendProb_FreqLowGood FOREIGN KEY (Past4WkUseLedToProblemsWithFamilyFriend) REFERENCES lk_FrequencyLowGood(Score),

  Past4WkHowOftenIllegalActivities tinyint,
  CONSTRAINT FK_LifestyleIllegalAct_FreqLowGood FOREIGN KEY (Past4WkHowOftenIllegalActivities) REFERENCES lk_FrequencyLowGood(Score),

  Past4WkHaveDVOrFamilySafetyConcerns bit, -- Do you have any domestic violence or family safety concerns?
  Past4WkHaveYouViolenceAbusive bit, -- Have you used violence or been abusive towards anyone, over the last 4 weeks?
  Past4WkHadCaregivingResponsibilities bit,
  Past4WkBeenArrested bit,
  
  Past4WkPhysicalHealth tinyint,
  Past4WkMentalHealth tinyint,
  Past4WkQualityOfLifeScore tinyint,
  
  CreatedDate datetime DEFAULT CURRENT_TIMESTAMP
);

-- F2
CREATE TABLE SDS (
    ID int not null IDENTITY PRIMARY key,
	  SurveyId int not null unique,
	  CONSTRAINT FK_SDS_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

    IsAODUseOutOfControl TINYINT,
	  DoesMissingFixMakeAnxious tinyint,
    HowMuchDoYouWorryAboutAODUse TINYINT,
	  DoYouWishToStop tinyint,
    HowDifficultToStopOrGoWithout TINYINT,
   
    ModifiedDate datetime DEFAULT CURRENT_TIMESTAMP
 );




-- G2 one to one with survey
CREATE TABLE ClientEngagement
(
  ID int not null identity primary key,
  SurveyId int not null unique,
  CONSTRAINT FK_ClientEngage_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  EngagementFrequency tinyint,
  CONSTRAINT FK_ClientEngage_FreqHighGood FOREIGN KEY (EngagementFrequency) REFERENCES lk_FrequencyHighGood(Score),

  EngagementDays tinyint,
  
  EngagementTypeId tinyint not null,
  CONSTRAINT FK_ClientEngage_lkEngage FOREIGN KEY (EngagementTypeId) REFERENCES lk_Engagement(ID),

  CreatedDate datetime DEFAULT CURRENT_TIMESTAMP
);


-- H2 one-to-one- Survey
Create Table CurrentStageReview
(
  ID int not null identity primary key,
  SurveyId int not null unique,
  CONSTRAINT FK_CurrentStage_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

  ClientType bit,
  ReviewNumber smallint,
  -- calcualted by count(id) of previous COMSRecord for this client
  HowImportantIsChangeToYou tinyint,
  HowCloseToManagingSubstanceUse tinyint,
  HowSatisfiedWithProgress tinyint,
  HowCloseToManagingImpactOfUse TINYINT,
  CreatedDate datetime DEFAULT CURRENT_TIMESTAMP
  -- could be HowCloseToManagingImpactOf_Others_Use depending on the clientype
);


-- I2. Many to One SurveyID
create table PrimaryCaregiverDetail
 (
   ID int not null identity PRIMARY key,
 
   SurveyId int not null,
   CONSTRAINT FK_PrimaryCaregiv_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

   PrimaryCaregiverId tinyint,
   CONSTRAINT FK_PrimaryCaregiv_lkPrimaryCare FOREIGN KEY (PrimaryCaregiverId) REFERENCES lk_PrimaryCaregiver(ID),
  
 );


 -- J2 Many to one SurveyId
 CREATE TABLE ClientRisk
 (
	ID int not null identity PRIMARY key,
	SurveyId int not null,
	CONSTRAINT FK_Risk_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

	RiskId tinyint not null,
	CONSTRAINT FK_ClientRisk_lkRisk FOREIGN KEY (RiskId) REFERENCES lk_Risk(ID),
 )



  -- K2 Many to one SurveyId
 CREATE TABLE SupportForGoals
 (
	ID int not null identity PRIMARY key,
	SurveyId int not null,
	CONSTRAINT FK_SupportForGoals_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),

	SupportTypeId tinyint,
	CONSTRAINT FK_SupportForGoals_lkSupportType FOREIGN KEY (SupportTypeId) REFERENCES lk_SupportType(ID),
 )

