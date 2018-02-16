CREATE TABLE [dbo].[BNIssueRevisions]
(
[IssueRevisionId] [int] NOT NULL IDENTITY(1, 1),
[Revision] [int] NOT NULL,
[IssueId] [int] NOT NULL,
[Repository] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RevisionAuthor] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RevisionDate] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RevisionMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateCreated] [datetime] NOT NULL,
[Branch] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Changeset] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueRevisions] ADD CONSTRAINT [PK_BugNet_IssueRevisions] PRIMARY KEY CLUSTERED  ([IssueRevisionId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueRevisions] ADD CONSTRAINT [FK_BugNet_IssueRevisions_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId]) ON DELETE CASCADE
GO
