SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_UserView]
AS
	SELECT
		[Users].[UserId],
		[dbo].[BNUserProfiles].[FirstName],
		[dbo].[BNUserProfiles].[LastName],
		[dbo].[BNUserProfiles].[DisplayName],
		[Users].[UserName],
		[Memberships].[Email],
		[Memberships].[IsApproved],
		[Memberships].[IsLockedOut],
		[Users].[IsAnonymous],
		[Users].[LastActivityDate],
		[dbo].[BNUserProfiles].[IssuesPageSize],
		[dbo].[BNUserProfiles].[PreferredLocale]
	FROM
		[dbo].[Users]
		INNER JOIN [dbo].[Memberships] ON [Users].[UserId] = [Memberships].[UserId]
		INNER JOIN [dbo].[BNUserProfiles] ON [Users].[UserName] = [dbo].[BNUserProfiles].[UserName]
	GROUP BY
		[Users].[UserId],
		[Users].[UserName],
		[Memberships].[Email],
		[Memberships].[IsApproved],
		[Memberships].[IsLockedOut],
		[Users].[IsAnonymous],
		[Users].[LastActivityDate],
		[dbo].[BNUserProfiles].[FirstName],
		[dbo].[BNUserProfiles].[LastName],
		[dbo].[BNUserProfiles].[DisplayName],
		[dbo].[BNUserProfiles].[IssuesPageSize],
		[dbo].[BNUserProfiles].[PreferredLocale];
GO
