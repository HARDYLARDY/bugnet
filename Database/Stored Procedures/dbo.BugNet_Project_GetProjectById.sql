SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectById]
 @ProjectId INT
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectId = @ProjectId

GO
