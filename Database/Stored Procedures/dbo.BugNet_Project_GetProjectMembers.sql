SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectMembers]
	@ProjectId INT
AS
	SELECT
		[Users].[UserName]
	FROM
		[dbo].[Users]
		LEFT OUTER JOIN [BNUserProjects] ON [Users].[UserId] = [BNUserProjects].[UserId]
	WHERE
		[BNUserProjects].[ProjectId] = @ProjectId
	ORDER BY
		[Users].[UserName] ASC;
GO
