SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_GetOpenIssues]
	@ProjectId INT
AS
	SELECT
		*
	FROM
		[dbo].[BugNet_IssuesView]
	WHERE
		[BugNet_IssuesView].[ProjectId] = @ProjectId
		AND [BugNet_IssuesView].[Disabled] = 0
		AND [BugNet_IssuesView].[IssueStatusId] IN (
													   SELECT StatusId FROM [BNProjectStatus] WHERE IsClosedState = 0 AND ProjectId = @ProjectId
												   )
	ORDER BY
		[BugNet_IssuesView].[IssueId] DESC;
GO
