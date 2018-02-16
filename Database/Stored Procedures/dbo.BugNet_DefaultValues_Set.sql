SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_DefaultValues_Set]
	@Type NVARCHAR(50),
	@ProjectId INT,
	@StatusId INT,
	@IssueOwnerUserName NVARCHAR(255),
	@IssuePriorityId INT,
	@IssueAssignedUserName NVARCHAR(255),
	@IssueVisibility INT,
	@IssueCategoryId INT,
	@IssueAffectedMilestoneId INT,
	@IssueDueDate INT,
	@IssueProgress INT,
	@IssueMilestoneId INT,
	@IssueEstimation DECIMAL(5, 2),
	@IssueResolutionId INT,
	@StatusVisibility BIT,
	@OwnedByVisibility BIT,
	@PriorityVisibility BIT,
	@AssignedToVisibility BIT,
	@PrivateVisibility BIT,
	@CategoryVisibility BIT,
	@DueDateVisibility BIT,
	@TypeVisibility BIT,
	@PercentCompleteVisibility BIT,
	@MilestoneVisibility BIT,
	@EstimationVisibility BIT,
	@ResolutionVisibility BIT,
	@AffectedMilestoneVisibility BIT,
	@OwnedByNotify BIT,
	@AssignedToNotify BIT
AS
	DECLARE @IssueAssignedUserId UNIQUEIDENTIFIER;
	DECLARE @IssueOwnerUserId UNIQUEIDENTIFIER;

	SELECT
		@IssueOwnerUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @IssueOwnerUserName;

	SELECT
		@IssueAssignedUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @IssueAssignedUserName;

	BEGIN
		BEGIN TRAN;

		DECLARE @defVisExists INT;

		SELECT
			@defVisExists = COUNT(*)
		FROM
			[BNDefaultValuesVisibility]
		WHERE
			[BNDefaultValuesVisibility].[ProjectId] = @ProjectId;

		IF ( @defVisExists > 0 )
		BEGIN
			UPDATE
				[BNDefaultValuesVisibility]
			SET
				StatusVisibility = @StatusVisibility,
				OwnedByVisibility = @OwnedByVisibility,
				PriorityVisibility = @PriorityVisibility,
				AssignedToVisibility = @AssignedToVisibility,
				PrivateVisibility = @PrivateVisibility,
				CategoryVisibility = @CategoryVisibility,
				DueDateVisibility = @DueDateVisibility,
				TypeVisibility = @TypeVisibility,
				PercentCompleteVisibility = @PercentCompleteVisibility,
				MilestoneVisibility = @MilestoneVisibility,
				EstimationVisibility = @EstimationVisibility,
				ResolutionVisibility = @ResolutionVisibility,
				AffectedMilestoneVisibility = @AffectedMilestoneVisibility
			WHERE
				ProjectId = @ProjectId;
		END;
		ELSE
		BEGIN
			INSERT INTO
				[BNDefaultValuesVisibility]
			VALUES
				 (
					 @ProjectId,
					 @StatusVisibility,
					 @OwnedByVisibility,
					 @PriorityVisibility,
					 @AssignedToVisibility,
					 @PrivateVisibility,
					 @CategoryVisibility,
					 @DueDateVisibility,
					 @TypeVisibility,
					 @PercentCompleteVisibility,
					 @MilestoneVisibility,
					 @EstimationVisibility,
					 @ResolutionVisibility,
					 @AffectedMilestoneVisibility
				 );
		END;

		DECLARE @defExists INT;

		SELECT
			@defExists = COUNT(*)
		FROM
			[BNDefaultValues]
		WHERE
			[BNDefaultValues].[ProjectId] = @ProjectId;

		IF ( @defExists > 0 )
		BEGIN
			UPDATE
				[BNDefaultValues]
			SET
				DefaultType = @Type,
				StatusId = @StatusId,
				IssueOwnerUserId = @IssueOwnerUserId,
				IssuePriorityId = @IssuePriorityId,
				IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
				IssueAssignedUserId = @IssueAssignedUserId,
				IssueVisibility = @IssueVisibility,
				IssueCategoryId = @IssueCategoryId,
				IssueDueDate = @IssueDueDate,
				IssueProgress = @IssueProgress,
				IssueMilestoneId = @IssueMilestoneId,
				IssueEstimation = @IssueEstimation,
				IssueResolutionId = @IssueResolutionId,
				OwnedByNotify = @OwnedByNotify,
				AssignedToNotify = @AssignedToNotify
			WHERE
				ProjectId = @ProjectId;
		END;
		ELSE
		BEGIN
			INSERT INTO
				[BNDefaultValues]
			VALUES
				 (
					 @ProjectId,
					 @Type,
					 @StatusId,
					 @IssueOwnerUserId,
					 @IssuePriorityId,
					 @IssueAffectedMilestoneId,
					 @IssueAssignedUserId,
					 @IssueVisibility,
					 @IssueCategoryId,
					 @IssueDueDate,
					 @IssueProgress,
					 @IssueMilestoneId,
					 @IssueEstimation,
					 @IssueResolutionId,
					 @OwnedByNotify,
					 @AssignedToNotify
				 );
		END;

		COMMIT TRAN;
	END;
GO
