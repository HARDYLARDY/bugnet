namespace BugNET.Common.Enums
{
    /// <summary>Status codes from the database when validating an attachment.</summary>
    /// <remarks>When using a valid attachment id would be returned from the database so this enum would not mat properly.</remarks>
    public enum DownloadAttachmentStatusCode
    {
        /// <summary>An enum constant representing the unknown option.</summary>
        Unknown = 0,

        /// <summary>An enum constant representing the invalid attachment Identifier option.</summary>
        InvalidAttachmentId = 100,

        /// <summary>An enum constant representing the authentication required option.</summary>
        AuthenticationRequired = 200,

        /// <summary>An enum constant representing the project or issue disabled option.</summary>
        ProjectOrIssueDisabled = 300,

        /// <summary>An enum constant representing the no access option.</summary>
        NoAccess = 400
    }
}