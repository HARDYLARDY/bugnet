SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionById]
	@CustomFieldSelectionId INT
AS
	SELECT
		CustomFieldSelectionId,
		CustomFieldId,
		CustomFieldSelectionName,
		RTRIM(CustomFieldSelectionValue) CustomFieldSelectionValue,
		CustomFieldSelectionSortOrder
	FROM
		[BNProjectCustomFieldSelections]
	WHERE
		CustomFieldSelectionId = @CustomFieldSelectionId
	ORDER BY
		CustomFieldSelectionSortOrder;
GO
