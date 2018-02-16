SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_SetProjectSelectedColumnsWithUserIdAndProjectId]
	@UserName NVARCHAR(255),
	@ProjectId INT,
	@Columns NVARCHAR(255)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		UPDATE
			[BNUserProjects]
		SET
			[SelectedIssueColumns] = @Columns
		WHERE
			UserId = @UserId
			AND ProjectId = @ProjectId;
	END;
GO
