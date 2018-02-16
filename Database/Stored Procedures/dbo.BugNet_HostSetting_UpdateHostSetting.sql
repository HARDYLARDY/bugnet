SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_HostSetting_UpdateHostSetting]
	@SettingName NVARCHAR(50),
	@SettingValue NVARCHAR(2000)
AS
	UPDATE
		[BNHostSettings]
	SET
		SettingName = @SettingName,
		SettingValue = @SettingValue
	WHERE
		SettingName = @SettingName;
GO
