SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueComment_GetIssueCommentsByIssueId]
	@IssueId INT
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
		IssueId = @IssueId
	ORDER BY
		DateCreated DESC;
GO
