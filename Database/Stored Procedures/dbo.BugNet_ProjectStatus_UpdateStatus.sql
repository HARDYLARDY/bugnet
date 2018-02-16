SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_UpdateStatus]
	@ProjectId INT,
	@StatusId INT,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@SortOrder INT,
	@IsClosedState BIT
AS
	DECLARE @OldSortOrder INT;
	DECLARE @OldStatusId INT;

	SELECT @OldSortOrder = SortOrder FROM [BNProjectStatus] WHERE StatusId = @StatusId;

	SELECT
		@OldStatusId = StatusId
	FROM
		[BNProjectStatus]
	WHERE
		SortOrder = @SortOrder
		AND ProjectId = @ProjectId;

	UPDATE
		[BNProjectStatus]
	SET
		ProjectId = @ProjectId,
		StatusName = @StatusName,
		StatusImageUrl = @StatusImageUrl,
		SortOrder = @SortOrder,
		IsClosedState = @IsClosedState
	WHERE
		StatusId = @StatusId;

	UPDATE [BNProjectStatus] SET SortOrder = @OldSortOrder WHERE StatusId = @OldStatusId;
GO
