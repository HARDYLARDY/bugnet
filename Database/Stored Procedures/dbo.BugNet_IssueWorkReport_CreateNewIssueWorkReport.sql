SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_CreateNewIssueWorkReport]
	@IssueId INT,
	@CreatorUserName NVARCHAR(255),
	@WorkDate DATETIME,
	@Duration DECIMAL(4, 2),
	@IssueCommentId INT
AS
	-- Get Last Update UserID
	DECLARE @CreatorUserId UNIQUEIDENTIFIER;

	SELECT
		@CreatorUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @CreatorUserName;

	INSERT
		[BNIssueWorkReports]
		 (
			 IssueId,
			 UserId,
			 WorkDate,
			 Duration,
			 IssueCommentId
		 )
	VALUES
		 (
			 @IssueId, @CreatorUserId, @WorkDate, @Duration, @IssueCommentId
		 );

	RETURN SCOPE_IDENTITY();
GO
