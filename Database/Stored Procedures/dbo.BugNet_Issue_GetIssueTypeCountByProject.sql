SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueTypeCountByProject]
	@ProjectId int
AS

SELECT 
	IssueTypeName,
	Number,	
	IssueTypeId,
	IssueTypeImageUrl
FROM BugNet_Issue_IssueTypeCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder



GO
