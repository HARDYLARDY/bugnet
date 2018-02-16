namespace BugNET.Tests.TestCommon
{
    /// <summary>An XML class test.</summary>
    /// <remarks>Rob Moloney, 14/02/2018.</remarks>
    public class XmlClassTest
    {
        #region Public Properties

        /// <summary>Gets or sets the decimal value.</summary>
        /// <value>The decimal value.</value>
        public decimal DecimalValue { get; set; }

        /// <summary>Gets or sets the stringl value.</summary>
        /// <value>The stringl value.</value>
        public string StringlValue { get; set; }

        #endregion Public Properties

        #region Public Methods

        /// <summary>Class function.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        /// <param name="paramString">The parameter string.</param>
        /// <returns>A string.</returns>
        public string ClassFunction(string paramString)
        {
            return paramString;
        }

        /// <summary>Class sub.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        public void ClassSub()
        {
        }

        #endregion Public Methods
    }
}