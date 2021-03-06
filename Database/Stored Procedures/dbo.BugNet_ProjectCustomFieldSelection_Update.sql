SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_Update]
	@CustomFieldSelectionId INT,
	@CustomFieldId INT,
	@CustomFieldSelectionName NVARCHAR(255),
	@CustomFieldSelectionValue NVARCHAR(255),
	@CustomFieldSelectionSortOrder INT
AS
	SET XACT_ABORT ON;

	SET NOCOUNT ON;

	DECLARE
		@OldSortOrder INT,
		@OldCustomFieldSelectionId INT,
		@OldSelectionValue NVARCHAR(255);

	SELECT TOP 1
		@OldSortOrder = CustomFieldSelectionSortOrder,
		@OldSelectionValue = CustomFieldSelectionValue
	FROM
		[BNProjectCustomFieldSelections]
	WHERE
		CustomFieldSelectionId = @CustomFieldSelectionId;

	SET @OldCustomFieldSelectionId =
	  (
		  SELECT TOP 1
			  CustomFieldSelectionId
		  FROM
			  [BNProjectCustomFieldSelections]
		  WHERE
			  CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
			  AND CustomFieldId = @CustomFieldId
	  );

	UPDATE
		[BNProjectCustomFieldSelections]
	SET
		CustomFieldId = @CustomFieldId,
		CustomFieldSelectionName = @CustomFieldSelectionName,
		CustomFieldSelectionValue = @CustomFieldSelectionValue,
		CustomFieldSelectionSortOrder = @CustomFieldSelectionSortOrder
	WHERE
		CustomFieldSelectionId = @CustomFieldSelectionId;

	UPDATE
		[BNProjectCustomFieldSelections]
	SET
		CustomFieldSelectionSortOrder = @OldSortOrder
	WHERE
		CustomFieldSelectionId = @OldCustomFieldSelectionId;

	/* 
	this will not work very well with regards to case sensitivity so
	we only will care if the value is somehow different than the original
*/
	IF ( @OldSelectionValue != @CustomFieldSelectionValue )
	BEGIN
		UPDATE
			[dbo].[BNProjectCustomFieldValues]
		SET
			[BNProjectCustomFieldValues].[CustomFieldValue] = @CustomFieldSelectionValue
		WHERE
			[BNProjectCustomFieldValues].[CustomFieldId] = @CustomFieldId
			AND [BNProjectCustomFieldValues].[CustomFieldValue] = @OldSelectionValue;
	END;
GO
