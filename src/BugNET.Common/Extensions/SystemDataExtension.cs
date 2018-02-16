namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.Data;

    #endregion

    /// <summary>A system data.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class SystemDataExtension
    {
        #region Public Methods

        /// <summary>Extension method for checking if a DataReader has a specific column in the results.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="dr">The IDataReader interface instance.</param>
        /// <param name="columnName">The column name.</param>
        /// <returns>True if column, false if not.</returns>
        public static bool HasColumn(this IDataRecord dr, string columnName)
        {
            for (var i = 0; i < dr.FieldCount; i++)
            {
                if (dr.GetName(i).Equals(columnName, StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
            }

            return false;
        }

        #endregion Public Methods
    }
}