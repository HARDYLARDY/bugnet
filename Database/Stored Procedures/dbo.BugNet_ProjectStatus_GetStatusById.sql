SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_GetStatusById]
	@StatusId INT
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
		StatusId = @StatusId;
GO
