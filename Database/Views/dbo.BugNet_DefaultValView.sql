SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_DefaultValView]
AS
	SELECT
		[dbo].[BNDefaultValues].[DefaultType],
		[dbo].[BNDefaultValues].[StatusId],
		[dbo].[BNDefaultValues].[IssueOwnerUserId],
		[dbo].[BNDefaultValues].[IssuePriorityId],
		[dbo].[BNDefaultValues].[IssueAffectedMilestoneId],
		[dbo].[BNDefaultValues].[ProjectId],
		ISNULL([OwnerUsers].[UserName], N'none') AS OwnerUserName,
		ISNULL([OwnerUsersProfile].[DisplayName], N'none') AS OwnerDisplayName,
		ISNULL([AssignedUsers].[UserName], N'none') AS AssignedUserName,
		ISNULL([AssignedUsersProfile].[DisplayName], N'none') AS AssignedDisplayName,
		[dbo].[BNDefaultValues].[IssueAssignedUserId],
		[dbo].[BNDefaultValues].[IssueCategoryId],
		[dbo].[BNDefaultValues].[IssueVisibility],
		[dbo].[BNDefaultValues].[IssueDueDate],
		[dbo].[BNDefaultValues].[IssueProgress],
		[dbo].[BNDefaultValues].[IssueMilestoneId],
		[dbo].[BNDefaultValues].[IssueEstimation],
		[dbo].[BNDefaultValues].[IssueResolutionId],
		[dbo].[BNDefaultValuesVisibility].[StatusVisibility],
		[dbo].[BNDefaultValuesVisibility].[PriorityVisibility],
		[dbo].[BNDefaultValuesVisibility].[OwnedByVisibility],
		[dbo].[BNDefaultValuesVisibility].[AssignedToVisibility],
		[dbo].[BNDefaultValuesVisibility].[PrivateVisibility],
		[dbo].[BNDefaultValuesVisibility].[CategoryVisibility],
		[dbo].[BNDefaultValuesVisibility].[DueDateVisibility],
		[dbo].[BNDefaultValuesVisibility].[TypeVisibility],
		[dbo].[BNDefaultValuesVisibility].[PercentCompleteVisibility],
		[dbo].[BNDefaultValuesVisibility].[MilestoneVisibility],
		[dbo].[BNDefaultValuesVisibility].[ResolutionVisibility],
		[dbo].[BNDefaultValuesVisibility].[EstimationVisibility],
		[dbo].[BNDefaultValuesVisibility].[AffectedMilestoneVisibility],
		[dbo].[BNDefaultValues].[OwnedByNotify],
		[dbo].[BNDefaultValues].[AssignedToNotify]
	FROM
		[dbo].[BNDefaultValues]
		LEFT OUTER JOIN [dbo].[Users] AS OwnerUsers ON [dbo].[BNDefaultValues].[IssueOwnerUserId] = OwnerUsers.UserId
		LEFT OUTER JOIN [dbo].[Users] AS AssignedUsers ON [dbo].[BNDefaultValues].[IssueAssignedUserId] = AssignedUsers.UserId
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS AssignedUsersProfile ON [AssignedUsers].[UserName] = [AssignedUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS OwnerUsersProfile ON [OwnerUsers].[UserName] = [OwnerUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNDefaultValuesVisibility] ON [dbo].[BNDefaultValues].[ProjectId] = [dbo].[BNDefaultValuesVisibility].[ProjectId];
GO
