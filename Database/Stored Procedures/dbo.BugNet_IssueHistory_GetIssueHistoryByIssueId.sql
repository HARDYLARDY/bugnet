SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueHistory_GetIssueHistoryByIssueId]
	@IssueId INT
AS
	SELECT
		IssueHistoryId,
		IssueId,
		[U].[UserName] CreatorUserName,
		ISNULL([BNUserProfiles].[DisplayName], '') CreatorDisplayName,
		FieldChanged,
		OldValue,
		NewValue,
		DateCreated
	FROM
		[BNIssueHistory]
		INNER JOIN [dbo].[Users] U ON [BNIssueHistory].[UserId] = [U].[UserId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] ON [U].[UserName] = [BNUserProfiles].[UserName]
	WHERE
		IssueId = @IssueId
	ORDER BY
		DateCreated DESC;
GO
