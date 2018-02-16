SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_UpdateMilestone]
	@ProjectId INT,
	@MilestoneId INT,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@SortOrder INT,
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME,
	@MilestoneNotes NVARCHAR(MAX),
	@MilestoneCompleted BIT
AS
	DECLARE @OldSortOrder INT;
	DECLARE @OldMilestoneId INT;

	SELECT @OldSortOrder = SortOrder FROM [BNProjectMilestones] WHERE MilestoneId = @MilestoneId;

	SELECT
		@OldMilestoneId = MilestoneId
	FROM
		[BNProjectMilestones]
	WHERE
		SortOrder = @SortOrder
		AND ProjectId = @ProjectId;

	UPDATE
		[BNProjectMilestones]
	SET
		ProjectId = @ProjectId,
		MilestoneName = @MilestoneName,
		MilestoneImageUrl = @MilestoneImageUrl,
		SortOrder = @SortOrder,
		MilestoneDueDate = @MilestoneDueDate,
		MilestoneReleaseDate = @MilestoneReleaseDate,
		MilestoneNotes = @MilestoneNotes,
		MilestoneCompleted = @MilestoneCompleted
	WHERE
		MilestoneId = @MilestoneId;

	UPDATE [BNProjectMilestones] SET SortOrder = @OldSortOrder WHERE MilestoneId = @OldMilestoneId;
GO
