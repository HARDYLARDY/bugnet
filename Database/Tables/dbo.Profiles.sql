CREATE TABLE [dbo].[Profiles]
(
[UserId] [uniqueidentifier] NOT NULL,
[PropertyNames] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyValueStrings] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyValueBinary] [image] NOT NULL,
[LastUpdatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Profiles] ADD CONSTRAINT [PK__Profiles__1788CC4C98CEBD6F] PRIMARY KEY CLUSTERED  ([UserId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Profiles] ADD CONSTRAINT [UserProfile] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
