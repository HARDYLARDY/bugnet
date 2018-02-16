SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPrioritiesByProjectId]
	@ProjectId INT
AS
	SELECT
		PriorityId,
		ProjectId,
		PriorityName,
		SortOrder,
		PriorityImageUrl
	FROM
		[BNProjectPriorities]
	WHERE
		ProjectId = @ProjectId
	ORDER BY
		SortOrder;
GO
