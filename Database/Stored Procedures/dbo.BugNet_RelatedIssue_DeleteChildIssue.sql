SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteChildIssue]
	@PrimaryIssueId INT,
	@SecondaryIssueId INT,
	@RelationType INT
AS
	DELETE
	[BNRelatedIssues]
	WHERE
		PrimaryIssueId = @PrimaryIssueId
		AND SecondaryIssueId = @SecondaryIssueId
		AND RelationType = @RelationType;
GO
