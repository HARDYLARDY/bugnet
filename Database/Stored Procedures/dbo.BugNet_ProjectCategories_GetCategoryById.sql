SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_GetCategoryById]
	@CategoryId INT
AS
	SELECT
		CategoryId,
		ProjectId,
		CategoryName,
		ParentCategoryId,
		(
			SELECT COUNT(*)FROM [BNProjectCategories] WHERE ParentCategoryId = c.CategoryId
		) ChildCount,
		(
			SELECT
				COUNT(*)
			FROM
				[dbo].[BugNet_IssuesView]
			WHERE
				[BugNet_IssuesView].[IssueCategoryId] = c.CategoryId
				AND [BugNet_IssuesView].[Disabled] = 0
				AND [BugNet_IssuesView].[IsClosed] = 0
		) AS IssueCount,
		[Disabled]
	FROM
		[BNProjectCategories] c
	WHERE
		CategoryId = @CategoryId;
GO
