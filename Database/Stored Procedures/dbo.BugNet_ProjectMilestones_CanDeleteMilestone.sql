SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CanDeleteMilestone]
	@MilestoneId INT
AS
	SET NOCOUNT ON;

	DECLARE
		@ProjectId INT,
		@Count INT;

	SET @ProjectId =
	  (
		  SELECT
			  [BNProjectMilestones].[ProjectId]
		  FROM
			  [dbo].[BNProjectMilestones]
		  WHERE
			  [BNProjectMilestones].[MilestoneId] = @MilestoneId
	  );
	SET @Count =
	  (
		  SELECT
			  COUNT(*)
		  FROM
			  [BNIssues]
		  WHERE
			  (
				  ( IssueMilestoneId = @MilestoneId )
				  OR ( IssueAffectedMilestoneId = @MilestoneId )
			  )
			  AND ProjectId = @ProjectId
	  );

	IF ( @Count = 0 )
		RETURN 1;
	ELSE
		RETURN 0;
GO
