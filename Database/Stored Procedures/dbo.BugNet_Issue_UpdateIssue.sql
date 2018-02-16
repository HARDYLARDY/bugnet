SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateIssue]
	@IssueId INT,
	@IssueTitle NVARCHAR(500),
	@IssueDescription NVARCHAR(MAX),
	@ProjectId INT,
	@IssueCategoryId INT,
	@IssueStatusId INT,
	@IssuePriorityId INT,
	@IssueMilestoneId INT,
	@IssueAffectedMilestoneId INT,
	@IssueTypeId INT,
	@IssueResolutionId INT,
	@IssueAssignedUserName NVARCHAR(255),
	@IssueCreatorUserName NVARCHAR(255),
	@IssueOwnerUserName NVARCHAR(255),
	@LastUpdateUserName NVARCHAR(255),
	@IssueDueDate DATETIME,
	@IssueVisibility INT,
	@IssueEstimation DECIMAL(5, 2),
	@IssueProgress INT
AS
	DECLARE @IssueAssignedUserId UNIQUEIDENTIFIER;
	DECLARE @IssueCreatorUserId UNIQUEIDENTIFIER;
	DECLARE @IssueOwnerUserId UNIQUEIDENTIFIER;
	DECLARE @LastUpdateUserId UNIQUEIDENTIFIER;

	SELECT
		@IssueAssignedUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @IssueAssignedUserName;

	SELECT
		@IssueCreatorUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @IssueCreatorUserName;

	SELECT
		@IssueOwnerUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @IssueOwnerUserName;

	SELECT
		@LastUpdateUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @LastUpdateUserName;

	BEGIN TRAN;

	UPDATE
		[BNIssues]
	SET
		IssueTitle = @IssueTitle,
		IssueCategoryId = @IssueCategoryId,
		ProjectId = @ProjectId,
		IssueStatusId = @IssueStatusId,
		IssuePriorityId = @IssuePriorityId,
		IssueMilestoneId = @IssueMilestoneId,
		IssueAffectedMilestoneId = @IssueAffectedMilestoneId,
		IssueAssignedUserId = @IssueAssignedUserId,
		IssueOwnerUserId = @IssueOwnerUserId,
		IssueTypeId = @IssueTypeId,
		IssueResolutionId = @IssueResolutionId,
		IssueDueDate = @IssueDueDate,
		IssueVisibility = @IssueVisibility,
		IssueEstimation = @IssueEstimation,
		IssueProgress = @IssueProgress,
		IssueDescription = @IssueDescription,
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GETDATE()
	WHERE
		IssueId = @IssueId;

	/*EXEC BugNet_IssueHistory_CreateNewHistory @IssueId, @IssueCreatorId*/
	COMMIT TRAN;
GO
