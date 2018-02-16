SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_IssueMilestoneCountView]
AS
	SELECT
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssueMilestoneId], 0) AS MilestoneId,
		[BugNet_IssuesView].[MilestoneName],
		[BugNet_IssuesView].[MilestoneImageUrl],
		ISNULL([dbo].[BNProjectMilestones].[SortOrder], 99999) AS SortOrder,
		COUNT(DISTINCT [BugNet_IssuesView].[IssueId]) AS Number
	FROM
		[dbo].[BugNet_IssuesView]
		LEFT OUTER JOIN [dbo].[BNProjectMilestones] ON [BugNet_IssuesView].[IssueMilestoneId] = [dbo].[BNProjectMilestones].[MilestoneId]
	WHERE
		( [BugNet_IssuesView].[Disabled] = 0 )
		AND ( [BugNet_IssuesView].[IsClosed] = 0 )
	GROUP BY
		[BugNet_IssuesView].[ProjectId],
		ISNULL([BugNet_IssuesView].[IssueMilestoneId], 0),
		ISNULL([dbo].[BNProjectMilestones].[SortOrder], 99999),
		[BugNet_IssuesView].[MilestoneName],
		[BugNet_IssuesView].[MilestoneImageUrl];
GO
