SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_DeleteQuery]
	@QueryId INT
AS
	DELETE [BNQueries] WHERE QueryId = @QueryId;

	DELETE [dbo].[BNQueryClauses] WHERE [BNQueryClauses].[QueryId] = @QueryId;
GO
