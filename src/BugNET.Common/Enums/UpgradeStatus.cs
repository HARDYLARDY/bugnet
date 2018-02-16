namespace BugNET.Common.Enums
{
    /// Only FlagsAttribute enums should have plural names
    /// <summary>Upgrade Status Enumeration.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
#pragma warning disable CA1717
    public enum UpgradeStatus
#pragma warning restore CA1717 // Only FlagsAttribute enums should have plural names
    {
        /// <summary>An enum constant representing the upgrade option.</summary>
        Upgrade = 0,

        /// <summary>An enum constant representing the install option.</summary>
        Install = 1,

        /// <summary>An enum constant representing the none option.</summary>
        None = 2,

        /// <summary>An enum constant representing the authenticated option.</summary>
        Authenticated = 3
    }
}