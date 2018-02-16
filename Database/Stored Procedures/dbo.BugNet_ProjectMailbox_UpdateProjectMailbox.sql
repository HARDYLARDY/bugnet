SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_UpdateProjectMailbox]
	@ProjectMailboxId INT,
	@MailBoxEmailAddress NVARCHAR(100),
	@ProjectId INT,
	@AssignToUserName NVARCHAR(255),
	@IssueTypeId INT
AS
	DECLARE @AssignToUserId UNIQUEIDENTIFIER;

	SELECT
		@AssignToUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @AssignToUserName;

	UPDATE
		[BNProjectMailBoxes]
	SET
		MailBox = @MailBoxEmailAddress,
		ProjectId = @ProjectId,
		AssignToUserId = @AssignToUserId,
		IssueTypeId = @IssueTypeId
	WHERE
		ProjectMailboxId = @ProjectMailboxId;
GO
