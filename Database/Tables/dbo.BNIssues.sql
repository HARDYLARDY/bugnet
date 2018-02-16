CREATE TABLE [dbo].[BNIssues]
(
[IssueId] [int] NOT NULL IDENTITY(1, 1),
[IssueTitle] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IssueDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IssueStatusId] [int] NULL,
[IssuePriorityId] [int] NULL,
[IssueTypeId] [int] NULL,
[IssueCategoryId] [int] NULL,
[ProjectId] [int] NOT NULL,
[IssueAffectedMilestoneId] [int] NULL,
[IssueResolutionId] [int] NULL,
[IssueCreatorUserId] [uniqueidentifier] NOT NULL,
[IssueAssignedUserId] [uniqueidentifier] NULL,
[IssueOwnerUserId] [uniqueidentifier] NULL,
[IssueDueDate] [datetime] NULL CONSTRAINT [DF_BugNet_Issues_DueDate] DEFAULT ('1/1/1900 12:00:00 AM'),
[IssueMilestoneId] [int] NULL,
[IssueVisibility] [int] NOT NULL,
[IssueEstimation] [decimal] (5, 2) NOT NULL CONSTRAINT [DF_BugNet_Issues_Estimation] DEFAULT ((0)),
[IssueProgress] [int] NOT NULL CONSTRAINT [DF_BugNet_Issues_IssueProgress] DEFAULT ((0)),
[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_BugNet_Issues_DateCreated] DEFAULT (getdate()),
[LastUpdate] [datetime] NOT NULL,
[LastUpdateUserId] [uniqueidentifier] NOT NULL,
[Disabled] [bit] NOT NULL CONSTRAINT [DF_BugNet_Issues_Disabled] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [PK_BugNet_Issues] PRIMARY KEY CLUSTERED  ([IssueId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectCategories] FOREIGN KEY ([IssueCategoryId]) REFERENCES [dbo].[BNProjectCategories] ([CategoryId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectIssueTypes] FOREIGN KEY ([IssueTypeId]) REFERENCES [dbo].[BNProjectIssueTypes] ([IssueTypeId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones] FOREIGN KEY ([IssueMilestoneId]) REFERENCES [dbo].[BNProjectMilestones] ([MilestoneId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectMilestones1] FOREIGN KEY ([IssueAffectedMilestoneId]) REFERENCES [dbo].[BNProjectMilestones] ([MilestoneId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectPriorities] FOREIGN KEY ([IssuePriorityId]) REFERENCES [dbo].[BNProjectPriorities] ([PriorityId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectResolutions] FOREIGN KEY ([IssueResolutionId]) REFERENCES [dbo].[BNProjectResolutions] ([ResolutionId])
GO
ALTER TABLE [dbo].[BNIssues] WITH NOCHECK ADD CONSTRAINT [FK_BugNet_Issues_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_BugNet_ProjectStatus] FOREIGN KEY ([IssueStatusId]) REFERENCES [dbo].[BNProjectStatus] ([StatusId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_Users] FOREIGN KEY ([IssueAssignedUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_Users1] FOREIGN KEY ([IssueOwnerUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_Users2] FOREIGN KEY ([LastUpdateUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[BNIssues] ADD CONSTRAINT [FK_BugNet_Issues_Users3] FOREIGN KEY ([IssueCreatorUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
