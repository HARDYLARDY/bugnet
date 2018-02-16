SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueRevision_DeleteIssueRevisions]
	@IssueRevisionId INT
AS
	DELETE FROM [BNIssueRevisions] WHERE IssueRevisionId = @IssueRevisionId;
GO
