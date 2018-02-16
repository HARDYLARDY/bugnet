SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_SaveCustomFieldValue]
	@IssueId INT,
	@CustomFieldId INT,
	@CustomFieldValue NVARCHAR(MAX)
AS
	UPDATE
		[BNProjectCustomFieldValues]
	SET
		CustomFieldValue = @CustomFieldValue
	WHERE
		IssueId = @IssueId
		AND CustomFieldId = @CustomFieldId;

	IF @@RowCount = 0
		INSERT
			[BNProjectCustomFieldValues]
			 (
				 IssueId,
				 CustomFieldId,
				 CustomFieldValue
			 )
		VALUES
			 (
				 @IssueId, @CustomFieldId, @CustomFieldValue
			 );
GO
