SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_UpdatePriority]
	@ProjectId INT,
	@PriorityId INT,
	@PriorityName NVARCHAR(50),
	@PriorityImageUrl NVARCHAR(50),
	@SortOrder INT
AS
	DECLARE @OldSortOrder INT;
	DECLARE @OldPriorityId INT;

	SELECT @OldSortOrder = SortOrder FROM [BNProjectPriorities] WHERE PriorityId = @PriorityId;

	SELECT
		@OldPriorityId = PriorityId
	FROM
		[BNProjectPriorities]
	WHERE
		SortOrder = @SortOrder
		AND ProjectId = @ProjectId;

	UPDATE
		[BNProjectPriorities]
	SET
		ProjectId = @ProjectId,
		PriorityName = @PriorityName,
		PriorityImageUrl = @PriorityImageUrl,
		SortOrder = @SortOrder
	WHERE
		PriorityId = @PriorityId;

	UPDATE [BNProjectPriorities] SET SortOrder = @OldSortOrder WHERE PriorityId = @OldPriorityId;
GO
