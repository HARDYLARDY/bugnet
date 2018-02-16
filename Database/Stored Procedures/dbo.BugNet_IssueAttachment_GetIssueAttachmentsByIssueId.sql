SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_GetIssueAttachmentsByIssueId]
	@IssueId INT
AS
	SELECT
		IssueAttachmentId,
		IssueId,
		FileSize,
		Description,
		Attachment,
		ContentType,
		[U].[UserName] CreatorUserName,
		ISNULL(DisplayName, '') CreatorDisplayName,
		FileName,
		DateCreated
	FROM
		[BNIssueAttachments]
		INNER JOIN [dbo].[Users] U ON [BNIssueAttachments].[UserId] = [U].[UserId]
		LEFT OUTER JOIN [BNUserProfiles] ON [U].[UserName] = [BNUserProfiles].[UserName]
	WHERE
		IssueId = @IssueId
	ORDER BY
		DateCreated DESC;
GO
