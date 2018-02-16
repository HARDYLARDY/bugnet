CREATE ROLE [aspnet_Roles_FullAccess]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'aspnet_Roles_FullAccess', N'BugNetUser'
GO
