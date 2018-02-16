SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_UpdateCustomField]
	@CustomFieldId INT,
	@ProjectId INT,
	@CustomFieldName NVARCHAR(50),
	@CustomFieldDataType INT,
	@CustomFieldRequired BIT,
	@CustomFieldTypeId INT
AS
	UPDATE
		[BNProjectCustomFields]
	SET
		ProjectId = @ProjectId,
		CustomFieldName = @CustomFieldName,
		CustomFieldDataType = @CustomFieldDataType,
		CustomFieldRequired = @CustomFieldRequired,
		CustomFieldTypeId = @CustomFieldTypeId
	WHERE
		CustomFieldId = @CustomFieldId;
GO
