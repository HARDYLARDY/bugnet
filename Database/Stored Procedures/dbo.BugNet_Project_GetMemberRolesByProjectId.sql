SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetMemberRolesByProjectId]
	@ProjectId INT
AS
	SELECT
		ISNULL([UsersProfile].[DisplayName], [Users].[UserName]) AS DisplayName,
		[BNRoles].[RoleName]
	FROM
		[dbo].[Users]
		INNER JOIN [dbo].[BNUserProjects] ON [Users].[UserId] = [BNUserProjects].[UserId]
		INNER JOIN [dbo].[BNUserRoles] ON [Users].[UserId] = [BNUserRoles].[UserId]
		INNER JOIN [BNRoles] ON [BNUserRoles].[RoleId] = [BNRoles].[RoleId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS UsersProfile ON [Users].[UserName] = [UsersProfile].[UserName]
	WHERE
		[BNUserProjects].[ProjectId] = @ProjectId
	ORDER BY
		DisplayName,
		RoleName ASC;
GO
