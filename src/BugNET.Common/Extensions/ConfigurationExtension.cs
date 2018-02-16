namespace BugNET.Common.Extensions
{
    #region Using Statements

    using BugNET.Common.Enums;

    using Microsoft.Extensions.Configuration;

    #endregion

    /// <summary>A configuration extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class ConfigurationExtension
    {
        #region Public Methods

        /// <summary>An IConfiguration extension method that gets value from key.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="configuration">The configuration to act on.</param>
        /// <param name="key">The key.</param>
        /// <param name="defaultValue">The default value.</param>
        /// <returns>The value from key.</returns>
        public static string GetValueFromKey(this IConfiguration configuration, AppSettingKey key, string defaultValue)
        {
            return configuration.GetValue(key.ToString(), defaultValue);
        }

        #endregion Public Methods
    }
}