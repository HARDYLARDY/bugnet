SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_CreateNewIssueType]
	@ProjectId INT,
	@IssueTypeName NVARCHAR(50),
	@IssueTypeImageUrl NVARCHAR(50)
AS
	IF NOT EXISTS
	 (
		 SELECT
			 IssueTypeId
		 FROM
			 [BNProjectIssueTypes]
		 WHERE
			 LOWER(IssueTypeName) = LOWER(@IssueTypeName)
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		DECLARE @SortOrder INT;

		SELECT
			@SortOrder = ISNULL(MAX(SortOrder + 1), 1)
		FROM
			[BNProjectIssueTypes]
		WHERE
			ProjectId = @ProjectId;

		INSERT
			[BNProjectIssueTypes]
			 (
				 ProjectId,
				 IssueTypeName,
				 IssueTypeImageUrl,
				 SortOrder
			 )
		VALUES
			 (
				 @ProjectId, @IssueTypeName, @IssueTypeImageUrl, @SortOrder
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN -1;
GO
