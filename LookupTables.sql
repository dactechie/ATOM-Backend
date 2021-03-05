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
  Score tinyint unique
);

insert into lk_FrequencyHighGood (Name, Score) values ('Daily or almost daily', 4);
insert into lk_FrequencyHighGood (Name, Score) values ('Three or four times per week', 3);
insert into lk_FrequencyHighGood (Name, Score) values ('Once or twice per week', 2);
insert into lk_FrequencyHighGood (Name, Score) values ('Less than weekly', 1);
insert into lk_FrequencyHighGood (Name, Score) values ('Not at all', 0);


create table lk_VWellUnableTo (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (30) UNIQUE
);

insert into lk_VWellUnableTo (Name) values ('Very well');
insert into lk_VWellUnableTo (Name) values ('Reasonably well');
insert into lk_VWellUnableTo (Name) values ('Moderately well');
insert into lk_VWellUnableTo (Name) values ('Not very well');
insert into lk_VWellUnableTo (Name) values ('I''m unable to');



create table lk_SupportType (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (120) UNIQUE
);

insert into lk_SupportType (Name) values ('AOD Brief Intervention (1-3 sessions, then review)');
insert into lk_SupportType (Name) values ('AOD counselling & support (3 - 6 sessions, then review)');
insert into lk_SupportType (Name) values ('Case Management');
insert into lk_SupportType (Name) values ('Group participation - ADAPT / SMART Recovery / COMPASS / Butt it Out');
insert into lk_SupportType (Name) values ('Information & Education');
insert into lk_SupportType (Name) values ('Arcadia Residential Service - Non-medicated Detox Program 1 week');
insert into lk_SupportType (Name) values ('Arcadia Residential Service - 12 week Transition Program');
insert into lk_SupportType (Name) values ('Arcadia Residential Service - 12 week Day Program');
insert into lk_SupportType (Name) values ('Althea GP');
insert into lk_SupportType (Name) values ('Althea Nurse');
insert into lk_SupportType (Name) values ('Althea Psychologist');
insert into lk_SupportType (Name) values ('Support, information and/or counselling as a family member or friend of a person with a substance use issues');
insert into lk_SupportType (Name) values ('Supported home Detox');
insert into lk_SupportType (Name) values ('Aboriginal Health Worker');
insert into lk_SupportType (Name) values ('Primary Health Support');



create table lk_HowLongAgo (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar (60) UNIQUE
);
insert into lk_HowLongAgo (Name) values ('Within last 4 weeks');
insert into lk_HowLongAgo (Name) values ('Within the last three months');
insert into lk_HowLongAgo (Name) values ('More than three months but less than twelve months ago');
insert into lk_HowLongAgo (Name) values ('More than twelve months ago');
insert into lk_HowLongAgo (Name) values ('Never');
insert into lk_HowLongAgo (Name) values ('Not stated/inadequately described');


--update lk_HowLongAgo
--	set Name = 'Never'
--	where Name = 'Never injected'

--update lk_HowLongAgo
--	set Name = 'Not stated/inadequately described'
--	where Name = 'Not Stated'

-----------------------------------------------------------------------------
-- Social Support

CREATE TABLE lk_LotNone (
	ID tinyint not null identity primary key,
	Name varchar(20) unique
);
insert into lk_LotNone (Name) values ('A wide range');
insert into lk_LotNone (Name) values ('Quite a lot');
insert into lk_LotNone (Name) values ('Some');
insert into lk_LotNone (Name) values ('A few');
insert into lk_LotNone (Name) values ('None');



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






CREATE TABLE lk_MethodOfUse
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(50) UNIQUE
);

insert into lk_MethodOfUse (Name) values  ('Ingest');
insert into lk_MethodOfUse (Name) values  ('Inject');
insert into lk_MethodOfUse (Name) values  ('Smoke');
insert into lk_MethodOfUse (Name) values  ('Sniff (powder)');
insert into lk_MethodOfUse (Name) values  ('Inhale (vapour)');
insert into lk_MethodOfUse (Name) values  ('Transdermal');
insert into lk_MethodOfUse (Name) values  ('Sublingual');
insert into lk_MethodOfUse (Name) values  ('Other');


CREATE TABLE lk_DrugUnit
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name nvarchar(50) UNIQUE
);
insert into lk_DrugUnit (Name) values ('standard drinks');
insert into lk_DrugUnit (Name) values ('cones / joints');
insert into lk_DrugUnit (Name) values ('points');
insert into lk_DrugUnit (Name) values ('quarts');
insert into lk_DrugUnit (Name) values ('grams');
insert into lk_DrugUnit (Name) values ('$$$');
insert into lk_DrugUnit (Name) values ('pills');
insert into lk_DrugUnit (Name) values ('lines');
insert into lk_DrugUnit (Name) values ('dosage (mgs)');
insert into lk_DrugUnit (Name) values ('dosage (mls)');
insert into lk_DrugUnit (Name) values ('cigarettes / darts');



CREATE TABLE lk_DrugUseGoal
(
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(40) UNIQUE
);
insert into lk_DrugUseGoal (Name) values ('Cease Use');
insert into lk_DrugUseGoal (Name) values ('Reduce Use');
insert into lk_DrugUseGoal (Name) values ('Reduce Harms');
insert into lk_DrugUseGoal (Name) values ('Not wanting to change substance use');
insert into lk_DrugUseGoal (Name) values ('No Goals - Ceased Use');




