SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_DeleteCustomFieldSelection]
	@CustomFieldSelectionIdToDelete INT
AS
	SET XACT_ABORT ON;

	DECLARE @CustomFieldId INT;

	SET @CustomFieldId =
	  (
		  SELECT TOP 1
			  CustomFieldId
		  FROM
			  [BNProjectCustomFieldSelections]
		  WHERE
			  CustomFieldSelectionId = @CustomFieldSelectionIdToDelete
	  );

	BEGIN TRAN;

	UPDATE
		[dbo].[BNProjectCustomFieldValues]
	SET
		[BNProjectCustomFieldValues].[CustomFieldValue] = NULL
	WHERE
		[BNProjectCustomFieldValues].[CustomFieldId] = @CustomFieldId;

	DELETE FROM
	[BNProjectCustomFieldSelections]
	WHERE
		CustomFieldSelectionId = @CustomFieldSelectionIdToDelete;

	COMMIT TRAN;
GO
