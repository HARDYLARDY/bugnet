SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueNotification_CreateNewIssueNotification]
	@IssueId INT,
	@NotificationUserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT
		@UserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @NotificationUserName;

	IF (
		   NOT EXISTS
	 (
		 SELECT
			 IssueNotificationId
		 FROM
			 [BNIssueNotifications]
		 WHERE
			 UserId = @UserId
			 AND IssueId = @IssueId
	 )
		   AND @UserId IS NOT NULL
	   )
	BEGIN
		INSERT [BNIssueNotifications] ( IssueId, UserId ) VALUES ( @IssueId, @UserId );

		RETURN SCOPE_IDENTITY();
	END;
GO
