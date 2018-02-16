SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_Issue_IssueTypeCountView]
AS
	SELECT TOP ( 100 ) PERCENT
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssueTypeId], 0) AS IssueTypeId,
		[BugNet_IssuesView].[IssueTypeName],
		[BugNet_IssuesView].[IssueTypeImageUrl],
		ISNULL([dbo].[BNProjectIssueTypes].[SortOrder], 99) AS SortOrder,
		COUNT(DISTINCT [BugNet_IssuesView].[IssueId]) AS Number
	FROM
		[dbo].[BugNet_IssuesView]
		LEFT OUTER JOIN [dbo].[BNProjectIssueTypes] ON [BugNet_IssuesView].[IssueTypeId] = [dbo].[BNProjectIssueTypes].[IssueTypeId]
	WHERE
		( [BugNet_IssuesView].[IsClosed] = 0 )
		AND ( [BugNet_IssuesView].[Disabled] = 0 )
	GROUP BY
		[BugNet_IssuesView].[IssueTypeName],
		[BugNet_IssuesView].[IssueTypeImageUrl],
		ISNULL([dbo].[BNProjectIssueTypes].[SortOrder], 99),
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssueTypeId], 0)
	ORDER BY
		[BugNet_IssuesView].[ProjectId];
GO
