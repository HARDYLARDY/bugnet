SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueRevision_CreateNewIssueRevision]
	@IssueId INT,
	@Revision INT,
	@Repository NVARCHAR(400),
	@RevisionDate NVARCHAR(100),
	@RevisionAuthor NVARCHAR(100),
	@RevisionMessage NTEXT,
	@Changeset NVARCHAR(100),
	@Branch NVARCHAR(255)
AS
	IF ( NOT EXISTS
	 (
		 SELECT
			 IssueRevisionId
		 FROM
			 [BNIssueRevisions]
		 WHERE
			 IssueId = @IssueId
			 AND Revision = @Revision
			 AND RevisionDate = @RevisionDate
			 AND Repository = @Repository
			 AND RevisionAuthor = @RevisionAuthor
	 )
	   )
	BEGIN
		INSERT
			[BNIssueRevisions]
			 (
				 Revision,
				 IssueId,
				 Repository,
				 RevisionAuthor,
				 RevisionDate,
				 RevisionMessage,
				 Changeset,
				 Branch,
				 DateCreated
			 )
		VALUES
			 (
				 @Revision, @IssueId, @Repository, @RevisionAuthor, @RevisionDate, @RevisionMessage, @Changeset, @Branch, GETDATE()
			 );

		RETURN SCOPE_IDENTITY();
	END;
GO
