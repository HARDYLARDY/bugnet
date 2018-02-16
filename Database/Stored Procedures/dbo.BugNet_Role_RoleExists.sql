SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Role_RoleExists]
	@RoleName NVARCHAR(256),
	@ProjectId INT
AS
BEGIN
	IF ( EXISTS ( SELECT RoleName FROM [BNRoles] WHERE @RoleName = RoleName AND ProjectId = @ProjectId ))
		RETURN ( 1 );
	ELSE
		RETURN ( 0 );
END;
GO
