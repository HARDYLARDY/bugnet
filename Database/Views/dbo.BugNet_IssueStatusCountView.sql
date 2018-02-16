SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_IssueStatusCountView]
AS
	SELECT TOP ( 100 ) PERCENT
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssueStatusId], 0) AS StatusId,
		[BugNet_IssuesView].[StatusName],
		[BugNet_IssuesView].[StatusImageUrl],
		ISNULL([dbo].[BNProjectStatus].[SortOrder], 99) AS SortOrder,
		COUNT(DISTINCT [BugNet_IssuesView].[IssueId]) AS Number
	FROM
		[dbo].[BugNet_IssuesView]
		LEFT OUTER JOIN [dbo].[BNProjectStatus] ON [BugNet_IssuesView].[IssueStatusId] = [dbo].[BNProjectStatus].[StatusId]
	GROUP BY
		[BugNet_IssuesView].[StatusName],
		[BugNet_IssuesView].[StatusImageUrl],
		ISNULL([dbo].[BNProjectStatus].[SortOrder], 99),
		[BugNet_IssuesView].[ProjectId],
		[BugNet_IssuesView].[Disabled],
		ISNULL([BugNet_IssuesView].[IssueStatusId], 0)
	HAVING
		( [BugNet_IssuesView].[Disabled] = 0 )
	ORDER BY
		[BugNet_IssuesView].[ProjectId];
GO
