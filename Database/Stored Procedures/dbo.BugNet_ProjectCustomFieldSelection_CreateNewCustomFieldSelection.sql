SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_CreateNewCustomFieldSelection]
	@CustomFieldId INT,
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionName NVARCHAR(255)
AS
	DECLARE @CustomFieldSelectionSortOrder INT;

	SELECT
		@CustomFieldSelectionSortOrder = ISNULL(MAX(CustomFieldSelectionSortOrder), 0) + 1
	FROM
		[BNProjectCustomFieldSelections];

	IF NOT EXISTS
	 (
		 SELECT
			 CustomFieldSelectionId
		 FROM
			 [BNProjectCustomFieldSelections]
		 WHERE
			 CustomFieldId = @CustomFieldId
			 AND LOWER(CustomFieldSelectionName) = LOWER(@CustomFieldSelectionName)
	 )
	BEGIN
		INSERT
			[BNProjectCustomFieldSelections]
			 (
				 CustomFieldId,
				 CustomFieldSelectionValue,
				 CustomFieldSelectionName,
				 CustomFieldSelectionSortOrder
			 )
		VALUES
			 (
				 @CustomFieldId, @CustomFieldSelectionValue, @CustomFieldSelectionName, @CustomFieldSelectionSortOrder
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN 0;
GO
