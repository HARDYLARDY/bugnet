SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectIssueTypes_DeleteIssueType]
	@IssueTypeIdToDelete INT
AS
	DELETE [BNProjectIssueTypes] WHERE IssueTypeId = @IssueTypeIdToDelete;

	IF @@RowCount > 0
		RETURN 0;
	ELSE
		RETURN 1;
GO
