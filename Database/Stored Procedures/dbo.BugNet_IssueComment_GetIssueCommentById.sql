SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentById]
	@IssueCommentId INT
AS
	SELECT
		IssueCommentId,
		IssueId,
		Comment,
		[U].[UserId] CreatorUserId,
		[U].[UserName] CreatorUserName,
		ISNULL([BNUserProfiles].[DisplayName], '') CreatorDisplayName,
		DateCreated
	FROM
		[BNIssueComments]
		INNER JOIN [dbo].[Users] U ON [BNIssueComments].[UserId] = [U].[UserId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] ON [U].[UserName] = [BNUserProfiles].[UserName]
	WHERE
		IssueCommentId = @IssueCommentId;
GO
