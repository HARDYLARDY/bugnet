SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewParentIssue]
	@PrimaryIssueId INT,
	@SecondaryIssueId INT,
	@RelationType INT
AS
	IF NOT EXISTS
	 (
		 SELECT
			 PrimaryIssueId
		 FROM
			 [BNRelatedIssues]
		 WHERE
			 PrimaryIssueId = @SecondaryIssueId
			 AND SecondaryIssueId = @PrimaryIssueId
			 AND RelationType = @RelationType
	 )
	BEGIN
		INSERT
			[BNRelatedIssues]
			 (
				 PrimaryIssueId,
				 SecondaryIssueId,
				 RelationType
			 )
		VALUES
			 (
				 @SecondaryIssueId, @PrimaryIssueId, @RelationType
			 );
	END;
GO
