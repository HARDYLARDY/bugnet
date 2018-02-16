SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_DeleteCustomField]
	@CustomFieldIdToDelete INT
AS
	SET XACT_ABORT ON;

	BEGIN TRAN;

	DELETE FROM [dbo].[BNQueryClauses] WHERE [BNQueryClauses].[CustomFieldId] = @CustomFieldIdToDelete;

	DELETE FROM
	[dbo].[BNProjectCustomFieldValues]
	WHERE
		[BNProjectCustomFieldValues].[CustomFieldId] = @CustomFieldIdToDelete;

	DELETE FROM [BNProjectCustomFields] WHERE CustomFieldId = @CustomFieldIdToDelete;

	COMMIT;
GO
