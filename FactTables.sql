

CREATE Table RiskEntry
(
  ID smallint not null IDENTITY PRIMARY key,
  
  RiskTypeId tinyint not null,
  CONSTRAINT FK_RiskEntry_RiskType FOREIGN KEY (RiskTypeId) REFERENCES RiskType(ID), 
);


CREATE Table OtherBehavioursOfDependence
(
  ID smallint not null IDENTITY PRIMARY key,
  Gambling tinyint, --28 days
  Porn tinyint,
  Sex tinyint,
  --[Internet / Social Media] tinyint,
  InternetSocialMedia tinyint,
  Gaming tinyint,
  Hoarding tinyint
);


CREATE TABLE DrugOfConcern
(
  ID int not null IDENTITY PRIMARY key,
  SurveyId int,
  DrugId smallint FOREIGN KEY REFERENCES DrugType(ID),
  MethodOfUseId tinyint FOREIGN KEY REFERENCES MethodOfUseTypes(ID),
  DrugUnitId TINYINT FOREIGN KEY REFERENCES DrugUnitTypes(ID),
  ConcernRank tinyint,
  AgeFirstUsed tinyint,
  AgeLastUsed tinyint,
  DaysInLast28 tinyint,
  GoalId tinyint FOREIGN KEY REFERENCES DrugUseGoalTypes(ID),
  
)

CREATE TABLE OtherDrugsOfConcernEntry (
  DrugOfConcernId int not null,
  SurveyId int not null,
  CONSTRAINT PK_ID PRIMARY KEY (DrugOfConcernId, SurveyId)
)


create table InjectingDrugDetails
(
  ID int not null IDENTITY PRIMARY key,
  HowLongSinceLastInjected tinyint,
  -- More than three months but less than twelve months ago
  HaveYouEverSharedEquipment bit,
  Past4WkNumInjectingDays tinyint
);




create table MentalHealthRiskEntry
(
  ID int not null IDENTITY PRIMARY key,
  MentalHealthRiskTypeId tinyint FOREIGN KEY REFERENCES MentalHealthRiskType(ID),

);


CREATE TABLE ClientEngagement
(
  ID int not null identity primary key,
  EngagementFrequency tinyint,
  EngagementDays tinyint,
  EngagementTypeId int FOREIGN KEY REFERENCES EngagementType(ID),  
  CreatedDate datetime DEFAULT CURRENT_TIMESTAMP
);



Create Table CurrentStageReview
(
  ID int not null identity primary key,
  EpisodeDate datetime,
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


create table RecentLifestyleImpactConcern
(

  ID int not null IDENTITY PRIMARY key,
  
  DoYouFeelSafeWhereYouLive tinyint,  --physical safety
  CONSTRAINT FK_SafeWhereLive_DegrOfSafety FOREIGN KEY (DoYouFeelSafeWhereYouLive) REFERENCES lk_DegreesOfSafety(ID),

  YourCurrentHousing tinyint, -- stable / at risk of eviction / couch surfing homeless
  CONSTRAINT FK_CurrentHousing_FreqLowGood FOREIGN KEY (YourCurrentHousing) REFERENCES lk_HousingStability(ID), 
  
  Past4WkDifficultyFindingHousing tinyint,
  CONSTRAINT FK_FindingHousing_FreqLowGood FOREIGN KEY (Past4WkDifficultyFindingHousing) REFERENCES lk_FrequencyLowGood(Score), 

  Past4WkHowOftenPhysicalHealthCausedProblems tinyint,
  CONSTRAINT FK_LifestylePhysicalProb_FreqLowGood FOREIGN KEY (Past4WkHowOftenPhysicalHealthCausedProblems) REFERENCES lk_FrequencyLowGood(Score), 

  Past4WkHowOftenMentalHealthCausedProblems tinyint,
  CONSTRAINT FK_LifestyleMentalProb_FreqLowGood FOREIGN KEY (Past4WkHowOftenMentalHealthCausedProblems) REFERENCES lk_FrequencyLowGood(Score), 

  Past4WkUseLedToProblemsWithFamilyFriend tinyint,
  CONSTRAINT FK_LifestyleFamFriendProb_FreqLowGood FOREIGN KEY (Past4WkUseLedToProblemsWithFamilyFriend) REFERENCES lk_FrequencyLowGood(Score), 

  Past4WkHowOftenIllegalActivities tinyint,
  CONSTRAINT FK_LifestyleIllegalAct_FreqLowGood FOREIGN KEY (Past4WkHowOftenIllegalActivities) REFERENCES lk_FrequencyLowGood(Score), 

  Past4WkHaveDVOrFamilySafetyConcerns bit,
  -- Do you have any domestic violence or family safety concerns?
  Past4WkHaveYouViolenceAbusive bit,
  -- Have you used violence or been abusive towards anyone, over the last 4 weeks?
  Past4WkHadCaregivingResponsibilities bit,
  Past4WkBeenArrested bit,
  
  Past4WkPhysicalHealth tinyint,
  Past4WkMentalHealth tinyint,
  Past4WkQualityOfLifeScore tinyint,
  
  CreatedDate datetime DEFAULT CURRENT_TIMESTAMP
);




-- CREATE TABLE SDSEntry (
--    ID int not null IDENTITY PRIMARY key,
--    DoesMissingFixMakeAnxious tinyint,
--    DoYouWishToStop tinyint,
--    HowDifficultToStopOrGoWithout TINYINT,
--    HowMuchDoYouWorryAboutAODUse TINYINT,
--    IsAODUseOutOfControl TINYINT,
--    ModifiedDate datetime DEFAULT CURRENT_TIMESTAMP
-- )

-- Not at all
-- Less than weekly
-- Once or twice per week
-- Three or four times per week
-- Daily or almost daily

-- drop table RecentLifestyleImpactEntry

-- drop table PrimaryCaregiverType;
-- create table PrimaryCaregiverType (
--   ID int not null IDENTITY PRIMARY key,
--   Name varchar (200)
-- );

-- insert into PrimaryCaregiverType (name) values ('Yes - primary caregiver: children under 5 years old');
-- insert into PrimaryCaregiverType (name) values ('Yes - primary caregiver: children 5 - 15 years old');
-- insert into PrimaryCaregiverType (name) values ('Yes - primary caregiver: children 15 - 18 years old');
-- insert into PrimaryCaregiverType (name) values ('Yes - parenting responsibilities but children don''t live with me');
-- insert into PrimaryCaregiverType (name) values ('Yes - parenting responsibilities for children other than my own');
-- insert into PrimaryCaregiverType (name) values ('Living with children other than my own, but no parental responsibility');
-- insert into PrimaryCaregiverType (name) values ('No');


-- create table PrimaryCaregiverEntry
-- (
--   ID int not null IDENTITY PRIMARY key,
--   Under5 bit,
--   Five15 bit,
--   Fifteen18 bit,
--   ParentingButChildNoCoHabit bit,
--   ParentingForChildNotOwn bit,
--   LivingWithOtherChildNoResp bit,
--   NoCaregiving bit
-- );
-- select * from PrimaryCaregiverEntry