SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_UpdateLastUpdated]
	@IssueId INT,
	@LastUpdateUserName NVARCHAR(255)
AS
	SET NOCOUNT ON;

	DECLARE @LastUpdateUserId UNIQUEIDENTIFIER;

	SELECT
		@LastUpdateUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @LastUpdateUserName;

	BEGIN TRAN;

	UPDATE
		[BNIssues]
	SET
		LastUpdateUserId = @LastUpdateUserId,
		LastUpdate = GETDATE()
	WHERE
		IssueId = @IssueId;

	COMMIT TRAN;
GO
