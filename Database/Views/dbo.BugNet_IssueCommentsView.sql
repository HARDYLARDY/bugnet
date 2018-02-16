SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_IssueCommentsView]
AS
	SELECT
		[dbo].[BNIssueComments].[IssueCommentId],
		[dbo].[BNIssueComments].[IssueId],
		[BugNet_IssuesView].[ProjectId],
		[dbo].[BNIssueComments].[Comment],
		[dbo].[BNIssueComments].[DateCreated],
		[BugNet_UserView].[UserId] AS CreatorUserId,
		[BugNet_UserView].[DisplayName] AS CreatorDisplayName,
		[BugNet_UserView].[UserName] AS CreatorUserName,
		[BugNet_IssuesView].[Disabled] AS IssueDisabled,
		[BugNet_IssuesView].[IsClosed] AS IssueIsClosed,
		[BugNet_IssuesView].[IssueVisibility],
		[BugNet_IssuesView].[ProjectCode],
		[BugNet_IssuesView].[ProjectName],
		[BugNet_IssuesView].[ProjectDisabled]
	FROM
		[dbo].[BugNet_IssuesView]
		INNER JOIN [dbo].[BNIssueComments] ON [BugNet_IssuesView].[IssueId] = [dbo].[BNIssueComments].[IssueId]
		INNER JOIN [dbo].[BugNet_UserView] ON [dbo].[BNIssueComments].[UserId] = dbo.BugNet_UserView.UserId;
GO
