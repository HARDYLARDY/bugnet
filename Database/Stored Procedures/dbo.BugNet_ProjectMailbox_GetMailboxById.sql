SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxById]
	@ProjectMailboxId INT
AS
	SET NOCOUNT ON;

	SELECT
		[BNProjectMailBoxes].[*],
		[u].[UserName] AssignToUserName,
		[p].[DisplayName] AssignToDisplayName,
		[BNProjectIssueTypes].[IssueTypeName]
	FROM
		[dbo].[BNProjectMailBoxes]
		INNER JOIN [dbo].[Users] u ON [u].[UserId] = [BNProjectMailBoxes].[AssignToUserId]
		INNER JOIN [dbo].[BNUserProfiles] p ON [u].[UserName] = [p].[UserName]
		INNER JOIN [BNProjectIssueTypes] ON [BNProjectIssueTypes].[IssueTypeId] = [BNProjectMailBoxes].[IssueTypeId]
	WHERE
		[BNProjectMailBoxes].[ProjectMailboxId] = @ProjectMailboxId;
GO
