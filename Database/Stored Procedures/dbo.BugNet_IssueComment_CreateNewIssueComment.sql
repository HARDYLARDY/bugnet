SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueComment_CreateNewIssueComment]
	@IssueId INT,
	@CreatorUserName NVARCHAR(255),
	@Comment NTEXT
AS
	-- Get Last Update UserID
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @CreatorUserName;

	INSERT
		[BNIssueComments]
		 (
			 IssueId,
			 UserId,
			 DateCreated,
			 Comment
		 )
	VALUES
		 (
			 @IssueId, @UserId, GETDATE(), @Comment
		 );

	/* Update the LastUpdate fields of this bug*/
	UPDATE
		[dbo].[BNIssues]
	SET
		[BNIssues].[LastUpdate] = GETDATE(),
		[BNIssues].[LastUpdateUserId] = @UserId
	WHERE
		[BNIssues].[IssueId] = @IssueId;

	RETURN SCOPE_IDENTITY();
GO
