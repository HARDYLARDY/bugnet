SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_GetCustomFieldsByIssueId]
	@IssueId INT
AS
	DECLARE @ProjectId INT;

	SELECT @ProjectId = ProjectId FROM [BNIssues] WHERE IssueId = @IssueId;

	SELECT
		[Fields].[ProjectId],
		[Fields].[CustomFieldId],
		[Fields].[CustomFieldName],
		[Fields].[CustomFieldDataType],
		[Fields].[CustomFieldRequired],
		ISNULL([FieldValues].[CustomFieldValue], '') CustomFieldValue,
		[Fields].[CustomFieldTypeId]
	FROM
		[dbo].[BNProjectCustomFields] Fields
		LEFT OUTER JOIN [dbo].[BNProjectCustomFieldValues] FieldValues ON (
																			  [Fields].[CustomFieldId] = [FieldValues].[CustomFieldId]
																			  AND [FieldValues].[IssueId] = @IssueId
																		  )
	WHERE
		[Fields].[ProjectId] = @ProjectId;
GO
