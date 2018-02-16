SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_GetPriorityById]
	@PriorityId INT
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
		PriorityId = @PriorityId;
GO
