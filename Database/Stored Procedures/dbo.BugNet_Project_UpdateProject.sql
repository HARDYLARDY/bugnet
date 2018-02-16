SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_UpdateProject]
	@ProjectId INT,
	@ProjectName NVARCHAR(50),
	@ProjectCode NVARCHAR(50),
	@ProjectDescription NVARCHAR(1000),
	@ProjectManagerUserName NVARCHAR(255),
	@AttachmentUploadPath NVARCHAR(80),
	@ProjectAccessType INT,
	@ProjectDisabled INT,
	@AllowAttachments BIT,
	@AttachmentStorageType INT,
	@SvnRepositoryUrl NVARCHAR(255),
	@AllowIssueVoting BIT,
	@ProjectImageFileContent VARBINARY(MAX),
	@ProjectImageFileName NVARCHAR(150),
	@ProjectImageContentType NVARCHAR(50),
	@ProjectImageFileSize BIGINT
AS
	DECLARE @ProjectManagerUserId UNIQUEIDENTIFIER;

	SELECT
		@ProjectManagerUserId = [Users].[UserId]
	FROM
		[dbo].[Users]
	WHERE
		[Users].[UserName] = @ProjectManagerUserName;

	IF @ProjectImageFileContent IS NULL
		UPDATE
			[BNProjects]
		SET
			ProjectName = @ProjectName,
			ProjectCode = @ProjectCode,
			ProjectDescription = @ProjectDescription,
			ProjectManagerUserId = @ProjectManagerUserId,
			AttachmentUploadPath = @AttachmentUploadPath,
			ProjectAccessType = @ProjectAccessType,
			ProjectDisabled = @ProjectDisabled,
			AllowAttachments = @AllowAttachments,
			AttachmentStorageType = @AttachmentStorageType,
			SvnRepositoryUrl = @SvnRepositoryUrl,
			AllowIssueVoting = @AllowIssueVoting
		WHERE
			ProjectId = @ProjectId;
	ELSE
		UPDATE
			[BNProjects]
		SET
			ProjectName = @ProjectName,
			ProjectCode = @ProjectCode,
			ProjectDescription = @ProjectDescription,
			ProjectManagerUserId = @ProjectManagerUserId,
			AttachmentUploadPath = @AttachmentUploadPath,
			ProjectAccessType = @ProjectAccessType,
			ProjectDisabled = @ProjectDisabled,
			AllowAttachments = @AllowAttachments,
			AttachmentStorageType = @AttachmentStorageType,
			SvnRepositoryUrl = @SvnRepositoryUrl,
			ProjectImageFileContent = @ProjectImageFileContent,
			ProjectImageFileName = @ProjectImageFileName,
			ProjectImageContentType = @ProjectImageContentType,
			ProjectImageFileSize = @ProjectImageFileSize,
			AllowIssueVoting = @AllowIssueVoting
		WHERE
			ProjectId = @ProjectId;
GO
