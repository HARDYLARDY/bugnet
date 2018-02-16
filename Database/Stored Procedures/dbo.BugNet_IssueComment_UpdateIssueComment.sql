SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueComment_UpdateIssueComment]
	@IssueCommentId INT,
	@IssueId INT,
	@CreatorUserName NVARCHAR(255),
	@Comment NTEXT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @CreatorUserName;

	UPDATE
		[BNIssueComments]
	SET
		IssueId = @IssueId,
		UserId = @UserId,
		Comment = @Comment
	WHERE
		IssueCommentId = @IssueCommentId;
GO
