SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CanDeleteIssueType]
	@IssueTypeId INT
AS
	SET NOCOUNT ON;

	DECLARE
		@ProjectId INT,
		@Count INT;

	SET @ProjectId =
	  (
		  SELECT
			  [BNProjectIssueTypes].[ProjectId]
		  FROM
			  [dbo].[BNProjectIssueTypes]
		  WHERE
			  [BNProjectIssueTypes].[IssueTypeId] = @IssueTypeId
	  );
	SET @Count =
	  (
		  SELECT COUNT(*)FROM [BNIssues] WHERE ( IssueTypeId = @IssueTypeId ) AND ProjectId = @ProjectId
	  );

	IF ( @Count = 0 )
		RETURN 1;
	ELSE
		RETURN 0;
GO
