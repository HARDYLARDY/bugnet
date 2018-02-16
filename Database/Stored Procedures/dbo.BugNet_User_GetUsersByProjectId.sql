SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_User_GetUsersByProjectId]
	@ProjectId INT,
	@ExcludeReadonlyUsers BIT
AS
	SELECT DISTINCT
		[U].[UserId],
		[U].[UserName],
		[BNUserProfiles].[FirstName],
		[BNUserProfiles].[LastName],
		[BNUserProfiles].[DisplayName]
	FROM
		[dbo].[Users] U
		JOIN [dbo].[BNUserProjects] ON [U].[UserId] = [BNUserProjects].[UserId]
		JOIN [dbo].[BNUserProfiles] ON [U].[UserName] = [BNUserProfiles].[UserName]
		JOIN [dbo].[Memberships] M ON [U].[UserId] = [M].[UserId]
		LEFT JOIN [dbo].[BNUserRoles] UR ON [U].[UserId] = [UR].[UserId]
		LEFT JOIN [BNRoles] R ON [UR].[RoleId] = R.RoleId
	WHERE
		[BNUserProjects].[ProjectId] = @ProjectId
		AND [M].[IsApproved] = 1
		AND (
				@ExcludeReadonlyUsers = 0
				OR @ExcludeReadonlyUsers = 1
				   AND R.RoleName != 'Read Only'
			)
	ORDER BY
		[BNUserProfiles].[DisplayName] ASC;
GO
