SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByProjectId]
	@ProjectId INT
AS
	SELECT
		ProjectId,
		CustomFieldId,
		CustomFieldName,
		CustomFieldDataType,
		CustomFieldRequired,
		'' CustomFieldValue,
		CustomFieldTypeId
	FROM
		[BNProjectCustomFields]
	WHERE
		ProjectId = @ProjectId;
GO
