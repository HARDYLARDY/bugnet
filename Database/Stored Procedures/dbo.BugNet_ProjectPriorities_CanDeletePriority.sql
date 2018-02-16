SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CanDeletePriority]
	@PriorityId INT
AS
	SET NOCOUNT ON;

	DECLARE
		@ProjectId INT,
		@Count INT;

	SET @ProjectId =
	  (
		  SELECT
			  [BNProjectPriorities].[ProjectId]
		  FROM
			  [dbo].[BNProjectPriorities]
		  WHERE
			  [BNProjectPriorities].[PriorityId] = @PriorityId
	  );
	SET @Count =
	  (
		  SELECT COUNT(*)FROM [BNIssues] WHERE ( IssuePriorityId = @PriorityId ) AND ProjectId = @ProjectId
	  );

	IF ( @Count = 0 )
		RETURN 1;
	ELSE
		RETURN 0;
GO
