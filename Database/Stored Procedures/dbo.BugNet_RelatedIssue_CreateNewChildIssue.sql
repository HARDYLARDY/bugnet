SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewChildIssue]
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
			 PrimaryIssueId = @PrimaryIssueId
			 AND SecondaryIssueId = @SecondaryIssueId
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
				 @PrimaryIssueId, @SecondaryIssueId, @RelationType
			 );
	END;
GO
