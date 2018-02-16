SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_UpdateIssueType]
	@ProjectId INT,
	@IssueTypeId INT,
	@IssueTypeName NVARCHAR(50),
	@IssueTypeImageUrl NVARCHAR(255),
	@SortOrder INT
AS
	DECLARE @OldSortOrder INT;
	DECLARE @OldIssueTypeId INT;

	SELECT @OldSortOrder = SortOrder FROM [BNProjectIssueTypes] WHERE IssueTypeId = @IssueTypeId;

	SELECT
		@OldIssueTypeId = IssueTypeId
	FROM
		[BNProjectIssueTypes]
	WHERE
		SortOrder = @SortOrder
		AND ProjectId = @ProjectId;

	UPDATE
		[BNProjectIssueTypes]
	SET
		ProjectId = @ProjectId,
		IssueTypeName = @IssueTypeName,
		IssueTypeImageUrl = @IssueTypeImageUrl,
		SortOrder = @SortOrder
	WHERE
		IssueTypeId = @IssueTypeId;

	UPDATE [BNProjectIssueTypes] SET SortOrder = @OldSortOrder WHERE IssueTypeId = @OldIssueTypeId;
GO
