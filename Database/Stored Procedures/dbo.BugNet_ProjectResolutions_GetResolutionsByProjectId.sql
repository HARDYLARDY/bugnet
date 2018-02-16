SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_GetResolutionsByProjectId]
	@ProjectId INT
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
		ProjectId = @ProjectId
	ORDER BY
		SortOrder;
GO
