SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_User_GetUserNameByPasswordResetToken]
	@Token NVARCHAR(255),
	@UserName NVARCHAR(255) OUTPUT
AS
	SET NOCOUNT ON;

	SELECT @UserName = UserName FROM [BNUserProfiles] WHERE PasswordVerificationToken = @Token;
GO
