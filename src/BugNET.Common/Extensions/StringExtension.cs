namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System;
    using System.ComponentModel;
    using System.Globalization;
    using System.Text;
    using System.Text.RegularExpressions;

    #endregion

    /// <summary>A string extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class StringExtension
    {
        #region Public Methods

        /// <summary>A string extension method that is the given input.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="input">The input to act on.</param>
        /// <returns>True if it succeeds, false if it fails.</returns>
        public static bool Is<T>(this string input)
            where T : IConvertible
        {
            if (string.IsNullOrEmpty(input))
            {
                return false;
            }

            TypeConverter conv = TypeDescriptor.GetConverter(typeof(T));

            if (!conv.CanConvertFrom(typeof(string)))
            {
                return false;
            }

            try
            {
                conv.ConvertFrom(input);

                return true;
            }
#pragma warning disable RECS0022 // A catch clause that catches System.Exception and has an empty body
            catch (Exception)
#pragma warning restore RECS0022 // A catch clause that catches System.Exception and has an empty body
            {
                /* hacky yes but the only way to deal with the type converter not being to convert the type*/
            }

            return false;
        }

        /// <summary>A string extension method that format short date and 24 h time.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value to act on.</param>
        /// <returns>The formatted short date and 24 h time.</returns>
        public static string FormatShortDateAnd24HTime(this string value)
        {
            if (!DateTime.TryParse(value, out DateTime dt))
            {
                return string.Empty;
            }

            return dt.Date.Year > 1968 ? dt.ToString("yyyy-MM-dd HH:mm", CultureInfo.CurrentCulture) : string.Empty;
        }

        /// <summary>A string extension method that format short date and 12 h time.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value to act on.</param>
        /// <returns>The formatted short date and 12 h time.</returns>
        public static string FormatShortDateAnd12HTime(this string value)
        {
            if (!DateTime.TryParse(value, out DateTime dt))
            {
                return string.Empty;
            }

            return dt.Date.Year > 1968 ? dt.ToString("yyyy-MM-dd hh:mm tt", CultureInfo.CurrentCulture) : string.Empty;
        }

        /// <summary>A string extension method that format short date.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value to act on.</param>
        /// <returns>The formatted short date.</returns>
        public static string FormatShortDate(this string value)
        {
            if (!DateTime.TryParse(value, out DateTime dt))
            {
                return string.Empty;
            }

            return dt.Date.Year > 1968 ? dt.ToShortDateString() : string.Empty;
        }

        /// <summary>Formats the short time.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted short time.</returns>
        public static string FormatShortTime(this string value)
        {
            if (!DateTime.TryParse(value, out DateTime dt))
            {
                return string.Empty;
            }

            return dt.Date.Year > 1968 ? dt.ToShortTimeString() : string.Empty;
        }

        /// <summary>Formats the quantity.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <param name="showZeroValue">(Optional) The show zero value.</param>
        /// <returns>The formatted quantity.</returns>
        public static string FormatQuantity(this string value, string showZeroValue = "true")
        {
#pragma warning disable RECS0093 // Convert 'if' to '&&' expression
            if (bool.TryParse(showZeroValue, out bool show))
#pragma warning restore RECS0093 // Convert 'if' to '&&' expression
            {
                show = false;
            }

            if (!decimal.TryParse(value, out decimal d))
            {
                return string.Empty;
            }

            if (show)
            {
                return d.ToString("###,##0", CultureInfo.CurrentCulture);
            }

            return d == 0m ? string.Empty : d.ToString("###,##0", CultureInfo.CurrentCulture);
        }

        /// <summary>Formats the boolean as yes no.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>The formatted boolean as yes no.</returns>
        public static string FormatBooleanAsYesNo(this string value)
        {
            return value.ToUpperInvariant().Equals("TRUE", StringComparison.OrdinalIgnoreCase) ? "Yes" : "No";
        }

        /// <summary>Replaces the cr lf with BR.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>A string.</returns>
        public static string ReplaceCrLfWithBr(this string value)
        {
            return !string.IsNullOrEmpty(value) ? value.Replace("\r\n", "<br/>", StringComparison.CurrentCultureIgnoreCase) : value;
        }

        /// <summary>
        ///     Strips the HTML from a string used for text only notifications.
        ///     http://www.codeproject.com/KB/HTML/HTML_to_Plain_Text.aspx?display=Print.
        /// </summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value.</param>
        /// <returns>A string.</returns>
        public static string StripHTML(this string value)
        {
            try
            {
                // Remove HTML Development formatting
                // Replace line breaks with space
                // because browsers inserts space
                string result = value.Replace("\r", " ", StringComparison.CurrentCultureIgnoreCase);

                // Replace line breaks with space
                // because browsers inserts space
                result = result.Replace("\n", " ", StringComparison.CurrentCultureIgnoreCase);

                // Remove step-formatting
                result = result.Replace("\t", string.Empty, StringComparison.CurrentCultureIgnoreCase);

                // Remove repeating spaces because browsers ignore them
                result = Regex.Replace(result, @"( )+", " ");

                // Remove the header (prepare first by clearing attributes)
                result = Regex.Replace(result, @"<( )*head([^>])*>", "<head>", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"(<( )*(/)( )*head( )*>)", "</head>", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, "(<head>).*(</head>)", string.Empty, RegexOptions.IgnoreCase);

                // remove all scripts (prepare first by clearing attributes)
                result = Regex.Replace(result, @"<( )*script([^>])*>", "<script>", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"(<( )*(/)( )*script( )*>)", "</script>", RegexOptions.IgnoreCase);

                result = Regex.Replace(result, @"(<script>).*(</script>)", string.Empty, RegexOptions.IgnoreCase);

                // remove all styles (prepare first by clearing attributes)
                result = Regex.Replace(result, @"<( )*style([^>])*>", "<style>", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"(<( )*(/)( )*style( )*>)", "</style>", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, "(<style>).*(</style>)", string.Empty, RegexOptions.IgnoreCase);

                // insert tabs in spaces of <td> tags
                result = Regex.Replace(result, @"<( )*td([^>])*>", "\t", RegexOptions.IgnoreCase);

                // insert line breaks in places of <BR> and <LI> tags
                result = Regex.Replace(result, @"<( )*br( )*>", "\r", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"<( )*li( )*>", "\r", RegexOptions.IgnoreCase);

                // insert line paragraphs (double line breaks) in place
                // if <P>, <DIV> and <TR> tags
                result = Regex.Replace(result, @"<( )*div([^>])*>", "\r\r", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"<( )*tr([^>])*>", "\r\r", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"<( )*p([^>])*>", "\r\r", RegexOptions.IgnoreCase);

                // Remove remaining tags like <a>, links, images,
                // comments etc - anything that's enclosed inside < >
                result = Regex.Replace(result, @"<[^>]*>", string.Empty, RegexOptions.IgnoreCase);

                // replace special characters:
                result = Regex.Replace(result, @" ", " ", RegexOptions.IgnoreCase);

                result = Regex.Replace(result, @"&bull;", " * ", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&lsaquo;", "<", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&rsaquo;", ">", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&trade;", "(tm)", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&frasl;", "/", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&lt;", "<", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&gt;", ">", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&copy;", "(c)", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, @"&reg;", "(r)", RegexOptions.IgnoreCase);

                // Remove all others. More can be added, see
                // http://hotwired.lycos.com/webmonkey/reference/special_characters/
                result = Regex.Replace(result, @"&(.{2,6});", string.Empty, RegexOptions.IgnoreCase);

                // make line breaking consistent
                result = result.Replace("\n", "\r", StringComparison.CurrentCultureIgnoreCase);

                // Remove extra line breaks and tabs:
                // replace over 2 breaks with 2 and over 4 tabs with 4.
                // Prepare first to remove any whitespaces in between
                // the escaped characters and remove redundant tabs in between line breaks
                result = Regex.Replace(result, "(\r)( )+(\r)", "\r\r", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, "(\t)( )+(\t)", "\t\t", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, "(\t)( )+(\r)", "\t\r", RegexOptions.IgnoreCase);
                result = Regex.Replace(result, "(\r)( )+(\t)", "\r\t", RegexOptions.IgnoreCase);

                // Remove redundant tabs
                result = Regex.Replace(result, "(\r)(\t)+(\r)", "\r\r", RegexOptions.IgnoreCase);

                // Remove multiple tabs following a line break with just one tab
                result = Regex.Replace(result, "(\r)(\t)+", "\r\t", RegexOptions.IgnoreCase);

                // Initial replacement target string for line breaks
                var breaks = "\r\r\r";

                // Initial replacement target string for tabs
                var tabs = "\t\t\t\t\t";

                for (var index = 0; index < result.Length; index++)
                {
                    result = result.Replace(breaks, "\r\r", StringComparison.CurrentCultureIgnoreCase);
                    result = result.Replace(tabs, "\t\t\t\t", StringComparison.CurrentCultureIgnoreCase);
                    breaks = breaks + "\r";
                    tabs = tabs + "\t";
                }

                // That's it.
                return result;
            }
            catch
            {
                return value;
            }
        }

        /// <summary>
        ///     Encodes a string to be represented as a string literal. The format is essentially a JSON string. The string
        ///     returned includes outer quotes Example Output: "Hello \"Rick\
        ///     "!\r\nRock on".
        /// </summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="value">The value to act on.</param>
        /// <param name="omitQuotes">(Optional) True to omit quotes.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        /// <returns>A string.</returns>
        public static string JsEncode(this string value, bool omitQuotes = true, IFormatProvider formatProvider = null)
        {
            var sb = new StringBuilder();

            if (!omitQuotes)
            {
                sb.Append("\"");
            }

            foreach (char c in value)
            {
                switch (c)
                {
                    case '\"':
                        sb.Append("\\\"");
                        break;
                    case '\\':
                        sb.Append("\\\\");
                        break;
                    case '\b':
                        sb.Append("\\b");
                        break;
                    case '\f':
                        sb.Append("\\f");
                        break;
                    case '\n':
                        sb.Append("\\n");
                        break;
                    case '\r':
                        sb.Append("\\r");
                        break;
                    case '\t':
                        sb.Append("\\t");
                        break;
                    default:
                        int i = c;

                        if ((i < 32) || (i > 127))
                        {
                            sb.AppendFormat(formatProvider ?? CultureInfo.CurrentCulture, "\\u{0:X04}", i);
                        }
                        else
                        {
                            sb.Append(c);
                        }

                        break;
                }
            }

            if (!omitQuotes)
            {
                sb.Append("\"");
            }

            string s = sb.ToString();

            return s;
        }

        /// <summary>A string extension method that converts this object to an enum.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <exception cref="ArgumentNullException">Thrown when one or more required arguments are null.</exception>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="value">The value to act on.</param>
        /// <param name="ignorecase">True to ignorecase.</param>
        /// <param name="defaultValue">The default value.</param>
        /// <returns>The given data converted to a T.</returns>
        public static T ToEnum<T>(this string value, bool ignorecase, T defaultValue)
            where T : struct
        {
            if (value == null)
            {
                throw new ArgumentNullException(nameof(value));
            }

            return Enum.TryParse(value, ignorecase, out T result) ? result : defaultValue;
        }

        #endregion Public Methods
    }
}