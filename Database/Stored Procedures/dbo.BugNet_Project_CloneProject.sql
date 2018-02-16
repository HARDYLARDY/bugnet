SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_CloneProject]
(
	@ProjectId INT,
	@ProjectName NVARCHAR(256),
	@CloningUserName VARCHAR(75) = NULL
)
AS
	DECLARE @CreatorUserId UNIQUEIDENTIFIER;

	SET NOCOUNT OFF;

	SET @CreatorUserId =
	  (
		  SELECT
			  [BNProjects].[ProjectCreatorUserId]
		  FROM
			  [dbo].[BNProjects]
		  WHERE
			  [BNProjects].[ProjectId] = @ProjectId
	  );

	IF ( @CloningUserName IS NOT NULL OR LTRIM(RTRIM(@CloningUserName)) != '' ) EXEC [dbo].[BugNet_User_GetUserIdByUserName] @UserName = @CloningUserName, @UserId = @CreatorUserId OUTPUT;

	-- Copy Project
	INSERT
		[dbo].[BNProjects]
		 (
			 ProjectName,
			 ProjectCode,
			 ProjectDescription,
			 AttachmentUploadPath,
			 DateCreated,
			 ProjectDisabled,
			 ProjectAccessType,
			 ProjectManagerUserId,
			 ProjectCreatorUserId,
			 AllowAttachments,
			 AttachmentStorageType,
			 SvnRepositoryUrl
		 )
	SELECT
		@ProjectName,
		ProjectCode,
		ProjectDescription,
		AttachmentUploadPath,
		GETDATE(),
		ProjectDisabled,
		ProjectAccessType,
		ProjectManagerUserId,
		@CreatorUserId,
		AllowAttachments,
		AttachmentStorageType,
		SvnRepositoryUrl
	FROM
		[dbo].[BNProjects]
	WHERE
		ProjectId = @ProjectId;

	DECLARE @NewProjectId INT;

	SET @NewProjectId = SCOPE_IDENTITY();

	-- Copy Milestones
	INSERT
		[dbo].[BNProjectMilestones]
		 (
			 ProjectId,
			 MilestoneName,
			 MilestoneImageUrl,
			 SortOrder,
			 DateCreated
		 )
	SELECT
		@NewProjectId,
		MilestoneName,
		MilestoneImageUrl,
		SortOrder,
		GETDATE()
	FROM
		[dbo].[BNProjectMilestones]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Project Members
	INSERT
		[dbo].[BNUserProjects]
		 (
			 UserId,
			 ProjectId,
			 DateCreated
		 )
	SELECT UserId, @NewProjectId, GETDATE()FROM [dbo].[BNUserProjects] WHERE ProjectId = @ProjectId;

	-- Copy Project Roles
	INSERT
		[dbo].[BNRoles]
		 (
			 ProjectId,
			 RoleName,
			 RoleDescription,
			 AutoAssign
		 )
	SELECT
		@NewProjectId,
		RoleName,
		RoleDescription,
		AutoAssign
	FROM
		[dbo].[BNRoles]
	WHERE
		ProjectId = @ProjectId;

	CREATE TABLE #OldRoles
	(
		OldRowNumber INT IDENTITY,
		OldRoleId INT,
	);

	INSERT
		#OldRoles
		 (
			 OldRoleId
		 )
	SELECT
		[BNRoles].[RoleId]
	FROM
		[dbo].[BNRoles]
	WHERE
		[BNRoles].[ProjectId] = @ProjectId
	ORDER BY
		[BNRoles].[RoleId];

	CREATE TABLE #NewRoles
	(
		NewRowNumber INT IDENTITY,
		NewRoleId INT,
	);

	INSERT
		#NewRoles
		 (
			 NewRoleId
		 )
	SELECT
		[BNRoles].[RoleId]
	FROM
		[dbo].[BNRoles]
	WHERE
		[BNRoles].[ProjectId] = @NewProjectId
	ORDER BY
		[BNRoles].[RoleId];

	INSERT
		[dbo].[BNUserRoles]
		 (
			 UserId,
			 RoleId
		 )
	SELECT
		[UR].[UserId],
		RoleId = [#NewRoles].[NewRoleId]
	FROM
		#OldRoles
		INNER JOIN #NewRoles ON [#OldRoles].[OldRowNumber] = [#NewRoles].[NewRowNumber]
		INNER JOIN [dbo].[BNUserRoles] UR ON [UR].[RoleId] = [#OldRoles].[OldRoleId];

	-- Copy Role Permissions
	INSERT
		[dbo].[BNRolePermissions]
		 (
			 PermissionId,
			 RoleId
		 )
	SELECT
		[Perm].[PermissionId],
		[NewRoles].[RoleId]
	FROM
		[dbo].[BNRolePermissions] Perm
		INNER JOIN [dbo].[BNRoles] OldRoles ON [Perm].[RoleId] = [OldRoles].[RoleId]
		INNER JOIN [dbo].[BNRoles] NewRoles ON [NewRoles].[RoleName] = [OldRoles].[RoleName]
	WHERE
		[OldRoles].[ProjectId] = @ProjectId
		AND [NewRoles].[ProjectId] = @NewProjectId;

	-- Copy Custom Fields
	INSERT
		[dbo].[BNProjectCustomFields]
		 (
			 ProjectId,
			 CustomFieldName,
			 CustomFieldRequired,
			 CustomFieldDataType,
			 CustomFieldTypeId
		 )
	SELECT
		@NewProjectId,
		CustomFieldName,
		CustomFieldRequired,
		CustomFieldDataType,
		CustomFieldTypeId
	FROM
		[dbo].[BNProjectCustomFields]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Custom Field Selections
	CREATE TABLE #OldCustomFields
	(
		OldRowNumber INT IDENTITY,
		OldCustomFieldId INT,
	);

	INSERT
		#OldCustomFields
		 (
			 OldCustomFieldId
		 )
	SELECT
		[BNProjectCustomFields].[CustomFieldId]
	FROM
		[dbo].[BNProjectCustomFields]
	WHERE
		[BNProjectCustomFields].[ProjectId] = @ProjectId
	ORDER BY
		[BNProjectCustomFields].[CustomFieldId];

	CREATE TABLE #NewCustomFields
	(
		NewRowNumber INT IDENTITY,
		NewCustomFieldId INT,
	);

	INSERT
		#NewCustomFields
		 (
			 NewCustomFieldId
		 )
	SELECT
		[BNProjectCustomFields].[CustomFieldId]
	FROM
		[dbo].[BNProjectCustomFields]
	WHERE
		[BNProjectCustomFields].[ProjectId] = @NewProjectId
	ORDER BY
		[BNProjectCustomFields].[CustomFieldId];

	INSERT
		[dbo].[BNProjectCustomFieldSelections]
		 (
			 CustomFieldId,
			 CustomFieldSelectionValue,
			 CustomFieldSelectionName,
			 CustomFieldSelectionSortOrder
		 )
	SELECT
		CustomFieldId = [#NewCustomFields].[NewCustomFieldId],
		[CFS].[CustomFieldSelectionValue],
		[CFS].[CustomFieldSelectionName],
		[CFS].[CustomFieldSelectionSortOrder]
	FROM
		#OldCustomFields
		INNER JOIN #NewCustomFields ON [#OldCustomFields].[OldRowNumber] = [#NewCustomFields].[NewRowNumber]
		INNER JOIN [dbo].[BNProjectCustomFieldSelections] CFS ON [CFS].[CustomFieldId] = [#OldCustomFields].[OldCustomFieldId];

	-- Copy Project Mailboxes
	INSERT
		[dbo].[BNProjectMailBoxes]
		 (
			 MailBox,
			 ProjectId,
			 AssignToUserId,
			 IssueTypeId
		 )
	SELECT
		MailBox,
		@NewProjectId,
		AssignToUserId,
		IssueTypeId
	FROM
		[dbo].[BNProjectMailBoxes]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Categories
	INSERT
		[BNProjectCategories]
		 (
			 ProjectId,
			 CategoryName,
			 ParentCategoryId
		 )
	SELECT
		@NewProjectId,
		CategoryName,
		ParentCategoryId
	FROM
		[BNProjectCategories]
	WHERE
		ProjectId = @ProjectId
		AND Disabled = 0;

	CREATE TABLE #OldCategories
	(
		OldRowNumber INT IDENTITY,
		OldCategoryId INT,
	);

	INSERT
		#OldCategories
		 (
			 OldCategoryId
		 )
	SELECT
		CategoryId
	FROM
		[BNProjectCategories]
	WHERE
		ProjectId = @ProjectId
		AND Disabled = 0
	ORDER BY
		CategoryId;

	CREATE TABLE #NewCategories
	(
		NewRowNumber INT IDENTITY,
		NewCategoryId INT,
	);

	INSERT
		#NewCategories
		 (
			 NewCategoryId
		 )
	SELECT
		CategoryId
	FROM
		[BNProjectCategories]
	WHERE
		ProjectId = @NewProjectId
		AND Disabled = 0
	ORDER BY
		CategoryId;

	UPDATE
		[BNProjectCategories]
	SET
		ParentCategoryId = NewCategoryId
	FROM
		#OldCategories
		INNER JOIN #NewCategories ON [#OldCategories].[OldRowNumber] = [#NewCategories].[NewRowNumber]
	WHERE
		ProjectId = @NewProjectId
		AND ParentCategoryId = [#OldCategories].[OldCategoryId];

	-- Copy Status's
	INSERT
		[dbo].[BNProjectStatus]
		 (
			 ProjectId,
			 StatusName,
			 StatusImageUrl,
			 SortOrder,
			 IsClosedState
		 )
	SELECT
		@NewProjectId,
		StatusName,
		StatusImageUrl,
		SortOrder,
		IsClosedState
	FROM
		[dbo].[BNProjectStatus]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Priorities
	INSERT
		[dbo].[BNProjectPriorities]
		 (
			 ProjectId,
			 PriorityName,
			 PriorityImageUrl,
			 SortOrder
		 )
	SELECT
		@NewProjectId,
		PriorityName,
		PriorityImageUrl,
		SortOrder
	FROM
		[dbo].[BNProjectPriorities]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Resolutions
	INSERT
		[dbo].[BNProjectResolutions]
		 (
			 ProjectId,
			 ResolutionName,
			 ResolutionImageUrl,
			 SortOrder
		 )
	SELECT
		@NewProjectId,
		ResolutionName,
		ResolutionImageUrl,
		SortOrder
	FROM
		[dbo].[BNProjectResolutions]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Issue Types
	INSERT
		[dbo].[BNProjectIssueTypes]
		 (
			 ProjectId,
			 IssueTypeName,
			 IssueTypeImageUrl,
			 SortOrder
		 )
	SELECT
		@NewProjectId,
		IssueTypeName,
		IssueTypeImageUrl,
		SortOrder
	FROM
		[dbo].[BNProjectIssueTypes]
	WHERE
		ProjectId = @ProjectId;

	-- Copy Project Notifications
	INSERT
		[dbo].[BNProjectNotifications]
		 (
			 ProjectId,
			 UserId
		 )
	SELECT @NewProjectId, UserId FROM [dbo].[BNProjectNotifications] WHERE ProjectId = @ProjectId;

	RETURN @NewProjectId;
GO
