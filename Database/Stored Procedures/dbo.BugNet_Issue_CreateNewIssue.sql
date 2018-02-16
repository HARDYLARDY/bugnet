SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_CreateNewIssue]
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
	@IssueDueDate DATETIME,
	@IssueVisibility INT,
	@IssueEstimation DECIMAL(5, 2),
	@IssueProgress INT
AS
	DECLARE @IssueAssignedUserId UNIQUEIDENTIFIER;
	DECLARE @IssueCreatorUserId UNIQUEIDENTIFIER;
	DECLARE @IssueOwnerUserId UNIQUEIDENTIFIER;

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

	INSERT
		[BNIssues]
		 (
			 IssueTitle,
			 IssueDescription,
			 IssueCreatorUserId,
			 DateCreated,
			 IssueStatusId,
			 IssuePriorityId,
			 IssueTypeId,
			 IssueCategoryId,
			 IssueAssignedUserId,
			 ProjectId,
			 IssueResolutionId,
			 IssueMilestoneId,
			 IssueAffectedMilestoneId,
			 LastUpdateUserId,
			 LastUpdate,
			 IssueDueDate,
			 IssueVisibility,
			 IssueEstimation,
			 IssueProgress,
			 IssueOwnerUserId
		 )
	VALUES
		 (
			 @IssueTitle,
			 @IssueDescription,
			 @IssueCreatorUserId,
			 GETDATE(),
			 @IssueStatusId,
			 @IssuePriorityId,
			 @IssueTypeId,
			 @IssueCategoryId,
			 @IssueAssignedUserId,
			 @ProjectId,
			 @IssueResolutionId,
			 @IssueMilestoneId,
			 @IssueAffectedMilestoneId,
			 @IssueCreatorUserId,
			 GETDATE(),
			 @IssueDueDate,
			 @IssueVisibility,
			 @IssueEstimation,
			 @IssueProgress,
			 @IssueOwnerUserId
		 );

	RETURN SCOPE_IDENTITY();
GO
