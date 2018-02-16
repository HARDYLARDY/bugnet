namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.Collections.Specialized;

    #endregion

    /// <summary>A name value collection extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class NameValueCollectionExtension
    {
        #region Public Methods

        /// <summary>A NameValueCollection extension method that gets.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <exception cref="ArgumentNullException">Thrown when one or more required arguments are null.</exception>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="collection">The name value collection.</param>
        /// <param name="key">The key of the item in the collection.</param>
        /// <returns>A T.</returns>
        public static T Get<T>(this NameValueCollection collection, string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                throw new ArgumentNullException(nameof(key));
            }

            return collection[key].GetValue<T>();
        }

        /// <summary>Extension method for name value collections to get a typed value from the collection.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <exception cref="ArgumentNullException">Thrown when one or more required arguments are null.</exception>
        /// <typeparam name="T">The type to be returned.</typeparam>
        /// <param name="collection">The name value collection.</param>
        /// <param name="key">The key of the item in the collection.</param>
        /// <param name="defaultValue">The default value if the item does not exist.</param>
        /// <returns>A T.</returns>
        public static T Get<T>(this NameValueCollection collection, string key, T defaultValue)
        {
            if (string.IsNullOrEmpty(key))
            {
                throw new ArgumentNullException(nameof(key));
            }

            return collection[key].GetValue(defaultValue);
        }

        #endregion Public Methods
    }
}