SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[BugNETTPIntegration_GetIssuesView]
(
	@LastIssueID INT,
	@ProjectId INT
)
AS

	SELECT
		BugNet_IssuesView.IssueId,
		BugNet_IssuesView.IssueTitle,
		BugNet_IssuesView.IssueDescription,
		BugNet_IssuesView.IssueStatusId,
		BugNet_IssuesView.IssuePriorityId,
		BugNet_IssuesView.IssueTypeId,
		BugNet_IssuesView.IssueCategoryId,
		BugNet_IssuesView.ProjectId,
		BugNet_IssuesView.IssueResolutionId,
		BugNet_IssuesView.IssueCreatorUserId,
		BugNet_IssuesView.IssueAssignedUserId,
		BugNet_IssuesView.IssueOwnerUserId,
		BugNet_IssuesView.IssueDueDate,
		BugNet_IssuesView.IssueMilestoneId,
		BugNet_IssuesView.IssueAffectedMilestoneId,
		BugNet_IssuesView.IssueVisibility,
		BugNet_IssuesView.IssueEstimation,
		BugNet_IssuesView.DateCreated,
		BugNet_IssuesView.LastUpdate,
		BugNet_IssuesView.LastUpdateUserId,
		BugNet_IssuesView.ProjectName,
		BugNet_IssuesView.ProjectCode,
		BugNet_IssuesView.PriorityName,
		BugNet_IssuesView.IssueTypeName,
		BugNet_IssuesView.CategoryName,
		BugNet_IssuesView.StatusName,
		BugNet_IssuesView.MilestoneName,
		BugNet_IssuesView.AffectedMilestoneName,
		BugNet_IssuesView.ResolutionName,
		BugNet_IssuesView.LastUpdateUserName,
		BugNet_IssuesView.AssignedUserName,
		BugNet_IssuesView.AssignedDisplayName,
		BugNet_IssuesView.CreatorUserName,
		BugNet_IssuesView.CreatorDisplayName,
		BugNet_IssuesView.OwnerUserName,
		BugNet_IssuesView.OwnerDisplayName,
		BugNet_IssuesView.LastUpdateDisplayName,
		BugNet_IssuesView.PriorityImageUrl,
		BugNet_IssuesView.IssueTypeImageUrl,
		BugNet_IssuesView.StatusImageUrl,
		BugNet_IssuesView.MilestoneImageUrl,
		BugNet_IssuesView.ResolutionImageUrl,
		BugNet_IssuesView.AffectedMilestoneImageUrl,
		BugNet_IssuesView.TimeLogged,
		BugNet_IssuesView.IssueVotes,
		BugNet_IssuesView.Disabled,
		BugNet_IssuesView.IssueProgress,
		BugNet_IssuesView.MilestoneDueDate,
		BugNet_IssuesView.ProjectDisabled,
		BugNet_IssuesView.IsClosed,
		BugNet_IssuesView.LastUpdateAsDate,
		BugNet_IssuesView.DateCreatedAsDate
	FROM
		[dbo].[BugNet_IssuesView]
	WHERE	
		BugNet_IssuesView.ProjectId = @ProjectId
		AND BugNet_IssuesView.IssueId > @LastIssueID
		AND BugNet_IssuesView.Disabled = 0
	ORDER BY
		BugNet_IssuesView.IssueId;

GO
GRANT EXECUTE ON  [dbo].[BugNETTPIntegration_GetIssuesView] TO [BugNetUser]
GO
