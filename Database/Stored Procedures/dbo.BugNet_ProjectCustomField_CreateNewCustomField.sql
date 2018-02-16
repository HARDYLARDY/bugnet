SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectCustomField_CreateNewCustomField]
	@ProjectId INT,
	@CustomFieldName NVARCHAR(50),
	@CustomFieldDataType INT,
	@CustomFieldRequired BIT,
	@CustomFieldTypeId INT
AS
	IF NOT EXISTS
	 (
		 SELECT
			 CustomFieldId
		 FROM
			 [BNProjectCustomFields]
		 WHERE
			 ProjectId = @ProjectId
			 AND LOWER(CustomFieldName) = LOWER(@CustomFieldName)
	 )
	BEGIN
		INSERT
			[BNProjectCustomFields]
			 (
				 ProjectId,
				 CustomFieldName,
				 CustomFieldDataType,
				 CustomFieldRequired,
				 CustomFieldTypeId
			 )
		VALUES
			 (
				 @ProjectId, @CustomFieldName, @CustomFieldDataType, @CustomFieldRequired, @CustomFieldTypeId
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN 0;
GO
