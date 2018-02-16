SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[BugNet_DefaultValues_GetByProjectId]
	@ProjectId int
As
SELECT * FROM BugNet_DefaultValView 
WHERE 
	ProjectId= @ProjectId
	
GO
