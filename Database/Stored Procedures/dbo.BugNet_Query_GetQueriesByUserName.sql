SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_GetQueriesByUserName]
	@UserName NVARCHAR(255),
	@ProjectId INT
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	SELECT
		QueryId,
		QueryName + ' (' + [BNUserProfiles].[DisplayName] + ')' AS QueryName,
		IsPublic
	FROM
		[BNQueries]
		INNER JOIN [dbo].[Users] M ON [BNQueries].[UserId] = [M].[UserId]
		JOIN [dbo].[BNUserProfiles] ON [M].[UserName] = [BNUserProfiles].[UserName]
	WHERE
		IsPublic = 1
		AND ProjectId = @ProjectId
	UNION
	SELECT
		QueryId,
		QueryName,
		IsPublic
	FROM
		[BNQueries]
	WHERE
		UserId = @UserId
		AND ProjectId = @ProjectId
		AND IsPublic = 0
	ORDER BY
		QueryName;
GO
