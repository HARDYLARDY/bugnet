SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteRelatedIssue]
	@PrimaryIssueId INT,
	@SecondaryIssueId INT,
	@RelationType INT
AS
	DELETE
	[BNRelatedIssues]
	WHERE
		(
			(
				PrimaryIssueId = @PrimaryIssueId
				AND SecondaryIssueId = @SecondaryIssueId
			)
			OR (
				   PrimaryIssueId = @SecondaryIssueId
				   AND SecondaryIssueId = @PrimaryIssueId
			   )
		)
		AND RelationType = @RelationType;
GO
