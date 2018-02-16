SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[BugNet_Issue_GetIssueMilestoneCountByProject] 
	@ProjectId int
AS

SELECT 
	MilestoneName,
	Number,	
	MilestoneId,
	MilestoneImageUrl
FROM BugNet_IssueMilestoneCountView
WHERE ProjectId = @ProjectId
ORDER BY SortOrder

GO
