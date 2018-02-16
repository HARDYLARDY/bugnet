namespace BugNET.Common.Enums
{
    /// <summary>Values that represent BugNET permission types.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    [System.Flags]
    public enum BugNETPermissionTypes
    {
        /// <summary>An enum constant representing the none option.</summary>
        None = 0,

        /// <summary>An enum constant representing the close issue option.</summary>
        CloseIssue = 1,

        /// <summary>An enum constant representing the add issue option.</summary>
        AddIssue = 2,

        /// <summary>An enum constant representing the assign issue option.</summary>
        AssignIssue = 3,

        /// <summary>An enum constant representing the edit issue option.</summary>
        EditIssue = 4,

        /// <summary>An enum constant representing the subscribe issue option.</summary>
        SubscribeIssue = 5,

        /// <summary>An enum constant representing the delete issue option.</summary>
        DeleteIssue = 6,

        /// <summary>An enum constant representing the add comment option.</summary>
        AddComment = 7,

        /// <summary>An enum constant representing the edit comment option.</summary>
        EditComment = 8,

        /// <summary>An enum constant representing the delete comment option.</summary>
        DeleteComment = 9,

        /// <summary>An enum constant representing the add attachment option.</summary>
        AddAttachment = 10,

        /// <summary>An enum constant representing the delete attachment option.</summary>
        DeleteAttachment = 11,

        /// <summary>An enum constant representing the add related option.</summary>
        AddRelated = 12,

        /// <summary>An enum constant representing the delete related option.</summary>
        DeleteRelated = 13,

        /// <summary>An enum constant representing the reopen issue option.</summary>
        ReopenIssue = 14,

        /// <summary>An enum constant representing the owner edit comment option.</summary>
        OwnerEditComment = 15,

        /// <summary>An enum constant representing the edit issue description option.</summary>
        EditIssueDescription = 16,

        /// <summary>An enum constant representing the edit issue title option.</summary>
        EditIssueTitle = 17,

        /// <summary>An enum constant representing the admin edit project option.</summary>
        AdminEditProject = 18,

        /// <summary>An enum constant representing the add time entry option.</summary>
        AddTimeEntry = 19,

        /// <summary>An enum constant representing the delete time entry option.</summary>
        DeleteTimeEntry = 20,

        /// <summary>An enum constant representing the admin create project option.</summary>
        AdminCreateProject = 21,

        /// <summary>An enum constant representing the add query option.</summary>
        AddQuery = 22,

        /// <summary>An enum constant representing the delete query option.</summary>
        DeleteQuery = 23,

        /// <summary>An enum constant representing the admin clone project option.</summary>
        AdminCloneProject = 24,

        /// <summary>An enum constant representing the add sub issue option.</summary>
        AddSubIssue = 25,

        /// <summary>An enum constant representing the delete sub issue option.</summary>
        DeleteSubIssue = 26,

        /// <summary>An enum constant representing the add parent issue option.</summary>
        AddParentIssue = 27,

        /// <summary>An enum constant representing the delete parent issue option.</summary>
        DeleteParentIssue = 28,

        /// <summary>An enum constant representing the admin delete project option.</summary>
        AdminDeleteProject = 29,

        /// <summary>An enum constant representing the change issue status option.</summary>
        ChangeIssueStatus = 31,

        /// <summary>An enum constant representing the edit query option.</summary>
        EditQuery = 32
    }
}