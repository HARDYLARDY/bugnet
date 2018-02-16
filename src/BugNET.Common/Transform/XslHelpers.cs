namespace BugNET.Common.Transform
{
    #region Using Statements

    using BugNET.Common.Extensions;

    #endregion

    /// <summary>An XSL helpers.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public class XslHelpers
    {
        #region Public Methods

        /// <summary>Formats the boolean as yes no.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted boolean as yes no.</returns>
        public string FormatBooleanAsYesNo(string value)
        {
            return value.FormatBooleanAsYesNo();
        }

        /// <summary>Formats the quantity.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <param name="showZeroValue">(Optional) The show zero value.</param>
        /// <returns>The formatted quantity.</returns>
        public string FormatQuantity(string value, string showZeroValue = "true")
        {
            return value.FormatQuantity(showZeroValue);
        }

        /// <summary>Formats the short date.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted short date.</returns>
        public string FormatShortDate(string value)
        {
            return value.FormatShortDate();
        }

        /// <summary>Formats the short date and12 H time.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted short date and 12 h time.</returns>
        public string FormatShortDateAnd12HTime(string value)
        {
            return value.FormatShortDateAnd12HTime();
        }

        /// <summary>Formats the short date and24 H time.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted short date and 24 h time.</returns>
        public string FormatShortDateAnd24HTime(string value)
        {
            return value.FormatShortDateAnd24HTime();
        }

        /// <summary>Formats the short time.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted short time.</returns>
        public string FormatShortTime(string value)
        {
            return value.FormatShortTime();
        }

        /// <summary>Replaces the cr lf with BR.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>A string.</returns>
        public string ReplaceCrLfWithBr(string value)
        {
            return value.ReplaceCrLfWithBr();
        }

        /// <summary>Strips the HTML.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="htmlContent">Content of the HTML.</param>
        /// <returns>A string.</returns>
        public string StripHTML(string htmlContent)
        {
            return htmlContent.StripHTML();
        }

        #endregion Public Methods
    }
}