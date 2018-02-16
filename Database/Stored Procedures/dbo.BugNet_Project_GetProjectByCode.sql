SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectByCode]
@ProjectCode nvarchar(50)
AS
SELECT * FROM BugNet_ProjectsView WHERE ProjectCode = @ProjectCode
GO
