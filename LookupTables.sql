------------------------------------------------------
-- Project: ATOM Client Outcome Measures (COMS)
-- Description: Lookup Tables to match the SurveyJS schema
-- Author: Aftab Jalal (MJ)
-- Create Date: 4/3/2021
------------------------------------------------------

CREATE TABLE lk_FrequencyLowGood (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (30) UNIQUE,
  Score tinyint UNIQUE
);


-- ALTER TABLE [lk_FrequencyLowGood] ADD UNIQUE (Score);

insert into lk_FrequencyLowGood (Name, Score) values ('Daily or almost daily', 0);
insert into lk_FrequencyLowGood (Name, Score) values ('Three or four times per week', 1);
insert into lk_FrequencyLowGood (Name, Score) values ('Once or twice per week', 2);
insert into lk_FrequencyLowGood (Name, Score) values ('Less than weekly', 3);
insert into lk_FrequencyLowGood (Name, Score) values ('Not at all', 4);


create table lk_FrequencyHighGood (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (30) UNIQUE,
  Score tinyint  
);


insert into lk_FrequencyHighGood (Name, Score) values ('Daily or almost daily', 4);
insert into lk_FrequencyHighGood (Name, Score) values ('Three or four times per week', 3);
insert into lk_FrequencyHighGood (Name, Score) values ('Once or twice per week', 2);
insert into lk_FrequencyHighGood (Name, Score) values ('Less than weekly', 1);
insert into lk_FrequencyHighGood (Name, Score) values ('Not at all', 0);

-----------------------------------------------------------------------------


CREATE TABLE lk_Program (
   ID smallint not null IDENTITY PRIMARY key,
   Name varchar(150) UNIQUE,
   SurveyCode varchar(12) UNIQUE
);
insert into lk_Program (name, SurveyCode) values ('TSS', 'TSS');
insert into lk_Program (name, SurveyCode) values ('Arcadia CoCo', 'ARCCOCO');
insert into lk_Program (name, SurveyCode) values ('Arcadia Resi', 'ARCRESI');
insert into lk_Program (name, SurveyCode) values ('Sapphire Health & Wellbeing Service','SAPPHIRE');
insert into lk_Program (name, SurveyCode) values ('Eurobodalla','EUROPATH');
insert into lk_Program (name, SurveyCode) values ('Monaro','MONPATH');
insert into lk_Program (name, SurveyCode) values ('Bega','BEGAPATH');
insert into lk_Program (name, SurveyCode) values ('Murrumbidgee Ice','MURMICE');
insert into lk_Program (name, SurveyCode) values ('Goulburn General','GOLBGNRL');
insert into lk_Program (name, SurveyCode) values ('Goulburn Ice','GOLBICE');
insert into lk_Program (name, SurveyCode) values ('Griffith Headspace','GRIFHEAD');



--Your Current Housing
create table lk_HousingStability (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (50) UNIQUE
);

insert into lk_HousingStability (name) values ('Stable permanent housing');
insert into lk_HousingStability (name) values ('Some issues - but mostly ok');
insert into lk_HousingStability (name) values ('At risk of eviction');
insert into lk_HousingStability (name) values ('Temporary housing / couch surfing');
insert into lk_HousingStability (name) values ('Homeless');


----DoYouFeelSafeWhereYouLive
create table lk_DegreesOfSafety (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (60) UNIQUE
);

insert into lk_DegreesOfSafety (name) values ('Yes - Completely safe');
insert into lk_DegreesOfSafety (name) values ('Mostly safe. Sometimes feel threatened');
insert into lk_DegreesOfSafety (name) values ('Often feel unsafe / Occasionally experience violence');
insert into lk_DegreesOfSafety (name) values ('Never feel safe / Constantly exposed to violence');


create table lk_Drugs(
  ID smallint not null IDENTITY PRIMARY key,
  Name nvarchar(150) not NULL UNIQUE
);

insert into lk_Drugs (name) values ('Alcohol');
insert into lk_Drugs (name) values ('Cannabinoids and related drugs');
insert into lk_Drugs (name) values ('Amphetamines');
insert into lk_Drugs (name) values ('MDMA / Ecstacy');
insert into lk_Drugs (name) values ('Psychostimulants');
insert into lk_Drugs (name) values ('Benzodiazepines');
insert into lk_Drugs (name) values ('Pharmaceutical Opioids');
insert into lk_Drugs (name) values ('Heroin');
insert into lk_Drugs (name) values ('Methadone');
insert into lk_Drugs (name) values ('Cocaine');
insert into lk_Drugs (name) values ('Nicotine');
insert into lk_Drugs (name) values ('Caffeine');
insert into lk_Drugs (name) values ('Steroids and other anabolic agents');
insert into lk_Drugs (name) values ('Gambling');
insert into lk_Drugs (name) values ('Other');


