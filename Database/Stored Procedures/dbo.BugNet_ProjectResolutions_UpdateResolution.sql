SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_UpdateResolution]
	@ProjectId INT,
	@ResolutionId INT,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50),
	@SortOrder INT
AS
	DECLARE @OldSortOrder INT;
	DECLARE @OldResolutionId INT;

	SELECT @OldSortOrder = SortOrder FROM [BNProjectResolutions] WHERE ResolutionId = @ResolutionId;

	SELECT
		@OldResolutionId = ResolutionId
	FROM
		[BNProjectResolutions]
	WHERE
		SortOrder = @SortOrder
		AND ProjectId = @ProjectId;

	UPDATE
		[BNProjectResolutions]
	SET
		ProjectId = @ProjectId,
		ResolutionName = @ResolutionName,
		ResolutionImageUrl = @ResolutionImageUrl,
		SortOrder = @SortOrder
	WHERE
		ResolutionId = @ResolutionId;

	UPDATE [BNProjectResolutions] SET SortOrder = @OldSortOrder WHERE ResolutionId = @OldResolutionId;
GO
