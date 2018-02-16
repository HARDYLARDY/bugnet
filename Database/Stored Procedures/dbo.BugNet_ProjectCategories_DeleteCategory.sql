SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCategories_DeleteCategory]
	@CategoryId INT
AS
	UPDATE [BNProjectCategories] SET [Disabled] = 1 WHERE CategoryId = @CategoryId;
GO
