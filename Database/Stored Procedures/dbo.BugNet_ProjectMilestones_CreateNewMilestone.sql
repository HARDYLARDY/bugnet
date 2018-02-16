SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMilestones_CreateNewMilestone]
	@ProjectId INT,
	@MilestoneName NVARCHAR(50),
	@MilestoneImageUrl NVARCHAR(255),
	@MilestoneDueDate DATETIME,
	@MilestoneReleaseDate DATETIME,
	@MilestoneNotes NVARCHAR(MAX),
	@MilestoneCompleted BIT
AS
	IF NOT EXISTS
	 (
		 SELECT
			 MilestoneId
		 FROM
			 [BNProjectMilestones]
		 WHERE
			 LOWER(MilestoneName) = LOWER(@MilestoneName)
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		DECLARE @SortOrder INT;

		SELECT
			@SortOrder = ISNULL(MAX(SortOrder + 1), 1)
		FROM
			[BNProjectMilestones]
		WHERE
			ProjectId = @ProjectId;

		INSERT
			[BNProjectMilestones]
			 (
				 ProjectId,
				 MilestoneName,
				 MilestoneImageUrl,
				 SortOrder,
				 MilestoneDueDate,
				 MilestoneReleaseDate,
				 MilestoneNotes,
				 MilestoneCompleted
			 )
		VALUES
			 (
				 @ProjectId, @MilestoneName, @MilestoneImageUrl, @SortOrder, @MilestoneDueDate, @MilestoneReleaseDate, @MilestoneNotes, @MilestoneCompleted
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN -1;
GO
