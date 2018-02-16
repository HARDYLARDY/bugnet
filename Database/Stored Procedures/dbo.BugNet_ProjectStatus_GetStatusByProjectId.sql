SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusByProjectId]
	@ProjectId INT
AS
	SELECT
		StatusId,
		ProjectId,
		StatusName,
		SortOrder,
		StatusImageUrl,
		IsClosedState
	FROM
		[BNProjectStatus]
	WHERE
		ProjectId = @ProjectId
	ORDER BY
		SortOrder;
GO
