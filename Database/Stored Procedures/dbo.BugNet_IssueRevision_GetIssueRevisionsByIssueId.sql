SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueRevision_GetIssueRevisionsByIssueId]
	@IssueId INT
AS
	SELECT * FROM [BNIssueRevisions] WHERE IssueId = @IssueId;
GO
