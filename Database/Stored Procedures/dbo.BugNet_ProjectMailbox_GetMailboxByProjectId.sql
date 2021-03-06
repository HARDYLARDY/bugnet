SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
(
	@ProjectId INT
)
AS
	SET NOCOUNT ON;

	SELECT
		[BPMB].[ProjectMailboxId],
		[BPMB].[MailBox],
		[BPMB].[ProjectId],
		[BPMB].[AssignToUserId],
		[BPMB].[IssueTypeId],
		[U].[UserName] AssignToUserName,
		[P].[DisplayName] AssignToDisplayName,
		[PIT].[IssueTypeName]
	FROM
		[dbo].[BNProjectMailBoxes] AS [BPMB]
		INNER JOIN [dbo].[Users] [U] ON [U].[UserId] = [BPMB].[AssignToUserId]
		INNER JOIN [dbo].[BNUserProfiles] [P] ON [U].[UserName] = [P].[UserName]
		INNER JOIN [dbo].[BNProjectIssueTypes] AS [PIT] ON [PIT].[IssueTypeId] = [BPMB].[IssueTypeId]
	WHERE
		[BPMB].[ProjectId] = @ProjectId;
GO
