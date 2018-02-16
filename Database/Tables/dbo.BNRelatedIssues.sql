CREATE TABLE [dbo].[BNRelatedIssues]
(
[PrimaryIssueId] [int] NOT NULL,
[SecondaryIssueId] [int] NOT NULL,
[RelationType] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRelatedIssues] ADD CONSTRAINT [PK_BugNet_RelatedIssues] PRIMARY KEY CLUSTERED  ([PrimaryIssueId], [SecondaryIssueId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNRelatedIssues] ADD CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues] FOREIGN KEY ([PrimaryIssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BNRelatedIssues] ADD CONSTRAINT [FK_BugNet_RelatedIssues_BugNet_Issues1] FOREIGN KEY ([SecondaryIssueId]) REFERENCES [dbo].[BNIssues] ([IssueId])
GO
