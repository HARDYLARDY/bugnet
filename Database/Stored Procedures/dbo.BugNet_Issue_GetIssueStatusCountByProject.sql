SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueStatusCountByProject]
 @ProjectId int
AS
SELECT 
	StatusName,
	Number,	
	StatusId,
	StatusImageUrl
FROM BugNet_IssueStatusCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder



GO
