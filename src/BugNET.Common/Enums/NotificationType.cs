namespace BugNET.Common.Enums
{
    /// <summary>Values that represent notification types.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public enum NotificationType
    {
        /// <summary>An enum constant representing the unknown option.</summary>
        Unknown = 0,

        /// <summary>
        /// Issue update email
        /// </summary>
        BugUpdate = 1,

        /// <summary>
        /// Assigned to new user email
        /// </summary>
        BugAssignedToNewUser,

        /// <summary>
        /// New user registered email
        /// </summary>
        NewUserRegistered
    }
}
