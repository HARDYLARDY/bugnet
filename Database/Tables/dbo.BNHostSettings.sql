CREATE TABLE [dbo].[BNHostSettings]
(
[SettingName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNHostSettings] ADD CONSTRAINT [PK_BugNet_HostSettings] PRIMARY KEY CLUSTERED  ([SettingName]) ON [PRIMARY]
GO
