CREATE TABLE [dbo].[BNProjectNotifications]
(
[ProjectNotificationid] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectNotifications] ADD CONSTRAINT [PK_BugNet_ProjectNotifications] PRIMARY KEY CLUSTERED  ([ProjectNotificationid]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectNotifications] ADD CONSTRAINT [FK_BugNet_ProjectNotifications_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNProjectNotifications] ADD CONSTRAINT [FK_BugNet_ProjectNotifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
