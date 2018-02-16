SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Query_SaveQueryClause]
	@QueryId INT,
	@BooleanOperator NVARCHAR(50),
	@FieldName NVARCHAR(50),
	@ComparisonOperator NVARCHAR(50),
	@FieldValue NVARCHAR(50),
	@DataType INT,
	@CustomFieldId INT = NULL
AS
	INSERT
		[BNQueryClauses]
		 (
			 QueryId,
			 BooleanOperator,
			 FieldName,
			 ComparisonOperator,
			 FieldValue,
			 DataType,
			 CustomFieldId
		 )
	VALUES
		 (
			 @QueryId, @BooleanOperator, @FieldName, @ComparisonOperator, @FieldValue, @DataType, @CustomFieldId
		 );
GO
