SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_GetQueryById]
	@QueryId INT
AS
	SELECT QueryId, QueryName, IsPublic FROM [BNQueries] WHERE QueryId = @QueryId ORDER BY QueryName;
GO
