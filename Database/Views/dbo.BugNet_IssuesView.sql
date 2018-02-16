SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_IssuesView]
AS
	SELECT
		[dbo].[BNIssues].[IssueId],
		[dbo].[BNIssues].[IssueTitle],
		[dbo].[BNIssues].[IssueDescription],
		[dbo].[BNIssues].[IssueStatusId],
		[dbo].[BNIssues].[IssuePriorityId],
		[dbo].[BNIssues].[IssueTypeId],
		[dbo].[BNIssues].[IssueCategoryId],
		[dbo].[BNIssues].[ProjectId],
		[dbo].[BNIssues].[IssueResolutionId],
		[dbo].[BNIssues].[IssueCreatorUserId],
		[dbo].[BNIssues].[IssueAssignedUserId],
		[dbo].[BNIssues].[IssueOwnerUserId],
		[dbo].[BNIssues].[IssueDueDate],
		[dbo].[BNIssues].[IssueMilestoneId],
		[dbo].[BNIssues].[IssueAffectedMilestoneId],
		[dbo].[BNIssues].[IssueVisibility],
		[dbo].[BNIssues].[IssueEstimation],
		[dbo].[BNIssues].[DateCreated],
		[dbo].[BNIssues].[LastUpdate],
		[dbo].[BNIssues].[LastUpdateUserId],
		[BNProjects].[ProjectName],
		[BNProjects].[ProjectCode],
		ISNULL([BNProjectPriorities].[PriorityName], N'Unassigned') AS PriorityName,
		ISNULL([BNProjectIssueTypes].[IssueTypeName], N'Unassigned') AS IssueTypeName,
		ISNULL([BNProjectCategories].[CategoryName], N'Unassigned') AS CategoryName,
		ISNULL([BNProjectStatus].[StatusName], N'Unassigned') AS StatusName,
		ISNULL([BNProjectMilestones].[MilestoneName], N'Unassigned') AS MilestoneName,
		ISNULL([AffectedMilestone].[MilestoneName], N'Unassigned') AS AffectedMilestoneName,
		ISNULL([BNProjectResolutions].[ResolutionName], 'Unassigned') AS ResolutionName,
		[LastUpdateUsers].[UserName] AS LastUpdateUserName,
		ISNULL([AssignedUsers].[UserName], N'Unassigned') AS AssignedUserName,
		ISNULL([AssignedUsersProfile].[DisplayName], N'Unassigned') AS AssignedDisplayName,
		[CreatorUsers].[UserName] AS CreatorUserName,
		ISNULL([CreatorUsersProfile].[DisplayName], N'Unassigned') AS CreatorDisplayName,
		ISNULL([OwnerUsers].[UserName], 'Unassigned') AS OwnerUserName,
		ISNULL([OwnerUsersProfile].[DisplayName], N'Unassigned') AS OwnerDisplayName,
		ISNULL([LastUpdateUsersProfile].[DisplayName], 'Unassigned') AS LastUpdateDisplayName,
		ISNULL([BNProjectPriorities].[PriorityImageUrl], '') AS PriorityImageUrl,
		ISNULL([BNProjectIssueTypes].[IssueTypeImageUrl], '') AS IssueTypeImageUrl,
		ISNULL([BNProjectStatus].[StatusImageUrl], '') AS StatusImageUrl,
		ISNULL([BNProjectMilestones].[MilestoneImageUrl], '') AS MilestoneImageUrl,
		ISNULL([BNProjectResolutions].[ResolutionImageUrl], '') AS ResolutionImageUrl,
		ISNULL([AffectedMilestone].[MilestoneImageUrl], '') AS AffectedMilestoneImageUrl,
		ISNULL(
			 (
				 SELECT
					 SUM([WR].[Duration]) AS Expr1
				 FROM
					 [dbo].[BNIssueWorkReports] AS WR
				 WHERE
					 ( [WR].[IssueId] = [dbo].[BNIssues].[IssueId] )
			 ),
			 0.00
			  ) AS TimeLogged,
		ISNULL(
			 (
				 SELECT
					 COUNT([V].[IssueId]) AS Expr1
				 FROM
					 [dbo].[BNIssueVotes] AS V
				 WHERE
					 ( [V].[IssueId] = [dbo].[BNIssues].[IssueId] )
			 ),
			 0
			  ) AS IssueVotes,
		[dbo].[BNIssues].[Disabled],
		[dbo].[BNIssues].[IssueProgress],
		[BNProjectMilestones].[MilestoneDueDate],
		[BNProjects].[ProjectDisabled],
		CAST(COALESCE([BNProjectStatus].[IsClosedState], 0) AS BIT) AS IsClosed,
		CAST(CONVERT(VARCHAR(8), [dbo].[BNIssues].[LastUpdate], 112) AS DATETIME) AS LastUpdateAsDate,
		CAST(CONVERT(VARCHAR(8), [dbo].[BNIssues].[DateCreated], 112) AS DATETIME) AS DateCreatedAsDate
	FROM
		[dbo].[BNIssues]
		LEFT OUTER JOIN [dbo].[BNProjectIssueTypes] ON [dbo].[BNIssues].[IssueTypeId] = [dbo].[BNProjectIssueTypes].[IssueTypeId]
		LEFT OUTER JOIN [dbo].[BNProjectPriorities] ON [dbo].[BNIssues].[IssuePriorityId] = [dbo].[BNProjectPriorities].[PriorityId]
		LEFT OUTER JOIN [dbo].[BNProjectCategories] ON [dbo].[BNIssues].[IssueCategoryId] = [dbo].[BNProjectCategories].[CategoryId]
		LEFT OUTER JOIN [dbo].[BNProjectStatus] ON [dbo].[BNIssues].[IssueStatusId] = [dbo].[BNProjectStatus].[StatusId]
		LEFT OUTER JOIN [dbo].[BNProjectMilestones] AS AffectedMilestone ON [dbo].[BNIssues].[IssueAffectedMilestoneId] = AffectedMilestone.MilestoneId
		LEFT OUTER JOIN [dbo].[BNProjectMilestones] ON [dbo].[BNIssues].[IssueMilestoneId] = [dbo].[BNProjectMilestones].[MilestoneId]
		LEFT OUTER JOIN [dbo].[BNProjectResolutions] ON [dbo].[BNIssues].[IssueResolutionId] = [dbo].[BNProjectResolutions].[ResolutionId]
		LEFT OUTER JOIN [dbo].[Users] AS AssignedUsers ON [dbo].[BNIssues].[IssueAssignedUserId] = AssignedUsers.UserId
		LEFT OUTER JOIN [dbo].[Users] AS LastUpdateUsers ON [dbo].[BNIssues].[LastUpdateUserId] = LastUpdateUsers.UserId
		LEFT OUTER JOIN [dbo].[Users] AS CreatorUsers ON [dbo].[BNIssues].[IssueCreatorUserId] = CreatorUsers.UserId
		LEFT OUTER JOIN [dbo].[Users] AS OwnerUsers ON [dbo].[BNIssues].[IssueOwnerUserId] = OwnerUsers.UserId
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS CreatorUsersProfile ON [CreatorUsers].[UserName] = [CreatorUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS AssignedUsersProfile ON [AssignedUsers].[UserName] = [AssignedUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS OwnerUsersProfile ON [OwnerUsers].[UserName] = [OwnerUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS LastUpdateUsersProfile ON [LastUpdateUsers].[UserName] = [LastUpdateUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNProjects] ON [dbo].[BNIssues].[ProjectId] = [dbo].[BNProjects].[ProjectId];
GO
