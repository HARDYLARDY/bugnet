SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetParentIssues]
	@IssueId INT,
	@RelationType INT
AS
	SELECT
		IssueId,
		IssueTitle,
		[BNProjectStatus].[StatusName] AS IssueStatus,
		[BNProjectResolutions].[ResolutionName] AS IssueResolution,
		DateCreated
	FROM
		[dbo].[BNRelatedIssues]
		INNER JOIN [BNIssues] ON [BNRelatedIssues].[PrimaryIssueId] = IssueId
		LEFT JOIN [dbo].[BNProjectStatus] ON [BNIssues].[IssueStatusId] = [BNProjectStatus].[StatusId]
		LEFT JOIN [dbo].[BNProjectResolutions] ON [BNIssues].[IssueResolutionId] = [BNProjectResolutions].[ResolutionId]
	WHERE
		[BNRelatedIssues].[SecondaryIssueId] = @IssueId
		AND [BNRelatedIssues].[RelationType] = @RelationType
	ORDER BY
		[BNRelatedIssues].[PrimaryIssueId];
GO
