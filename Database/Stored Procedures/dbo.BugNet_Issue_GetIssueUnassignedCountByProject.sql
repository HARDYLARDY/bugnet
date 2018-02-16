SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUnassignedCountByProject]
	@ProjectId INT
AS
	SELECT
		COUNT(IssueId) AS 'Number'
	FROM
		[BNIssues]
	WHERE
		( IssueAssignedUserId IS NULL )
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
