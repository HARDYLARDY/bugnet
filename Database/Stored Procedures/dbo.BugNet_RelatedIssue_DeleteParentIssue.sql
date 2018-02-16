SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_DeleteParentIssue]
	@PrimaryIssueId INT,
	@SecondaryIssueId INT,
	@RelationType INT
AS
	DELETE
	[BNRelatedIssues]
	WHERE
		PrimaryIssueId = @SecondaryIssueId
		AND SecondaryIssueId = @PrimaryIssueId
		AND RelationType = @RelationType;
GO
