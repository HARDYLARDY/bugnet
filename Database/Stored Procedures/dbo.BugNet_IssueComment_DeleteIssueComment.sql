SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE PROCEDURE [dbo].[BugNet_IssueComment_DeleteIssueComment]
	@IssueCommentId INT
AS
	DELETE [BNIssueComments] WHERE IssueCommentId = @IssueCommentId;
GO