CREATE TABLE lk_Risk (
  ID tinyint not null IDENTITY PRIMARY key,
  Name varchar(100) UNIQUE,
  RiskType tinyint not null -- 0:Aod risk , 1 MentalHealth Risk
);
insert into lk_Risk (name, RiskType) values ('Memory Loss', 0);
insert into lk_Risk (name, RiskType)values ('Using Alone',0 );
insert into lk_Risk (name, RiskType)values ('Using more than one drug at a time',0);
insert into lk_Risk (name, RiskType)values ('Violence / Assault',0);
insert into lk_Risk (name, RiskType)values ('Unsafe sex',0);
insert into lk_Risk (name, RiskType)values ('Blackouts',0);
insert into lk_Risk (name, RiskType)values ('Driving with drugs and/or alcohol in your system',0);
insert into lk_Risk (name, RiskType)values ('Sharing injecting equipment',0);
insert into lk_Risk (name, RiskType)values ('Overdose or hospitalisation from drinking / using drugs',0);
insert into lk_Risk (name, RiskType)values ('Attended by an ambulance or been in hospital',0);

insert into lk_Risk (name, RiskType) values ('Suicidal thoughts, ideation, planning, attempts (RISK ASSESSMENT)',1);
insert into lk_Risk (name, RiskType) values ('Mood or affect concerns, including profound, persistent hopelessness (RISK ASSESSMENT)',1);
insert into lk_Risk (name, RiskType) values ('Recent Loss',1);
insert into lk_Risk (name, RiskType) values ('Suicide of significant other',1);
insert into lk_Risk (name, RiskType) values ('Extreme stress',1);
insert into lk_Risk (name, RiskType) values ('Self Injury',1);
insert into lk_Risk (name, RiskType) values ('Impulsive and/or aggressive tendencies',1);
insert into lk_Risk (name, RiskType) values ('Withdrawn',1);
insert into lk_Risk (name, RiskType) values ('Recent sexual abuse',1);
insert into lk_Risk (name, RiskType) values ('Recent physical abuse',1);
insert into lk_Risk (name, RiskType) values ('Prison / custody / legal problems',1);
insert into lk_Risk (name, RiskType) values ('Thought content concerns, including delusional content',1);
insert into lk_Risk (name, RiskType) values ('Other traumatic event',1);



--CREATE TABLE lk_MentalHealthRisk
--(
--  ID tinyint not null IDENTITY PRIMARY key,
--  Name varchar(100) UNIQUE
--);
--insert into lk_MentalHealthRisk (name) values ('Suicidal thoughts, ideation, planning, attempts (RISK ASSESSMENT)');
--insert into lk_MentalHealthRisk (name) values ('Mood or affect concerns, including profound, persistent hopelessness (RISK ASSESSMENT)');
--insert into lk_MentalHealthRisk (name) values ('Recent Loss');
--insert into lk_MentalHealthRisk (name) values ('Suicide of significant other');
--insert into lk_MentalHealthRisk (name) values ('Extreme stress');
--insert into lk_MentalHealthRisk (name) values ('Self Injury');
--insert into lk_MentalHealthRisk (name) values ('Impulsive and/or aggressive tendencies');
--insert into lk_MentalHealthRisk (name) values ('Withdrawn');
--insert into lk_MentalHealthRisk (name) values ('Recent sexual abuse');
--insert into lk_MentalHealthRisk (name) values ('Recent physical abuse');
--insert into lk_MentalHealthRisk (name) values ('Prison / custody / legal problems');
--insert into lk_MentalHealthRisk (name) values ('Thought content concerns, including delusional content');
--insert into lk_MentalHealthRisk (name) values ('Other traumatic event');



CREATE TABLE lk_Engagement (
  ID tinyint not null identity PRIMARY key,
  Name VARCHAR(100) not null UNIQUE
);

insert into lk_Engagement (Name) values ('Paid work');
insert into lk_Engagement (Name) values ('Voluntary work');
insert into lk_Engagement (Name) values ('Education');
insert into lk_Engagement (Name) values ('Looking after children');
insert into lk_Engagement (Name) values ('Other caregiving activities');




 create table lk_PrimaryCaregiver (
   ID tinyint not null IDENTITY PRIMARY key,
   Name varchar (200)
 );

 insert into lk_PrimaryCaregiver (name) values ('Yes - primary caregiver: children under 5 years old');
 insert into lk_PrimaryCaregiver (name) values ('Yes - primary caregiver: children 5 - 15 years old');
 insert into lk_PrimaryCaregiver (name) values ('Yes - primary caregiver: children 15 - 18 years old');
 insert into lk_PrimaryCaregiver (name) values ('Yes - parenting responsibilities but children don''t live with me');
 insert into lk_PrimaryCaregiver (name) values ('Yes - parenting responsibilities for children other than my own');
 insert into lk_PrimaryCaregiver (name) values ('Living with children other than my own, but no parental responsibility');
 insert into lk_PrimaryCaregiver (name) values ('No');