SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueVote_CreateNewIssueVote]
	@IssueId INT,
	@VoteUserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @VoteUserName;

	IF NOT EXISTS ( SELECT IssueVoteId FROM [BNIssueVotes] WHERE UserId = @UserId AND IssueId = @IssueId )
	BEGIN
		INSERT [BNIssueVotes] ( IssueId, UserId, DateCreated ) VALUES ( @IssueId, @UserId, GETDATE());

		RETURN SCOPE_IDENTITY();
	END;
GO
