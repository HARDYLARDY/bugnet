SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectNotification_GetProjectNotificationsByUsername]
	@UserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	SELECT
		ProjectNotificationId,
		[P].[ProjectId],
		[P].[ProjectName],
		[U].[UserId] NotificationUserId,
		[U].[UserName] NotificationUserName,
		ISNULL([BNUserProfiles].[DisplayName], '') NotificationDisplayName,
		[M].[Email] NotificationEmail
	FROM
		[BNProjectNotifications]
		INNER JOIN [dbo].[Users] U ON [BNProjectNotifications].[UserId] = [U].[UserId]
		INNER JOIN [dbo].[Memberships] M ON [BNProjectNotifications].[UserId] = [M].[UserId]
		INNER JOIN [dbo].[BNProjects] P ON [BNProjectNotifications].[ProjectId] = [P].[ProjectId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] ON [U].[UserName] = [BNUserProfiles].[UserName]
	WHERE
		[U].[UserId] = @UserId
	ORDER BY
		[BNUserProfiles].[DisplayName];
GO
