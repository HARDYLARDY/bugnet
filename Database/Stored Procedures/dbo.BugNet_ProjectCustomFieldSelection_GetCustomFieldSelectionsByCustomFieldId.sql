SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomFieldSelection_GetCustomFieldSelectionsByCustomFieldId]
	@CustomFieldId INT
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
		CustomFieldId = @CustomFieldId
	ORDER BY
		CustomFieldSelectionSortOrder;
GO
