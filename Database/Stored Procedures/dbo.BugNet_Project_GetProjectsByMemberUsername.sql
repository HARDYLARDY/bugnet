SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_GetProjectsByMemberUsername]
	@UserName NVARCHAR(255),
	@ActiveOnly BIT
AS
	DECLARE @Disabled BIT;

	SET @Disabled = 1;

	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @UserName;

	IF @ActiveOnly = 1
	BEGIN
		SET @Disabled = 0;
	END;

	SELECT DISTINCT
		[BugNet_ProjectsView].[ProjectId],
		[BugNet_ProjectsView].[ProjectName],
		[BugNet_ProjectsView].[ProjectCode],
		[BugNet_ProjectsView].[ProjectDescription],
		[BugNet_ProjectsView].[AttachmentUploadPath],
		[BugNet_ProjectsView].[ProjectManagerUserId],
		[BugNet_ProjectsView].[ProjectCreatorUserId],
		[BugNet_ProjectsView].[DateCreated],
		[BugNet_ProjectsView].[ProjectDisabled],
		[BugNet_ProjectsView].[ProjectAccessType],
		[BugNet_ProjectsView].[ManagerUserName],
		[BugNet_ProjectsView].[ManagerDisplayName],
		[BugNet_ProjectsView].[CreatorUserName],
		[BugNet_ProjectsView].[CreatorDisplayName],
		[BugNet_ProjectsView].[AllowAttachments],
		[BugNet_ProjectsView].[AllowAttachments],
		[BugNet_ProjectsView].[AttachmentStorageType],
		[BugNet_ProjectsView].[SvnRepositoryUrl],
		[BugNet_ProjectsView].[AllowIssueVoting]
	FROM
		[dbo].[BugNet_ProjectsView]
		LEFT JOIN [BNUserProjects] UP ON UP.ProjectId = [BugNet_ProjectsView].[ProjectId]
	WHERE
		(
			[BugNet_ProjectsView].[ProjectAccessType] = 1
			AND [BugNet_ProjectsView].[ProjectDisabled] = @Disabled
		)
		OR (
			   [BugNet_ProjectsView].[ProjectAccessType] = 2
			   AND [BugNet_ProjectsView].[ProjectDisabled] = @Disabled
			   AND (
					   UP.UserId = @UserId
					   OR [BugNet_ProjectsView].[ProjectManagerUserId] = @UserId
				   )
		   )
	ORDER BY
		[BugNet_ProjectsView].[ProjectName] ASC;
GO
