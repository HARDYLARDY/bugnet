namespace BugNET.Common
{
    #region Using Statements

    using BugNET.Common.Enums;
    using BugNET.Common.Model;

    #endregion

    /// <summary>The action event handler.</summary>
    /// <param name="sender">The sender.</param>
    /// <param name="arguements">The args.</param>
    public delegate void ActionEvent(object sender, ActionEventArguements arguements);

    /// <summary>
    ///     Global constants, enumerations and properties
    /// </summary>
    public static class Globals
    {
        #region Public Fields

        /// <summary>Pathname of the configuration folder.</summary>
        public const string ConfigFolder = "\\Config\\";

        /// <summary>The default length of short comments (if not specified).</summary>
        public const int DefaultshortCommentLength = 100;

        /// <summary>The issue columns.</summary>
        public const string IssueColumns = "issuecolumns";

        /// <summary>Identifier for the new.</summary>
        public const int NewID = 0;

        /// <summary>The project custom fields prefix.</summary>
        public const string ProjectCustomFieldsPrefix = "bgn_cf_";

        /// <summary>Name of the project custom fields view.</summary>
        public const string ProjectCustomFieldsViewName = "BugNet_P{0}_CFV";

        /// <summary>The skip project intro.</summary>
        public const string SkipProjectIntro = "skipprojectintro";

        /// <summary>The super user role.</summary>
        public const string SuperUserRole = "Super Users";

        /// <summary>The unassigned display text.</summary>
        public const string UnassignedDisplayText = "none";

        /// <summary>The upload folder limit.</summary>
        public const int UploadFolderLimit = 64;

        /// <summary>The upload token.</summary>
        public const string UploadToken = "UploadToken";

        /// <summary>The user cookie.</summary>
        public const string UserCookie = "BugNETUser";

        /// <summary>The user custom fields prefix.</summary>
        public const string UserCustomFieldsPrefix = "bgn_ucf_";

        /// <summary>Name of the user custom fields view.</summary>
        public const string UserCustomFieldsViewName = "BugNet_USER_CFV";

        /// <summary>Default project administrator role permissions.</summary>
        public static readonly int[] AdministratorPermissions =
            {
                (int)BugNETPermissionTypes.AddIssue, (int)BugNETPermissionTypes.AddComment, (int)BugNETPermissionTypes.AddAttachment, (int)BugNETPermissionTypes.AddRelated, (int)BugNETPermissionTypes.AddTimeEntry,
                (int)BugNETPermissionTypes.AddParentIssue, (int)BugNETPermissionTypes.AddSubIssue, (int)BugNETPermissionTypes.AddQuery, (int)BugNETPermissionTypes.OwnerEditComment,
                (int)BugNETPermissionTypes.SubscribeIssue, (int)BugNETPermissionTypes.EditIssue, (int)BugNETPermissionTypes.EditComment, (int)BugNETPermissionTypes.EditIssueDescription,
                (int)BugNETPermissionTypes.EditIssueTitle, (int)BugNETPermissionTypes.EditQuery, (int)BugNETPermissionTypes.DeleteQuery, (int)BugNETPermissionTypes.DeleteAttachment,
                (int)BugNETPermissionTypes.DeleteComment, (int)BugNETPermissionTypes.DeleteIssue, (int)BugNETPermissionTypes.DeleteRelated, (int)BugNETPermissionTypes.DeleteTimeEntry,
                (int)BugNETPermissionTypes.DeleteQuery, (int)BugNETPermissionTypes.DeleteSubIssue, (int)BugNETPermissionTypes.DeleteParentIssue, (int)BugNETPermissionTypes.AssignIssue,
                (int)BugNETPermissionTypes.CloseIssue, (int)BugNETPermissionTypes.AdminEditProject, (int)BugNETPermissionTypes.ChangeIssueStatus, (int)BugNETPermissionTypes.ReopenIssue
            };

        /// <summary>The default roles.</summary>
        public static readonly string[] DefaultRoles = { "Project Administrators", "Read Only", "Reporter", "Developer", "Quality Assurance" };

        /// <summary>Default developer role permissions.</summary>
        public static readonly int[] DeveloperPermissions =
            {
                (int)BugNETPermissionTypes.AddIssue, (int)BugNETPermissionTypes.AddComment, (int)BugNETPermissionTypes.AddAttachment, (int)BugNETPermissionTypes.AddRelated, (int)BugNETPermissionTypes.AddTimeEntry,
                (int)BugNETPermissionTypes.AddParentIssue, (int)BugNETPermissionTypes.AddSubIssue, (int)BugNETPermissionTypes.AddQuery, (int)BugNETPermissionTypes.OwnerEditComment,
                (int)BugNETPermissionTypes.SubscribeIssue, (int)BugNETPermissionTypes.EditIssue, (int)BugNETPermissionTypes.AssignIssue, (int)BugNETPermissionTypes.ChangeIssueStatus
            };

        /// <summary>The project admin role.</summary>
        public static readonly string ProjectAdminRole = DefaultRoles[0];

        /// <summary>Default QA role permissions.</summary>
        public static readonly int[] QualityAssurancePermissions =
            {
                (int)BugNETPermissionTypes.AddIssue, (int)BugNETPermissionTypes.AddComment, (int)BugNETPermissionTypes.AddAttachment, (int)BugNETPermissionTypes.AddRelated, (int)BugNETPermissionTypes.AddTimeEntry,
                (int)BugNETPermissionTypes.AddParentIssue, (int)BugNETPermissionTypes.AddSubIssue, (int)BugNETPermissionTypes.AddQuery, (int)BugNETPermissionTypes.OwnerEditComment,
                (int)BugNETPermissionTypes.SubscribeIssue, (int)BugNETPermissionTypes.EditIssue, (int)BugNETPermissionTypes.EditIssueTitle, (int)BugNETPermissionTypes.AssignIssue,
                (int)BugNETPermissionTypes.CloseIssue, (int)BugNETPermissionTypes.DeleteIssue, (int)BugNETPermissionTypes.ChangeIssueStatus
            };

        /// <summary>Default read only role permissions.</summary>
        public static readonly int[] ReadOnlyPermissions = { (int)BugNETPermissionTypes.SubscribeIssue };

        /// <summary>Default reporter role permissions.</summary>
        public static readonly int[] ReporterPermissions =
            {
                (int)BugNETPermissionTypes.AddIssue, (int)BugNETPermissionTypes.AddComment, (int)BugNETPermissionTypes.OwnerEditComment, (int)BugNETPermissionTypes.SubscribeIssue,
                (int)BugNETPermissionTypes.AddAttachment, (int)BugNETPermissionTypes.AddRelated, (int)BugNETPermissionTypes.AddParentIssue, (int)BugNETPermissionTypes.AddSubIssue
            };

        #endregion Public Fields
    }
}