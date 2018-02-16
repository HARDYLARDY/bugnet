SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypesByProjectId]
	@ProjectId INT
AS
	SELECT
		IssueTypeId,
		ProjectId,
		IssueTypeName,
		SortOrder,
		IssueTypeImageUrl
	FROM
		[BNProjectIssueTypes]
	WHERE
		ProjectId = @ProjectId
	ORDER BY
		SortOrder;
GO
