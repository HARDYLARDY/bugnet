SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetRoadMapProgress]
	@ProjectId INT,
	@MilestoneId INT
AS
	SELECT
		(
			SELECT
				COUNT(*)
			FROM
				[dbo].[BugNet_IssuesView]
			WHERE
				[BugNet_IssuesView].[ProjectId] = @ProjectId
				AND [BugNet_IssuesView].[Disabled] = 0
				AND [BugNet_IssuesView].[IssueMilestoneId] = @MilestoneId
				AND [BugNet_IssuesView].[IssueStatusId] IN (
															   SELECT StatusId FROM [BNProjectStatus] WHERE IsClosedState = 1 AND ProjectId = @ProjectId
														   )
		) AS ClosedCount,
		(
			SELECT
				COUNT(*)
			FROM
				[dbo].[BugNet_IssuesView]
			WHERE
				[BugNet_IssuesView].[Disabled] = 0
				AND [BugNet_IssuesView].[ProjectId] = @ProjectId
				AND [BugNet_IssuesView].[IssueMilestoneId] = @MilestoneId
		) AS TotalCount;
GO
