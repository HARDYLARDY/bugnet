CREATE TABLE [dbo].[BNIssueVotes]
(
[IssueVoteId] [int] NOT NULL IDENTITY(1, 1),
[IssueId] [int] NOT NULL,
[UserId] [uniqueidentifier] NOT NULL,
[DateCreated] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueVotes] ADD CONSTRAINT [PK_BugNet_IssueVotes] PRIMARY KEY CLUSTERED  ([IssueVoteId]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNIssueVotes] ADD CONSTRAINT [FK_BugNet_IssueVotes_BugNet_Issues] FOREIGN KEY ([IssueId]) REFERENCES [dbo].[BNIssues] ([IssueId])
GO
ALTER TABLE [dbo].[BNIssueVotes] ADD CONSTRAINT [FK_BugNet_IssueVotes_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
GO
