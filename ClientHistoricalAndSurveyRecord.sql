-- make slk the primary key and id as AUTO_INCREMENT with index ??
-- or simply check if the slk exists 
CREATE Table Client (
  ID int not null IDENTITY PRIMARY key,
  SLK VARCHAR(14) not null,
  DOB DATE, -- for age calculation
  Sex tinyint,
  HaveYouServedCustodialSentenceInPast bit,
  EverDiagnosedMentalHealthIssue bit, -- ? here
  HaveYouEverInjected bit, -- ? here 
);

-- sp_insertClietn 
  -- check if the slk exists and reject if it does
  -- extracts DOB and Sex from SLK nd inserts it)

-- alter table Client add HasRisk bit default (0);
-- Living arragenemtns , Usual accomo ?

-- risks
-- other addictive behaviours
-- mental health checkboxes
-- meds, ambulencem
-- custodial sentence, court order
-- feel safe wher you live 



-- -- JOIN TABLE -- 

-- extra joins from tables :
 -- ClientSurvey
 -- ClientEngagement
 -- other behaviours of dependence


-- CREATE TABLE ReviewAssessment (

-- )


CREATE TABLE ClientCurrentSituation (
  ID int not null IDENTITY PRIMARY key,
  ChildProtectionConcerns bit,
  Past4WkAnyOtherAddictiveB bit,
  Past4WkBeenHospCallAmbulance tinyint,
  AreYouCurrentlyTakingMeds bit,  
  HaveAnySocialSupport tinyint,

  NeedHelpWrkDevlpmntOrdrPayingOutstndngFines bit,
  SubjectToCourtOrdersOrPendingCharges bit,

  PrimaryCaregiverEntryId int FOREIGN KEY REFERENCES PrimaryCaregiverEntry(ID),
  CreateDate datetime DEFAULT CURRENT_TIMESTAMP,
  ModifiedDate datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE table Survey (
  ID int not null IDENTITY PRIMARY key,
  
  ClientId int not null,
  CONSTRAINT FK_Survey_Client FOREIGN KEY (ClientId) REFERENCES Client(ID),

  AssessmentType tinyint not null, -- 1: InitialAssessment, 2: Review
  AssessmentDate datetime not null,
  ClientType tinyint not null,  -- 1 OwnUse , 2 Others Use
  
  ProgramId smallint not null,
  CONSTRAINT FK_Survey_Program FOREIGN KEY (ProgramId) REFERENCES Program(ID),
  
  PDCDrugOfConcernId tinyint not null,
  CONSTRAINT FK_Survey_DrugOfConcern FOREIGN KEY (PDCDrugOfConcernId) REFERENCES DrugOfConcern(ID),

  WhenMentalHealthDiagnosis tinyint,  --forign key
  
  SDSId int FOREIGN KEY REFERENCES SDSEntry(ID),
  
  RecentLifestyleImpactConcernId int FOREIGN KEY REFERENCES RecentLifestyleImpactConcern(ID),
  CurrentStageReviewId int FOREIGN KEY REFERENCES CurrentStageReview(ID),
  ClientCurrentSituationId int FOREIGN KEY REFERENCES ClientCurrentSituation(ID),
  OtherBehavioursOfDependenceId int FOREIGN KEY REFERENCES OtherBehavioursOfDependence(ID)
  -- EpisodeDate datetime,
  -- MDSId int foreign key references MDS(ID),

);

-- SupportTypeBestMatchesNeedsGoals

-- Created with an Intial Assessment
CREATE TABLE ClientHistorical (  
  ClientId int,
  SurveyId int,
  PDCAgeFirstUsed tinyint,
  PDCAgeLastUsed tinyint,
  
  CreateDate datetime DEFAULT CURRENT_TIMESTAMP,
  ModifiedDate datetime DEFAULT CURRENT_TIMESTAMP

  CONSTRAINT PK_ID PRIMARY KEY (ClientId, SurveyId),
  CONSTRAINT FK_ClientHistorical_Survey FOREIGN KEY (SurveyId) REFERENCES Survey(ID),
  CONSTRAINT FK_ClientHistorical_Client FOREIGN KEY (ClientId) REFERENCES Client(ID)
)


-- TODO
-- ALTER TABLE [dbo].[ClientEngagement]  WITH CHECK ADD FOREIGN KEY([SurveyId]) REFERENCES Survey(ID)
-- alter table RiskEntry with check   ADD FOREIGN KEY([SurveyId]) REFERENCES Survey(ID)
-- alter table DrugOfConcern with check   ADD FOREIGN KEY([SurveyId]) REFERENCES Survey(ID)






-- create table MDS (
--   ID int not null IDENTITY PRIMARY key,
--   UsualAccommodation tinyint,
--   LivingArrangements tinyint,
--   WhenMentalHealthDiagnosis tinyint,
--   SubstanceUseId int FOREIGN KEY REFERENCES  SubstanceUse(ID)
-- )

-- create table SubstanceUse (
--     ID int not null IDENTITY PRIMARY key,
--     PDC smallint not null foreign key references DrugOfConcern(ID),
--     ODC1 smallint,
--     ODC2 smallint,
--     ODC3 smallint,
--     ODC4 smallint,
--     ODC5 smallint, 
--     HaveYouEverInjected bit,
--     InjectingDrugDetailsId int FOREIGN KEY REFERENCES InjectingDrugDetails(ID),
-- );

-- create table AODTreatment (
--     ID int not null IDENTITY PRIMARY key,
--     MTT smallint not null foreign key references DrugOfConcern(ID),
--     OTT1 smallint,
--     OTT2 smallint,
--     ODC3 smallint,
--     ODC4 smallint,
--     ODC5 smallint,
-- );

-- select * from SubstanceUse