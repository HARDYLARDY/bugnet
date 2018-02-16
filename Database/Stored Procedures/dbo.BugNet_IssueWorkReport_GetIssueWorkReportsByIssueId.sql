SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_GetIssueWorkReportsByIssueId]
	@IssueId INT
AS
	SELECT
		[BNIssueWorkReports].[IssueWorkReportId],
		[BNIssueWorkReports].[IssueId],
		[BNIssueWorkReports].[WorkDate],
		[BNIssueWorkReports].[Duration],
		[BNIssueWorkReports].[IssueCommentId],
		[BNIssueWorkReports].[UserId] CreatorUserId,
		[U].[UserName] CreatorUserName,
		ISNULL([BNUserProfiles].[DisplayName], '') CreatorDisplayName,
		ISNULL([BNIssueComments].[Comment], '') Comment
	FROM
		[dbo].[BNIssueWorkReports]
		INNER JOIN [dbo].[Users] U ON [BNIssueWorkReports].[UserId] = [U].[UserId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] ON [U].[UserName] = [BNUserProfiles].[UserName]
		LEFT OUTER JOIN [BNIssueComments] ON [BNIssueComments].[IssueCommentId] = [BNIssueWorkReports].[IssueCommentId]
	WHERE
		[BNIssueWorkReports].[IssueId] = @IssueId
	ORDER BY
		[BNIssueWorkReports].[WorkDate] DESC;
GO
