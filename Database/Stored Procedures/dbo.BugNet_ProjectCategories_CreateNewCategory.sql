SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_CreateNewCategory]
	@ProjectId INT,
	@CategoryName NVARCHAR(100),
	@ParentCategoryId INT
AS
	INSERT
		[BNProjectCategories]
		 (
			 ProjectId,
			 CategoryName,
			 ParentCategoryId
		 )
	VALUES
		 (
			 @ProjectId, @CategoryName, @ParentCategoryId
		 );

	RETURN SCOPE_IDENTITY();
GO
