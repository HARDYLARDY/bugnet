SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_DeleteMilestone]
	@MilestoneIdToDelete INT
AS
	DELETE [BNProjectMilestones] WHERE MilestoneId = @MilestoneIdToDelete;

	IF @@RowCount > 0
		RETURN 0;
	ELSE
		RETURN 1;
GO
