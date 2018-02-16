SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_IssuePriorityCountView]
AS
	SELECT TOP ( 100 ) PERCENT
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssuePriorityId], '0') AS PriorityId,
		[BugNet_IssuesView].[PriorityName],
		[BugNet_IssuesView].[PriorityImageUrl],
		ISNULL([dbo].[BNProjectPriorities].[SortOrder], 99) AS SortOrder,
		COUNT(DISTINCT [BugNet_IssuesView].[IssueId]) AS Number
	FROM
		[dbo].[BugNet_IssuesView]
		LEFT OUTER JOIN [dbo].[BNProjectPriorities] ON [BugNet_IssuesView].[IssuePriorityId] = [dbo].[BNProjectPriorities].[PriorityId]
	WHERE
		( [BugNet_IssuesView].[Disabled] = 0 )
		AND ( [BugNet_IssuesView].[IsClosed] = 0 )
	GROUP BY
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssuePriorityId], '0'),
		[BugNet_IssuesView].[PriorityName],
		[BugNet_IssuesView].[PriorityImageUrl],
		ISNULL([dbo].[BNProjectPriorities].[SortOrder], 99)
	ORDER BY
		[BugNet_IssuesView].[ProjectId];
GO
