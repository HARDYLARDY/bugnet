SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_GetMilestoneById]
	@MilestoneId INT
AS
	SELECT
		MilestoneId,
		ProjectId,
		MilestoneName,
		MilestoneImageUrl,
		SortOrder,
		MilestoneDueDate,
		MilestoneReleaseDate,
		MilestoneNotes,
		MilestoneCompleted
	FROM
		[BNProjectMilestones]
	WHERE
		MilestoneId = @MilestoneId;
GO
