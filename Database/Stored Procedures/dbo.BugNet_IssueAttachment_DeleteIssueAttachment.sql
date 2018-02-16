SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[BugNet_IssueAttachment_DeleteIssueAttachment]
 @IssueAttachmentId INT
AS
DELETE
FROM
	[BNIssueAttachments]
WHERE
	IssueAttachmentId = @IssueAttachmentId


GO
