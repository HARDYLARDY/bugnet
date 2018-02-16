SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[CreateCustomIssuesView]
	-- Add the parameters for the stored procedure here
	@ProjectID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DECLARE
		@CustomFieldID INT,
		@CustomFieldName NVARCHAR(50);
	DECLARE @stmt NVARCHAR(MAX);
	DECLARE @fields NVARCHAR(MAX);
	DECLARE @tables NVARCHAR(MAX);
	DECLARE @wheres NVARCHAR(MAX);
	DECLARE @id INT;

	DECLARE custFieldCur CURSOR FOR SELECT CustomFieldID, CustomFieldName FROM [dbo].[BNProjectCustomFields] WHERE ProjectId = @ProjectID;

	SET @fields = '';
	SET @wheres = '';
	SET @tables = '';
	SET @id = 0;

	OPEN custFieldCur;

	FETCH NEXT FROM custFieldCur
	INTO
		@CustomFieldID,
		@CustomFieldName;

	WHILE @@Fetch_Status = 0
	BEGIN
		SET @fields = @fields + ', A' + CAST(@id AS NVARCHAR) + '.CustomFieldValue AS [' + @CustomFieldName + ']';
		SET @tables = @tables + ', dbo.BugNet_ProjectCustomFieldValues A' + CAST(@id AS NVARCHAR);
		SET @wheres
			= @wheres + ' AND A' + CAST(@id AS NVARCHAR) + '.IssueId = A.IssueId AND A' + CAST(@id AS NVARCHAR) + '.CustomFieldId = ' + CAST(@CustomFieldID AS NVARCHAR);
		SET @id = @id + 1;

		FETCH NEXT FROM custFieldCur
		INTO
			@CustomFieldID,
			@CustomFieldName;
	END;

	CLOSE custFieldCur;
	DEALLOCATE custFieldCur;

	SET @stmt = ' VIEW BugNet_IssuesCustom_' + CAST(@ProjectID AS NVARCHAR) + ' AS SELECT A.*' + @fields + ' FROM BugNet_Issues A' + @tables + ' WHERE 1=1' + @wheres;

	IF EXISTS
	 (
		 SELECT
			 [VIEWS].[TABLE_NAME]
		 FROM
			 [INFORMATION_SCHEMA].[VIEWS]
		 WHERE
			 [VIEWS].[TABLE_NAME] = 'BugNet_IssuesCustom_' + CAST(@ProjectID AS NVARCHAR)
	 )
	BEGIN
		SET @stmt = 'ALTER' + @stmt;
	END;
	ELSE
	BEGIN
		SET @stmt = 'CREATE' + @stmt;
	END;

	EXECUTE [sys].[sp_executesql] @stmt;
END;
GO
