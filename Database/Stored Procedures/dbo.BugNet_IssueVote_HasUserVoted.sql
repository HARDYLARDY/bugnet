SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueVote_HasUserVoted]
	@IssueId INT,
	@VoteUserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @VoteUserName;

	BEGIN
		IF EXISTS ( SELECT IssueVoteId FROM [BNIssueVotes] WHERE UserId = @UserId AND IssueId = @IssueId )
			RETURN ( 1 );
		ELSE
			RETURN ( 0 );
	END;
GO
