SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_UpdateQuery]
	@QueryId INT,
	@UserName NVARCHAR(255),
	@ProjectId INT,
	@QueryName NVARCHAR(50),
	@IsPublic BIT
AS
	-- Get UserID
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	UPDATE
		[BNQueries]
	SET
		UserId = @UserId,
		ProjectId = @ProjectId,
		QueryName = @QueryName,
		IsPublic = @IsPublic
	WHERE
		QueryId = @QueryId;

	DELETE FROM [dbo].[BNQueryClauses] WHERE [BNQueryClauses].[QueryId] = @QueryId;
GO
