SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnscheduledMilestoneCountByProject]
	@ProjectId INT
AS
	SELECT
		COUNT(IssueId) AS 'Number'
	FROM
		[BNIssues]
	WHERE
		( IssueMilestoneId IS NULL )
		AND ( ProjectId = @ProjectId )
		AND Disabled = 0
		AND IssueStatusId IN (
								 SELECT
									 [BNProjectStatus].[StatusId]
								 FROM
									 [dbo].[BNProjectStatus]
								 WHERE
									 [BNProjectStatus].[IsClosedState] = 0
									 AND [BNProjectStatus].[ProjectId] = @ProjectId
							 );
GO
