CREATE TABLE [dbo].[BNProjects]
(
[ProjectId] [int] NOT NULL IDENTITY(1, 1),
[ProjectName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProjectCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProjectDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttachmentUploadPath] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_BugNet_Projects_DateCreated] DEFAULT (getdate()),
[ProjectDisabled] [bit] NOT NULL CONSTRAINT [DF_BugNet_Projects_Active] DEFAULT ((0)),
[ProjectAccessType] [int] NOT NULL,
[ProjectManagerUserId] [uniqueidentifier] NOT NULL,
[ProjectCreatorUserId] [uniqueidentifier] NOT NULL,
[AllowAttachments] [bit] NOT NULL CONSTRAINT [DF_BugNet_Projects_AllowAttachments] DEFAULT ((1)),
[AttachmentStorageType] [int] NULL,
[SvnRepositoryUrl] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AllowIssueVoting] [bit] NOT NULL CONSTRAINT [DF_BugNet_Projects_AllowIssueVoting] DEFAULT ((1)),
[ProjectImageFileContent] [varbinary] (max) NULL,
[ProjectImageFileName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProjectImageContentType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProjectImageFileSize] [bigint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjects] ADD CONSTRAINT [PK_BugNet_Projects] PRIMARY KEY CLUSTERED  ([ProjectId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjects] ADD CONSTRAINT [FK_BugNet_Projects_Users] FOREIGN KEY ([ProjectCreatorUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BNProjects] ADD CONSTRAINT [FK_BugNet_Projects_Users1] FOREIGN KEY ([ProjectManagerUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
