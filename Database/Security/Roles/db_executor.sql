CREATE ROLE [db_executor]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'db_executor', N'BugNetUser'
GO
GRANT EXECUTE TO [db_executor]
