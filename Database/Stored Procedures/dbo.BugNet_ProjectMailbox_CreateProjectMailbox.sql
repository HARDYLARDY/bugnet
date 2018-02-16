SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_CreateProjectMailbox]
	@MailBox NVARCHAR(100),
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

	INSERT
		[BNProjectMailBoxes]
		 (
			 MailBox,
			 ProjectId,
			 AssignToUserId,
			 IssueTypeId
		 )
	VALUES
		 (
			 @MailBox, @ProjectId, @AssignToUserId, @IssueTypeId
		 );

	RETURN SCOPE_IDENTITY();
GO