CREATE TABLE lk_OtherBehavioursOfDependence (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(40) UNIQUE
);
insert into lk_OtherBehavioursOfDependence (name) values ('Gambling');
insert into lk_OtherBehavioursOfDependence (name) values ('Porn');
insert into lk_OtherBehavioursOfDependence (name) values ('Sex');
insert into lk_OtherBehavioursOfDependence (name) values ('Internet / Social Media');
insert into lk_OtherBehavioursOfDependence (name) values ('Gaming');
insert into lk_OtherBehavioursOfDependence (name) values ('Hoarding');


CREATE TABLE lk_Risks (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(100) UNIQUE
);
insert into lk_Risks (name) values ('Memory Loss');
insert into lk_Risks (name) values ('Using Alone');
insert into lk_Risks (name) values ('Using more than one drug at a time');
insert into lk_Risks (name) values ('Violence / Assault');
insert into lk_Risks (name) values ('Unsafe sex');
insert into lk_Risks (name) values ('Blackouts');
insert into lk_Risks (name) values ('Driving with drugs and/or alcohol in your system');
insert into lk_Risks (name) values ('Sharing injecting equipment');
insert into lk_Risks (name) values ('Overdose or hospitalisation from drinking / using drugs');
insert into lk_Risks (name) values ('Attended by an ambulance or been in hospital');


CREATE TABLE lk_MethodOfUses
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(50) UNIQUE
);

insert into lk_MethodOfUses  (Name) values  ('Ingest');
insert into lk_MethodOfUses  (Name) values  ('Inject');
insert into lk_MethodOfUses  (Name) values  ('Smoke');
insert into lk_MethodOfUses  (Name) values  ('Sniff (powder)');
insert into lk_MethodOfUses  (Name) values  ('Inhale (vapour)');
insert into lk_MethodOfUses  (Name) values  ('Transdermal');
insert into lk_MethodOfUses  (Name) values  ('Sublingual');
insert into lk_MethodOfUses  (Name) values  ('Other');


CREATE TABLE lk_DrugUnits
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name nvarchar(50) UNIQUE
);
insert into lk_DrugUnits (Name) values ('standard drinks');
insert into lk_DrugUnits (Name) values ('cones / joints');
insert into lk_DrugUnits (Name) values ('points');
insert into lk_DrugUnits (Name) values ('quarts');
insert into lk_DrugUnits (Name) values ('grams');
insert into lk_DrugUnits (Name) values ('points');
insert into lk_DrugUnits (Name) values ('$$$');
insert into lk_DrugUnits (Name) values ('pills');
insert into lk_DrugUnits (Name) values ('lines');
insert into lk_DrugUnits (Name) values ('dosage (mgs)');
insert into lk_DrugUnits (Name) values ('dosage (mls)');
insert into lk_DrugUnits (Name) values ('cigarettes / darts');


CREATE TABLE lk_DrugUseGoals
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(40) UNIQUE
);
insert into lk_DrugUseGoals (Name) values ('Cease Use');
insert into lk_DrugUseGoals (Name) values ('Reduce Use');
insert into lk_DrugUseGoals (Name) values ('Reduce Harms');
insert into lk_DrugUseGoals (Name) values ('Not wanting to change substance use');
insert into lk_DrugUseGoals (Name) values ('No Goals - Ceased Use');


CREATE TABLE lk_MentalHealthRisks
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(100) UNIQUE
);
insert into lk_MentalHealthRisks (name) values ('Suicidal thoughts, ideation, planning, attempts (RISK ASSESSMENT)');
insert into lk_MentalHealthRisks (name) values ('Mood or affect concerns, including profound, persistent hopelessness (RISK ASSESSMENT)');
insert into lk_MentalHealthRisks (name) values ('Recent Loss');
insert into lk_MentalHealthRisks (name) values ('Suicide of significant other');
insert into lk_MentalHealthRisks (name) values ('Extreme stress');
insert into lk_MentalHealthRisks (name) values ('Self Injury');
insert into lk_MentalHealthRisks (name) values ('Impulsive and/or aggressive tendencies');
insert into lk_MentalHealthRisks (name) values ('Withdrawn');
insert into lk_MentalHealthRisks (name) values ('Recent sexual abuse');
insert into lk_MentalHealthRisks (name) values ('Recent physical abuse');
insert into lk_MentalHealthRisks (name) values ('Prison / custody / legal problems');
insert into lk_MentalHealthRisks (name) values ('Thought content concerns, including delusional content');
insert into lk_MentalHealthRisks (name) values ('Other traumatic event');


CREATE TABLE lk_Engagement (
  ID int not null identity PRIMARY key,
  Name VARCHAR(100) not null UNIQUE
);

insert into lk_Engagement (Name) values ('Paid work');
insert into lk_Engagement (Name) values ('Voluntary work');
insert into lk_Engagement (Name) values ('Education');
insert into lk_Engagement (Name) values ('Looking after children');
insert into lk_Engagement (Name) values ('Other caregiving activities');