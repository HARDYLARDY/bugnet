SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_GetMailboxByProjectId]
	@ProjectId INT
AS
	SET NOCOUNT ON;

	SELECT
		[BNProjectMailBoxes].[*],
		[u].[UserName] AssignToUserName,
		[p].[DisplayName] AssignToDisplayName,
		pit.IssueTypeName
	FROM
		[dbo].[BNProjectMailBoxes]
		INNER JOIN [dbo].[Users] u ON [u].[UserId] = [BNProjectMailBoxes].[AssignToUserId]
		INNER JOIN [dbo].[BNUserProfiles] p ON [u].[UserName] = [p].[UserName]
		INNER JOIN [BNProjectIssueTypes] pit ON pit.IssueTypeId = [BNProjectMailBoxes].[IssueTypeId]
	WHERE
		[BNProjectMailBoxes].[ProjectId] = @ProjectId;
GO
