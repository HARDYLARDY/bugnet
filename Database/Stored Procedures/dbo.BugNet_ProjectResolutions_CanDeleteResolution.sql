SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CanDeleteResolution]
	@ResolutionId INT
AS
	SET NOCOUNT ON;

	DECLARE
		@ProjectId INT,
		@Count INT;

	SET @ProjectId =
	  (
		  SELECT
			  [BNProjectResolutions].[ProjectId]
		  FROM
			  [dbo].[BNProjectResolutions]
		  WHERE
			  [BNProjectResolutions].[ResolutionId] = @ResolutionId
	  );
	SET @Count =
	  (
		  SELECT
			  COUNT(*)
		  FROM
			  [BNIssues]
		  WHERE
			  ( IssueResolutionId = @ResolutionId )
			  AND ProjectId = @ProjectId
	  );

	IF ( @Count = 0 )
		RETURN 1;
	ELSE
		RETURN 0;
GO
