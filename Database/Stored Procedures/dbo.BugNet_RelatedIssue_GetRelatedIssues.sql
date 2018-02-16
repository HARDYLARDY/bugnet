SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_GetRelatedIssues]
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
		[BNIssues]
		LEFT JOIN [dbo].[BNProjectStatus] ON [BNIssues].[IssueStatusId] = [BNProjectStatus].[StatusId]
		LEFT JOIN [dbo].[BNProjectResolutions] ON [BNIssues].[IssueResolutionId] = [BNProjectResolutions].[ResolutionId]
	WHERE
		IssueId IN (
					   SELECT
						   [BNRelatedIssues].[PrimaryIssueId]
					   FROM
						   [dbo].[BNRelatedIssues]
					   WHERE
						   [BNRelatedIssues].[SecondaryIssueId] = @IssueId
						   AND [BNRelatedIssues].[RelationType] = @RelationType
				   )
		OR IssueId IN (
						  SELECT
							  [BNRelatedIssues].[SecondaryIssueId]
						  FROM
							  [dbo].[BNRelatedIssues]
						  WHERE
							  [BNRelatedIssues].[PrimaryIssueId] = @IssueId
							  AND [BNRelatedIssues].[RelationType] = @RelationType
					  )
	ORDER BY
		IssueId;
GO
