SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_GetSavedQuery]
	@QueryId INT
AS
	SELECT
		BooleanOperator,
		FieldName,
		ComparisonOperator,
		FieldValue,
		DataType,
		CustomFieldId
	FROM
		[BNQueryClauses]
	WHERE
		QueryId = @QueryId;
GO
