SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_CreateNewResolution]
	@ProjectId INT,
	@ResolutionName NVARCHAR(50),
	@ResolutionImageUrl NVARCHAR(50)
AS
	IF NOT EXISTS
	 (
		 SELECT
			 ResolutionId
		 FROM
			 [BNProjectResolutions]
		 WHERE
			 LOWER(ResolutionName) = LOWER(@ResolutionName)
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		DECLARE @SortOrder INT;

		SELECT
			@SortOrder = ISNULL(MAX(SortOrder + 1), 1)
		FROM
			[BNProjectResolutions]
		WHERE
			ProjectId = @ProjectId;

		INSERT
			[BNProjectResolutions]
			 (
				 ProjectId,
				 ResolutionName,
				 ResolutionImageUrl,
				 SortOrder
			 )
		VALUES
			 (
				 @ProjectId, @ResolutionName, @ResolutionImageUrl, @SortOrder
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN -1;
GO
