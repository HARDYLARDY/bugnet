SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_GetAllRoles]
AS
	SELECT RoleId, RoleName, RoleDescription, ProjectId, AutoAssign FROM [BNRoles];
GO
