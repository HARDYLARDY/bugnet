CREATE TABLE [dbo].[BNProjectMilestones]
(
[MilestoneId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NOT NULL,
[MilestoneName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MilestoneImageUrl] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL,
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_BugNet_ProjectMilestones_CreateDate] DEFAULT (getdate()),
[MilestoneDueDate] [datetime] NULL,
[MilestoneReleaseDate] [datetime] NULL,
[MilestoneNotes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MilestoneCompleted] [bit] NOT NULL CONSTRAINT [DF_BugNet_ProjectMilestones_Completed] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectMilestones] ADD CONSTRAINT [PK_BugNet_ProjectMilestones] PRIMARY KEY CLUSTERED  ([MilestoneId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNProjectMilestones] ADD CONSTRAINT [FK_BugNet_ProjectMilestones_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
