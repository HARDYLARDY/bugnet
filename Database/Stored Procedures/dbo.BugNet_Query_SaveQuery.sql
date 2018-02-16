SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_SaveQuery]
	@UserName NVARCHAR(255),
	@ProjectId INT,
	@QueryName NVARCHAR(50),
	@IsPublic BIT
AS
	-- Get UserID
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	IF EXISTS
	 (
		 SELECT
			 QueryName
		 FROM
			 [BNQueries]
		 WHERE
			 QueryName = @QueryName
			 AND UserId = @UserId
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		RETURN 0;
	END;

	INSERT
		[BNQueries]
		 (
			 UserId,
			 ProjectId,
			 QueryName,
			 IsPublic
		 )
	VALUES
		 (
			 @UserId, @ProjectId, @QueryName, @IsPublic
		 );

	RETURN SCOPE_IDENTITY();
GO
