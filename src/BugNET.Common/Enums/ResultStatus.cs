namespace BugNET.Common
{
    /// <summary>Values that represent result status.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
#pragma warning disable CA1717 // Only FlagsAttribute enums should have plural names
    public enum ResultStatus
#pragma warning restore CA1717 // Only FlagsAttribute enums should have plural names
    {
        /// <summary>An enum constant representing the none option.</summary>
        None,

        /// <summary>An enum constant representing the success option.</summary>
        Success,

        /// <summary>An enum constant representing the failed option.</summary>
        Failed,

        /// <summary>An enum constant representing the failed with exception option.</summary>
        FailedWithException
    }
}
