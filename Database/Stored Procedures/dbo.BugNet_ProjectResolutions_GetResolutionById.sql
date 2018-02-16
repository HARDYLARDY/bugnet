SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionById]
	@ResolutionId INT
AS
	SELECT
		ResolutionId,
		ProjectId,
		ResolutionName,
		SortOrder,
		ResolutionImageUrl
	FROM
		[BNProjectResolutions]
	WHERE
		ResolutionId = @ResolutionId;
GO
