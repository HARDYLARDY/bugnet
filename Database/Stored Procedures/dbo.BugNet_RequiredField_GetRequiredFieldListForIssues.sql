SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_RequiredField_GetRequiredFieldListForIssues]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RequiredFieldId, FieldName, FieldValue FROM [BNRequiredFieldList];
END;
GO
