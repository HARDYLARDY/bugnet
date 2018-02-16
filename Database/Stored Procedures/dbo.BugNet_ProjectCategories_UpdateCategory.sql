SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_UpdateCategory]
	@CategoryId INT,
	@ProjectId INT,
	@CategoryName NVARCHAR(100),
	@ParentCategoryId INT
AS
	UPDATE
		[BNProjectCategories]
	SET
		ProjectId = @ProjectId,
		CategoryName = @CategoryName,
		ParentCategoryId = @ParentCategoryId
	WHERE
		CategoryId = @CategoryId;
GO
