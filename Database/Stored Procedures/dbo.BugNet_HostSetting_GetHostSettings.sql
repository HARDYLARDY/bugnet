SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_HostSetting_GetHostSettings]
AS
	SELECT SettingName, SettingValue FROM [BNHostSettings];
GO
