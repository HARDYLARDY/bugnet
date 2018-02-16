SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_CreateNewProject]
	@ProjectName NVARCHAR(50),
	@ProjectCode NVARCHAR(50),
	@ProjectDescription NVARCHAR(1000),
	@ProjectManagerUserName NVARCHAR(255),
	@AttachmentUploadPath NVARCHAR(80),
	@ProjectAccessType INT,
	@ProjectCreatorUserName NVARCHAR(255),
	@AllowAttachments INT,
	@AttachmentStorageType INT,
	@SvnRepositoryUrl NVARCHAR(255),
	@AllowIssueVoting BIT,
	@ProjectImageFileContent VARBINARY(MAX),
	@ProjectImageFileName NVARCHAR(150),
	@ProjectImageContentType NVARCHAR(50),
	@ProjectImageFileSize BIGINT
AS
	IF NOT EXISTS
	 (
		 SELECT
			 ProjectId,
			 ProjectCode
		 FROM
			 [BNProjects]
		 WHERE
			 LOWER(ProjectName) = LOWER(@ProjectName)
			 OR LOWER(ProjectCode) = LOWER(@ProjectCode)
	 )
	BEGIN
		DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER;
		DECLARE @ProjectCreatorUserId UNIQUEIDENTIFIER;

		SELECT
			@ProjectManagerUserId = [Users].[UserId]
		FROM
			[dbo].[Users]
		WHERE
			[Users].[UserName] = @ProjectManagerUserName;

		SELECT
			@ProjectCreatorUserId = [Users].[UserId]
		FROM
			[dbo].[Users]
		WHERE
			[Users].[UserName] = @ProjectCreatorUserName;

		INSERT
			[BNProjects]
			 (
				 ProjectName,
				 ProjectCode,
				 ProjectDescription,
				 AttachmentUploadPath,
				 ProjectManagerUserId,
				 DateCreated,
				 ProjectCreatorUserId,
				 ProjectAccessType,
				 AllowAttachments,
				 AttachmentStorageType,
				 SvnRepositoryUrl,
				 AllowIssueVoting,
				 ProjectImageFileContent,
				 ProjectImageFileName,
				 ProjectImageContentType,
				 ProjectImageFileSize
			 )
		VALUES
			 (
				 @ProjectName,
				 @ProjectCode,
				 @ProjectDescription,
				 @AttachmentUploadPath,
				 @ProjectManagerUserId,
				 GETDATE(),
				 @ProjectCreatorUserId,
				 @ProjectAccessType,
				 @AllowAttachments,
				 @AttachmentStorageType,
				 @SvnRepositoryUrl,
				 @AllowIssueVoting,
				 @ProjectImageFileContent,
				 @ProjectImageFileName,
				 @ProjectImageContentType,
				 @ProjectImageFileSize
			 );

		RETURN SCOPE_IDENTITY();
	END;
	ELSE
		RETURN 0;
GO
