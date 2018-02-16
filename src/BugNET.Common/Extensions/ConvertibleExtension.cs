namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.Globalization;

    #endregion

    /// <summary>A convertible extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class ConvertibleExtension
    {
        #region Public Methods

        /// <summary>An IConvertible extension method that toes the given object.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="value">The value to act on.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        /// <returns>A T.</returns>
        public static T To<T>(this IConvertible value, IFormatProvider formatProvider = null)
        {
            Type t = typeof(T);

            if (!t.IsGenericType || (t.GetGenericTypeDefinition() != typeof(Nullable<>)))
            {
                return (T)Convert.ChangeType(value, t, formatProvider ?? CultureInfo.CurrentCulture);
            }

            if (value == null)
            {
                return (T)(object)null;
            }

            return (T)Convert.ChangeType(value, Nullable.GetUnderlyingType(t), formatProvider ?? CultureInfo.CurrentCulture);
        }

        /// <summary>An IConvertible extension method that converts this object to an or default.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="value">The value to act on.</param>
        /// <param name="defaultValue">The default value.</param>
        /// <returns>The given data converted to a T.</returns>
        public static T ToOrDefault<T>(this IConvertible value, T defaultValue)
        {
            try
            {
                return To<T>(value);
            }
            catch
            {
                return defaultValue;
            }
        }

        #endregion Public Methods
    }
}