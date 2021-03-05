CREATE PROCEDURE sp_createSurvey ( @SurveyJSON nvarchar(MAX), @ClientID int, @SurveyID int output)
as 
begin
	
	--insert into Survey (ClientId,AssessmentType, AssessmentDate, ClientType, ProgramId, PDCDrugId ,PDCAgeFirstUsed
	--				 , WhenMentalHealthDiagnosis, HaveYouEverInjected, HaveYouServedCustodialSentenceInPast
	--				 , EverDiagnosedMentalHealthIssue) values ()

	set @SurveyID = 1
end

  -- ClientId int not null,
  --CONSTRAINT FK_Survey_Client FOREIGN KEY (ClientId) REFERENCES Client(ID),

  --AssessmentType tinyint not null, -- 1: InitialAssessment, 2: Review
  --AssessmentDate date not null,
  --ClientType tinyint not null,  -- 1 OwnUse , 2 Others Use
  
  --ProgramId smallint not null,
  --CONSTRAINT FK_Survey_Program FOREIGN KEY (ProgramId) REFERENCES lk_Program(ID),
  
  --PDCDrugId smallint not null,
  --CONSTRAINT FK_Survey_Drug FOREIGN KEY (PDCDrugId) REFERENCES lk_Drugs(ID),
 
  --PDCAgeFirstUsed tinyint,

  --WhenMentalHealthDiagnosis tinyint, -- to be made into lookup
  --HaveYouEverInjected bit, -- ? -- not on client because it is useful to know when they had/declared it
  --HaveYouServedCustodialSentenceInPast bit, -- not on client because it is useful to know when they had/declared it
  --EverDiagnosedMentalHealthIssue bit, -- ? -- not on client because it is useful to know when they had/declared it