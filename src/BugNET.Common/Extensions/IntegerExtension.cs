namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.Globalization;

    #endregion

    /// <summary>An integer extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class IntegerExtension
    {
        #region Public Methods

        /// <summary>An int extension method that converts an input to a bool.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="input">The input to act on.</param>
        /// <returns>Input as a bool.</returns>
        public static bool ToBool(this int input)
        {
            return input.Equals(1);
        }

        /// <summary>Parses a string into an Enum.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">The type of the Enum.</typeparam>
        /// <param name="value">String value to parse.</param>
        /// <param name="defaultValue">The default value if the int cannot be cast to the typeparam.</param>
        /// <param name="numberStyles">(Optional) Number of styles.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        /// <returns>The Enum corresponding to the stringExtensions.</returns>
        public static T ToEnum<T>(this int value, T defaultValue, NumberStyles numberStyles = NumberStyles.Any, IFormatProvider formatProvider = null)
        {
            formatProvider = formatProvider ?? CultureInfo.InvariantCulture;

            if (!int.TryParse(value.ToString(formatProvider), numberStyles, formatProvider, out int num))
            {
                return defaultValue;
            }

            if (Enum.IsDefined(typeof(T), num))
            {
                return (T)Enum.ToObject(typeof(T), num);
            }

            return defaultValue;
        }

        #endregion Public Methods
    }
}