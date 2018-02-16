CREATE TABLE [dbo].[BNDefaultValues]
(
[ProjectId] [int] NOT NULL,
[DefaultType] [int] NULL,
[StatusId] [int] NULL,
[IssueOwnerUserId] [uniqueidentifier] NULL,
[IssuePriorityId] [int] NULL,
[IssueAffectedMilestoneId] [int] NULL,
[IssueAssignedUserId] [uniqueidentifier] NULL,
[IssueVisibility] [int] NULL,
[IssueCategoryId] [int] NULL,
[IssueDueDate] [int] NULL,
[IssueProgress] [int] NULL,
[IssueMilestoneId] [int] NULL,
[IssueEstimation] [decimal] (5, 2) NULL,
[IssueResolutionId] [int] NULL,
[OwnedByNotify] [bit] NULL CONSTRAINT [DF_BugNet_DefaultValues_OwnedByNotify] DEFAULT ((1)),
[AssignedToNotify] [bit] NULL CONSTRAINT [DF_BugNet_DefaultValues_AssignedTo] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNDefaultValues] ADD CONSTRAINT [PK_BugNet_DefaultValues] PRIMARY KEY CLUSTERED  ([ProjectId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNDefaultValues] ADD CONSTRAINT [FK_BugNet_DefaultValues_BugNet_Projects] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[BNProjects] ([ProjectId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNDefaultValues] ADD CONSTRAINT [FK_BugNet_DefaultValues_Users] FOREIGN KEY ([IssueOwnerUserId]) REFERENCES [dbo].[Users] ([UserId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNDefaultValues] ADD CONSTRAINT [FK_BugNet_DefaultValues_Users1] FOREIGN KEY ([IssueAssignedUserId]) REFERENCES [dbo].[Users] ([UserId])
GO
