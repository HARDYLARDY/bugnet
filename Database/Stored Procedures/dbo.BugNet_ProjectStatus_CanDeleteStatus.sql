SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CanDeleteStatus]
	@StatusId INT
AS
	SET NOCOUNT ON;

	DECLARE
		@ProjectId INT,
		@Count INT;

	SET @ProjectId =
	  (
		  SELECT
			  [BNProjectStatus].[ProjectId]
		  FROM
			  [dbo].[BNProjectStatus]
		  WHERE
			  [BNProjectStatus].[StatusId] = @StatusId
	  );
	SET @Count =
	  (
		  SELECT COUNT(*)FROM [BNIssues] WHERE ( IssueStatusId = @StatusId ) AND ProjectId = @ProjectId
	  );

	IF ( @Count = 0 )
		RETURN 1;
	ELSE
		RETURN 0;
GO
