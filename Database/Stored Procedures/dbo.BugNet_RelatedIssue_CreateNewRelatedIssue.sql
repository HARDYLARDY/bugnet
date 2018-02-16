SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RelatedIssue_CreateNewRelatedIssue]
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
			 (
				 PrimaryIssueId = @PrimaryIssueId
				 OR PrimaryIssueId = @SecondaryIssueId
			 )
			 AND (
					 SecondaryIssueId = @SecondaryIssueId
					 OR SecondaryIssueId = @PrimaryIssueId
				 )
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
