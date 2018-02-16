SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueNotification_GetIssueNotificationsByIssueId]
	@IssueId INT
AS
	SET NOCOUNT ON;

	DECLARE @DefaultCulture NVARCHAR(50);

	SET @DefaultCulture =
	  (
		  SELECT
			  ISNULL(SettingValue, 'en-US')
		  FROM
			  [BNHostSettings]
		  WHERE
			  SettingName = 'ApplicationDefaultLanguage'
	  );

	DECLARE @tmpTable TABLE
	(
		IssueNotificationId INT,
		IssueId INT,
		NotificationUserId UNIQUEIDENTIFIER,
		NotificationUserName NVARCHAR(50),
		NotificationDisplayName NVARCHAR(50),
		NotificationEmail NVARCHAR(50),
		NotificationCulture NVARCHAR(50)
	);

	INSERT
		@tmpTable
	SELECT
		IssueNotificationId,
		IssueId,
		[U].[UserId] NotificationUserId,
		[U].[UserName] NotificationUserName,
		ISNULL([UP].[DisplayName], '') NotificationDisplayName,
		[M].[Email] NotificationEmail,
		ISNULL([UP].[PreferredLocale], @DefaultCulture) AS NotificationCulture
	FROM
		[BNIssueNotifications]
		INNER JOIN [dbo].[Users] U ON [BNIssueNotifications].[UserId] = [U].[UserId]
		INNER JOIN [dbo].[Memberships] M ON [BNIssueNotifications].[UserId] = [M].[UserId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] UP ON [U].[UserName] = [UP].[UserName]
	WHERE
		IssueId = @IssueId
	ORDER BY
		[UP].[DisplayName];

	-- get all people on the project who want to be notified
	INSERT
		@tmpTable
	SELECT
		[p].[ProjectNotificationid],
		IssueId = @IssueId,
		[u].[UserId] NotificationUserId,
		[u].[UserName] NotificationUserName,
		ISNULL([up].[DisplayName], '') NotificationDisplayName,
		[m].[Email] NotificationEmail,
		ISNULL([up].[PreferredLocale], @DefaultCulture) AS NotificationCulture
	FROM
		[dbo].[BNProjectNotifications] p,
		[dbo].[BNIssues] i,
		[dbo].[Users] u,
		[dbo].[Memberships] m,
		[dbo].[BNUserProfiles] up
	WHERE
		IssueId = @IssueId
		AND [p].[ProjectId] = [i].[ProjectId]
		AND [u].[UserId] = [p].[UserId]
		AND [u].[UserId] = [m].[UserId]
		AND [u].[UserName] = [up].[UserName];

	SELECT DISTINCT
		[@tmpTable].[IssueId],
		[@tmpTable].[NotificationUserId],
		[@tmpTable].[NotificationUserName],
		[@tmpTable].[NotificationDisplayName],
		[@tmpTable].[NotificationEmail],
		[@tmpTable].[NotificationCulture]
	FROM
		@tmpTable
	ORDER BY
		[@tmpTable].[NotificationDisplayName];
GO
