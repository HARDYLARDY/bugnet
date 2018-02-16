SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_GetIssueTypeById]
	@IssueTypeId INT
AS
	SELECT
		IssueTypeId,
		ProjectId,
		IssueTypeName,
		IssueTypeImageUrl,
		SortOrder
	FROM
		[BNProjectIssueTypes]
	WHERE
		IssueTypeId = @IssueTypeId;
GO
