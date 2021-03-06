-- make slk the primary key and id as AUTO_INCREMENT with index ??
-- or simply check if the slk exists 


CREATE Table Client (
  ID int IDENTITY  PRIMARY key,
  SLK VARCHAR(14) not null unique,
  DOB DATE, -- for age calculation
  Sex tinyint
  -- add index to all client's surveys
);


CREATE table Survey (
  ID int not null IDENTITY PRIMARY key,
  
  ClientId int not null,
  CONSTRAINT FK_Survey_Client FOREIGN KEY (ClientId) REFERENCES Client(ID),

  AssessmentType tinyint not null, -- 1: InitialAssessment, 2: Review
  AssessmentDate date not null,
  ClientType tinyint not null,  -- 1 OwnUse , 2 Others Use
  
  ProgramId smallint not null,
  CONSTRAINT FK_Survey_lkProgram FOREIGN KEY (ProgramId) REFERENCES lk_Program(ID),
  
  PDCDrugId smallint not null,
  CONSTRAINT FK_Survey_lkDrug FOREIGN KEY (PDCDrugId) REFERENCES lk_Drugs(ID),
 
  PDCAgeFirstUsed tinyint,

  WhenMentalHealthDiagnosisId tinyint, -- to be made into lookup
  CONSTRAINT FK_SurveyMentalDiag_lkHowLongAgo FOREIGN KEY (WhenMentalHealthDiagnosisId) REFERENCES lk_HowLongAgo(ID),
  
  HaveYouEverInjected bit, -- ? -- not on client because it is useful to know when they had/declared it
  HaveYouServedCustodialSentenceInPast bit, -- not on client because it is useful to know when they had/declared it
  EverDiagnosedMentalHealthIssue bit, -- ? -- not on client because it is useful to know when they had/declared it
 
  UNIQUE (ClientId, AssessmentDate, ProgramId)
);


  -- drop table ClientCurrentSituation -- A2
  -- drop table DrugOfConcern --B2
  -- drop table InjectingDrugDetails --C2
  -- drop table OtherBehavioursOfDependence --D2
  -- drop table RecentLifestyleImpactConcern -- E2
  -- drop table SDS -- F2
  -- drop table ClientEngagement -- G2
  -- drop table CurrentStageReview -- H2
  -- drop table PrimaryCaregiverDetail -- I2
  -- drop table ClientRisk -- J2
  -- drop table SupportForGoals -- K2
  -- drop table Survey-- Level-1
  --drop table Client

-- SupportTypeBestMatchesNeedsGoals



-- linked one-one to survey 
  --CurrentStageReviewId int FOREIGN KEY REFERENCES CurrentStageReview(ID),
