SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueNotification_DeleteIssueNotification]
	@IssueId INT,
	@UserName NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	DELETE [BNIssueNotifications] WHERE IssueId = @IssueId AND UserId = @UserId;
GO
