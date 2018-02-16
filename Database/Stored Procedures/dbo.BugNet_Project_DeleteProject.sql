SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_Project_DeleteProject]
	@ProjectIdToDelete INT
AS

	--Delete these first
	DELETE FROM
	[dbo].[BNIssueVotes]
	WHERE
		[BNIssueVotes].[IssueId] IN (
										SELECT B.IssueId FROM [BNIssues] B WHERE B.ProjectId = @ProjectIdToDelete
									);

	DELETE FROM [BNIssues] WHERE ProjectId = @ProjectIdToDelete;

	--Now Delete everything that was attached to a project and an issue
	DELETE FROM
	[BNIssues]
	WHERE
		[BNIssues].[IssueCategoryId] IN (
											SELECT
												[B].[CategoryId]
											FROM
												[dbo].[BNProjectCategories] B
											WHERE
												[B].[ProjectId] = @ProjectIdToDelete
										);

	DELETE FROM
	[dbo].[BNProjectCategories]
	WHERE
		[BNProjectCategories].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM [dbo].[BNProjectStatus] WHERE [BNProjectStatus].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM
	[dbo].[BNProjectMilestones]
	WHERE
		[BNProjectMilestones].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM [dbo].[BNUserProjects] WHERE [BNUserProjects].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM [dbo].[BNProjectMailBoxes] WHERE [BNProjectMailBoxes].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM
	[dbo].[BNProjectIssueTypes]
	WHERE
		[BNProjectIssueTypes].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM
	[dbo].[BNProjectResolutions]
	WHERE
		[BNProjectResolutions].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM
	[dbo].[BNProjectPriorities]
	WHERE
		[BNProjectPriorities].[ProjectId] = @ProjectIdToDelete;

	--now delete everything attached to the project
	DELETE FROM
	[dbo].[BNProjectCustomFieldValues]
	WHERE
		[BNProjectCustomFieldValues].[CustomFieldId] IN (
															SELECT
																[B].[CustomFieldId]
															FROM
																[dbo].[BNProjectCustomFields] B
															WHERE
																[B].[ProjectId] = @ProjectIdToDelete
														);

	DELETE FROM
	[dbo].[BNProjectCustomFields]
	WHERE
		[BNProjectCustomFields].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM [dbo].[BNRoles] WHERE [BNRoles].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM [dbo].[BNQueries] WHERE [BNQueries].[ProjectId] = @ProjectIdToDelete;

	DELETE FROM
	[dbo].[BNProjectNotifications]
	WHERE
		[BNProjectNotifications].[ProjectId] = @ProjectIdToDelete;

	--now delete the project
	DELETE FROM [dbo].[BNProjects] WHERE [BNProjects].[ProjectId] = @ProjectIdToDelete;
GO
