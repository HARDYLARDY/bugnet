SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldById]
	@CustomFieldId INT
AS
	SELECT
		Fields.ProjectId,
		Fields.CustomFieldId,
		Fields.CustomFieldName,
		Fields.CustomFieldDataType,
		Fields.CustomFieldRequired,
		'' CustomFieldValue,
		Fields.CustomFieldTypeId
	FROM
		[BNProjectCustomFields] Fields
	WHERE
		Fields.CustomFieldId = @CustomFieldId;
GO
