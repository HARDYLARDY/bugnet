namespace BugNET.Common.Utilities
{
    #region Using Statements

    using System;
    using System.Data;
    using System.Globalization;
    using System.IO;
    using System.Text.RegularExpressions;

    using BugNET.Common.Enums;
    using BugNET.Common.Extensions;

    using Microsoft.Extensions.Localization;

    #endregion

    /// <summary>An utilities.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class Misc
    {
        #region Public Methods

        /// <summary>This checks the Project upload path within the context of the BugNET application. Plugs numerous security holes. BGN-1909 BGN-1905 BGN-1904.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="path">Full pathname of the file.</param>
        /// <returns>True if it succeeds, false if it fails.</returns>
        public static bool CheckUploadPath(string path)
        {
            var isPathNorty = false;
            string tmpPath = path; // dont even trim it!

            // BGN-1904
            // Check the length of the upload path
            // 64 characters are allows
            if (tmpPath.Length > Globals.UploadFolderLimit)
            {
                isPathNorty = true;
            }

            // Now check for funny characters but there is a slight problem.

            // The string paths are "~\Uploads\Project1\"
            // The "\\" is seen as a UNC path and marked invalid
            // However our encoding defines a UNC path as "\\"
            // So we have to do some magic first

            // Reject any UNC paths
            isPathNorty |= tmpPath.Contains(@"\\");

            // Reject attempts to traverse directories
            isPathNorty |= tmpPath.Contains(@"\..") || tmpPath.Contains(@"..\") || tmpPath.Contains(@"\.\");

            // Now that there are just folders left, remove the "\" character
            tmpPath = tmpPath.Replace(@"\", " ", StringComparison.OrdinalIgnoreCase);

            // check for illegal filename characters
            isPathNorty |= tmpPath.IndexOfAny(Path.GetInvalidFileNameChars()) != -1;

            // Return the opposite of norty
            return !isPathNorty;
        }

        /// <summary>Estimations to string.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="localizer">The localizer.</param>
        /// <param name="estimation">The estimation.</param>
        /// <param name="cultureInfo">(Optional) The format provider.</param>
        /// <returns>A string.</returns>
        public static string EstimationToString<T>(IStringLocalizer<T> localizer, decimal estimation, CultureInfo cultureInfo = null)
        {
            CultureInfo provider = cultureInfo ?? CultureInfo.InvariantCulture;

            return estimation >= 0 ? estimation.ToString(provider) : localizer["Empty", "-"].Value.ToLower(provider);
        }

        /// <summary>Gets the boolean as string.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="localizer">The localizer.</param>
        /// <param name="value">if set to <c>true</c> [value].</param>
        /// <returns>The boolean as string.</returns>
        public static string GetBooleanAsString<T>(IStringLocalizer<T> localizer, bool value)
        {
            string boolString = value ? bool.TrueString : bool.FalseString;

            return localizer[boolString].Value;
        }

        /// <summary>Validates an string for a valid email.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="email">The string to validate.</param>
        /// <returns>True if valid email, false if not.</returns>
        public static bool IsValidEmail(string email)
        {
            var validator = new IsEMail();

            return validator.IsEmailValid(email);
        }

        /// <summary>Parses a BugNet status code from a database raise error exception.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="errorMessage">The error message from the database.</param>
        /// <returns>An int.</returns>
        public static int ParseDatabaseStatusCode(string errorMessage)
        {
            if (!errorMessage.StartsWith("BNCode", StringComparison.OrdinalIgnoreCase))
            {
                return 0;
            }

            // at this point we have a code so we have to parse it out
            string[] parts = errorMessage.Split(' ');

            if (parts.Length > 0)
            {
                string[] statusCodeParts = parts[0].Split(':');

                if (statusCodeParts.Length.Equals(2))
                {
                    string statusCode = statusCodeParts[1];

                    // if we cannot convert the code to a proper status code then do the safe thing and not allow access
                    return statusCode.ToOrDefault(DownloadAttachmentStatusCode.NoAccess.To<int>());
                }
            }

            // if we cannot parse the code out then do the safe thing and not allow access
            return DownloadAttachmentStatusCode.NoAccess.To<int>();
        }

        /// <summary>Parses the full issue id.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="fullId">The full id.</param>
        /// <returns>An int.</returns>
        public static int ParseFullIssueId(string fullId)
        {
            int lastDashPos = fullId.LastIndexOf("-", StringComparison.InvariantCultureIgnoreCase);

            if (lastDashPos > 0)
            {
                fullId = fullId.Substring(lastDashPos + 1);
            }

            return fullId.ToOrDefault(-1);
        }

        /// <summary>
        ///     Strips the HTML. BGN-1732 This should be in a helper classer From
        ///     http://www.codeproject.com/Articles/68222/Strip-HTML-Tags-from-Text.aspx Copyright Raymund Macaalay |
        ///     25 Mar 2010 http://nz.linkedin.com/in/macaalay http://anyrest.wordpress.com/.
        /// </summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="inputString">The s input string.</param>
        /// <returns>A string.</returns>
        public static string StripHTML(string inputString)
        {
            try
            {
                string outputString = inputString;

                // Initial Cleaning Step
                // Replace new line and carriage return with Spaces
                outputString = outputString.Replace("\r", " ", StringComparison.OrdinalIgnoreCase);
                outputString = outputString.Replace("\n", " ", StringComparison.OrdinalIgnoreCase);

                // Remove sTabs
                outputString = outputString.Replace("\t", string.Empty, StringComparison.OrdinalIgnoreCase);

                // Tag Removal
                DataTable dataTable = GetTableDefinition();

                dataTable.DefaultView.Sort = "iID ASC";

                foreach (DataRow cleaningItem in dataTable.Rows)
                {
                    string originalString = cleaningItem["sOriginalString"].ToString();
                    string replacementString = cleaningItem["sReplacementString"].ToString();

                    outputString = Regex.Replace(outputString, originalString, replacementString, RegexOptions.IgnoreCase);
                }

                // Initial replacement target string for linebreaks
                var breaks = "\r\r\r";

                // Initial replacement target string for sTabs
                var tabs = "\t\t\t\t\t";

                for (var x = 0; x < outputString.Length; x++)
                {
                    outputString = outputString.Replace(breaks, "\r\r", StringComparison.OrdinalIgnoreCase);
                    outputString = outputString.Replace(tabs, "\t\t\t\t", StringComparison.OrdinalIgnoreCase);
                    breaks = breaks + "\r";
                    tabs = tabs + "\t";
                }

                return outputString;
            }
            catch
            {
                return inputString;
            }
        }

        #endregion Public Methods

        #region Private Methods

        /// <summary>
        ///     Gets the table definition. BGN-1732 Needs System.Data :( This should be in a helper classer From http://www.codeproject.com/Articles/68222/Strip-HTML-Tags-from-Text.aspx
        ///     Copyright Raymund Macaalay | 25 Mar 2010 http://nz.linkedin.com/in/macaalay http://anyrest.wordpress.com/.
        /// </summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <returns>The table definition.</returns>
        private static DataTable GetTableDefinition()
        {
            var cleaningCollection = new DataTable();

            cleaningCollection.Columns.Add("iID", typeof(int));
            cleaningCollection.Columns.Add("sOriginalString", typeof(string));
            cleaningCollection.Columns.Add("sReplacementString", typeof(string));

            // Replace repeating spaces with single space
            cleaningCollection.Rows.Add(1, "( )+", " ");

            // Prepare and clean Header Tag
            cleaningCollection.Rows.Add(2, "<( )*head([^>])*>", "<head>");
            cleaningCollection.Rows.Add(3, "(<( )*(/)( )*head( )*>)", "</head>");
            cleaningCollection.Rows.Add(4, "(<head>).*(</head>)", string.Empty);

            // Prepare and clean Script Tag
            cleaningCollection.Rows.Add(5, "<( )*script([^>])*>", "<script>");
            cleaningCollection.Rows.Add(6, "(<( )*(/)( )*script( )*>)", "</script>");
            cleaningCollection.Rows.Add(7, "(<script>).*(</script>)", string.Empty);

            // Prepare and clean Style Tag
            cleaningCollection.Rows.Add(8, "<( )*style([^>])*>", "<style>");
            cleaningCollection.Rows.Add(9, "(<( )*(/)( )*style( )*>)", "</style>");
            cleaningCollection.Rows.Add(10, "(<style>).*(</style>)", string.Empty);

            // Replace <td> with sTabs
            cleaningCollection.Rows.Add(11, "<( )*td([^>])*>", "\t");

            // Replace <BR> and <LI> with Line sBreaks
            cleaningCollection.Rows.Add(12, "<( )*br( )*>", "\r");
            cleaningCollection.Rows.Add(13, "<( )*li( )*>", "\r");

            // Replace <P>, <DIV> and <TR> with Double Line sBreaks
            cleaningCollection.Rows.Add(14, "<( )*div([^>])*>", "\r\r");
            cleaningCollection.Rows.Add(15, "<( )*tr([^>])*>", "\r\r");
            cleaningCollection.Rows.Add(16, "<( )*p([^>])*>", "\r\r");

            // Remove Remaining tags enclosed in < >
            cleaningCollection.Rows.Add(17, "<[^>]*>", string.Empty);

            // Replace special characters:
            cleaningCollection.Rows.Add(18, " ", " ");
            cleaningCollection.Rows.Add(19, "&bull;", " * ");
            cleaningCollection.Rows.Add(20, "&lsaquo;", "<");
            cleaningCollection.Rows.Add(21, "&rsaquo;", ">");
            cleaningCollection.Rows.Add(22, "&trade;", "(tm)");
            cleaningCollection.Rows.Add(23, "&frasl;", "/");
            cleaningCollection.Rows.Add(24, "&lt;", "<");
            cleaningCollection.Rows.Add(25, "&gt;", ">");
            cleaningCollection.Rows.Add(26, "&copy;", "(c)");
            cleaningCollection.Rows.Add(27, "&reg;", "(r)");
            cleaningCollection.Rows.Add(28, "&frac14;", "1/4");
            cleaningCollection.Rows.Add(29, "&frac12;", "1/2");
            cleaningCollection.Rows.Add(30, "&frac34;", "3/4");
            cleaningCollection.Rows.Add(31, "&lsquo;", "'");
            cleaningCollection.Rows.Add(32, "&rsquo;", "'");
            cleaningCollection.Rows.Add(33, "&ldquo;", "\"");
            cleaningCollection.Rows.Add(34, "&rdquo;", "\"");

            // Remove all others remianing special characters
            // you dont want to replace with another string
            cleaningCollection.Rows.Add(35, "&(.{2,6});", string.Empty);

            // Remove extra line sBreaks and sTabs
            cleaningCollection.Rows.Add(36, "(\r)( )+(\r)", "\r\r");
            cleaningCollection.Rows.Add(37, "(\t)( )+(\t)", "\t\t");
            cleaningCollection.Rows.Add(38, "(\t)( )+(\r)", "\t\r");
            cleaningCollection.Rows.Add(39, "(\r)( )+(\t)", "\r\t");
            cleaningCollection.Rows.Add(40, "(\r)(\t)+(\r)", "\r\r");
            cleaningCollection.Rows.Add(41, "(\r)(\t)+", "\r\t");

            return cleaningCollection;
        }

        #endregion Private Methods
    }
}