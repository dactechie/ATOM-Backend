
--DoYouFeelSafeWhereYouLive
--      "Yes - Completely safe",
--      "Mostly safe. Sometimes feel threatened",
--      "Often feel unsafe / Occasionally experience violence",
--      "Never feel safe / Constantly exposed to violence"

--YourCurrentHousing
      --"Stable permanent housing",
      --"Some issues - but mostly ok",
      --"At risk of eviction",
      --"Temporary housing / couch surfing",
      --"Homeless"


     --name: "Past4WkDailyLivingImpacted",
     --title: "Impact on Daily Living",
    --   "Once or twice a week",<<<-- PROB:LEM  'a' week not per
     -- "Three or four times a week",  <<<-- PROB:LEM  'a' week not per

CREATE PROCEDURE sp_insertRecentLifestyleImpactConcern(
		@SurveyID int
		, @SurveyJSON nvarchar(max)
		--, @insertedId int output
		)
as 
	DECLARE @diffHousing varchar(30), @phyHealth varchar(2), @mentHealth varchar(2),
			@phyHealthProb varchar(30), @menHealthProb varchar(30),
			@Past4WkUseLedToProblemsWithFamilyFriend varchar(30),
			@DoYouFeelSafeWhereYouLive varchar(50), @YourCurrentHousing varchar(40),

			@NoYesString varchar(40),
			--@arrested varchar(3), @violentAbusive varchar(30),	@careGiving varchar(3),

			@Past4WkHaveDVOrFamilySafetyConcerns bit, @Past4WkBeenArrested bit,
			@Past4WkHaveYouViolenceAbusive bit, @Past4WkHadCaregivingResponsibilities bit,
			@Past4WkHowOftenIllegalActivities varchar(30),
			@Past4WkQualityOfLifeScore varchar(2);
	
	set @diffHousing = JSON_VALUE(@SurveyJSON, '$.Past4WkDifficultyFindingHousing');
	set @phyHealth = JSON_VALUE(@SurveyJSON, '$.Past4WkPhysicalHealth');
	set @mentHealth = JSON_VALUE(@SurveyJSON, '$.Past4WkMentalHealth');
	set @phyHealthProb = JSON_VALUE(@SurveyJSON, '$.Past4WkHowOftenPhysicalHealthCausedProblems');
	set @menHealthProb = JSON_VALUE(@SurveyJSON, '$.Past4WkHowOftenMentalHealthCausedProblems');
	set @Past4WkUseLedToProblemsWithFamilyFriend = JSON_VALUE(@SurveyJSON, '$.Past4WkUseLedToProblemsWithFamilyFriend');

	set @DoYouFeelSafeWhereYouLive = JSON_VALUE(@SurveyJSON, '$.DoYouFeelSafeWhereYouLive');
	set @YourCurrentHousing = JSON_VALUE(@SurveyJSON, '$.YourCurrentHousing');
	
	set @NoYesString = JSON_VALUE(@SurveyJSON, '$.HaveDVOrFamilySafetyConcerns');
	if @NoYesString is not null
		if @NoYesString = 'No'--"No",  -- "Yes (risk assessment required)"
			set @Past4WkHaveDVOrFamilySafetyConcerns  = 0 
		else
			set @Past4WkHaveDVOrFamilySafetyConcerns = 1

	set @NoYesString = JSON_VALUE(@SurveyJSON, '$.Past4WkBeenArrested');
	if @NoYesString is not null
		if @NoYesString = 'No'--"No",  -- "Yes (risk assessment required)"
			set @Past4WkBeenArrested  = 0 
		else
			set @Past4WkBeenArrested = 1

	set @NoYesString = JSON_VALUE(@SurveyJSON, '$.Past4WkHaveYouViolenceAbusive');
	if @NoYesString is not null
		if @NoYesString = 'No'--"No",  -- "Yes (risk assessment required)"
			set @Past4WkHaveYouViolenceAbusive  = 0 
		else
			set @Past4WkHaveYouViolenceAbusive = 1

	set @NoYesString = JSON_VALUE(@SurveyJSON, '$.Past4WkHadCaregivingResponsibilities');
	if @NoYesString is not null
		if @NoYesString = 'No'--"No",  -- "Yes"
			set @Past4WkHadCaregivingResponsibilities  = 0 
		else
			set @Past4WkHadCaregivingResponsibilities = 1
	

	set @Past4WkHowOftenIllegalActivities = JSON_VALUE(@SurveyJSON, '$.Past4WkHowOftenIllegalActivities');
	set @Past4WkQualityOfLifeScore = JSON_VALUE(@SurveyJSON, '$.Past4WkQualityOfLifeScore');
	
	insert into RecentLifestyleImpactConcern (
				SurveyId,
				DoYouFeelSafeWhereYouLive,
				YourCurrentHousing,
				Past4WkPhysicalHealth,
				Past4WkMentalHealth,
				Past4WkDifficultyFindingHousing,
				Past4WkHowOftenPhysicalHealthCausedProblems,
				Past4WkHowOftenMentalHealthCausedProblems,
				Past4WkUseLedToProblemsWithFamilyFriend,
				Past4WkHaveDVOrFamilySafetyConcerns,
				Past4WkHaveYouViolenceAbusive,
				Past4WkHadCaregivingResponsibilities,
				Past4WkBeenArrested,
				Past4WkHowOftenIllegalActivities,
				Past4WkQualityOfLifeScore
				) 
	values
	(
		@SurveyID,
		--DoYouFeelSafeWhereYouLive
		(select F.ID from dbo.lk_DegreesOfSafety F where F.Name = @DoYouFeelSafeWhereYouLive),
	
		--YourCurrentHousing
		(select F.ID from dbo.lk_HousingStability F where F.Name = @YourCurrentHousing),

		cast(@phyHealth as tinyint),
		cast(@mentHealth as tinyint),

		--Past4WkDifficultyFindingHousing
		(select F.Score from dbo.lk_FrequencyLowGood F where F.Name = @diffHousing),
		--Past4WkHowOftenPhysicalHealthCausedProblems
		(select F.Score from dbo.lk_FrequencyLowGood F where F.Name = @phyHealthProb),
		-- Past4WkHowOftenMentalHealthCausedProblems
		(select F.Score from dbo.lk_FrequencyLowGood F where F.Name = @menHealthProb),
		--@Past4WkUseLedToProblemsWithFamilyFriend
		(select F.Score from dbo.lk_FrequencyLowGood F where F.Name = @Past4WkUseLedToProblemsWithFamilyFriend),

		--@Past4WkHaveDVOrFamilySafetyConcerns
		@Past4WkHaveDVOrFamilySafetyConcerns,

		--@Past4WkHaveYouViolenceAbusive
		@Past4WkHaveYouViolenceAbusive,
		
		--Past4WkHadCaregivingResponsibilities
		@Past4WkHadCaregivingResponsibilities,

		-- Past4WkBeenArrested
		@Past4WkBeenArrested,

		--@Past4WkHowOftenIllegalActivities
		(select F.Score from dbo.lk_FrequencyLowGood F where F.Name = @Past4WkHowOftenIllegalActivities),
		
		--Past4WkQualityOfLifeScore
		cast(@Past4WkQualityOfLifeScore as tinyint)
	)

--	set @insertedId = SCOPE_IDENTITY();
return

