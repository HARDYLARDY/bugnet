SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueUserCountByProject]
 @ProjectId int
AS

SELECT 
	AssignedName,
	Number,	
	AssignedUserId,
	AssignedImageUrl
FROM BugNet_IssueAssignedToCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder, AssignedName

GO
