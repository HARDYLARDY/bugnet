SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestonesByProjectId]
	@ProjectId INT,
	@MilestoneCompleted BIT
AS
	SELECT
		*
	FROM
		[BNProjectMilestones]
	WHERE
		ProjectId = @ProjectId
		AND MilestoneCompleted = ( CASE
									   WHEN @MilestoneCompleted = 1 THEN
											MilestoneCompleted
									   ELSE @MilestoneCompleted
									   END
								 )
	ORDER BY
		SortOrder ASC;
GO
