namespace BugNET.Common.Exceptions
{
    #region Using Statements

    using System;
    using System.Globalization;
    using System.Runtime.Serialization;

    #endregion

    /// <summary>Defines the base class for the namespace exceptions.</summary>
    /// <remarks>This class is the base class for exceptions that may occur during execution of the namespace members.</remarks>
    [Serializable]
    public class DataAccessException : Exception
    {
        #region Private Fields

        /// <summary>Name of the button status code data field.</summary>
        private const string BnStatusCodeDataFieldName = "BNStatusCode";

        #endregion Private Fields

        #region Public Constructors

        /// <summary>Initializes a new instance of the <see cref="DataAccessException"/> class.</summary>
        public DataAccessException()
            : this(CultureInfo.CurrentCulture)
        {
        }

        /// <summary>Initializes a new instance of the <see cref="DataAccessException" /> class.</summary>
        /// <remarks>
        ///     This constructor initializes the <see cref="Exception.Message" />
        ///     property of the new instance to a system-supplied message that describes the error, such as "BLToolkit Data Access
        ///     error has occurred.".
        /// </remarks>
        /// <param name="formatProvider">The format provider.</param>
        public DataAccessException(IFormatProvider formatProvider)
            : base("A Data Access exception has occurred.")
        {
            this.FormatProvider = formatProvider ?? CultureInfo.CurrentCulture;
        }

        /// <summary>Initializes a new instance of the <see cref="DataAccessException" /> class with the specified error message.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="message">The message to display to the client when the exception is thrown.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        public DataAccessException(string message, IFormatProvider formatProvider = null)
            : base(message)
        {
            this.FormatProvider = formatProvider ?? CultureInfo.CurrentCulture;
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="DataAccessException" /> class with the specified error message
        ///     and InnerException property.
        /// </summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="message">The message to display to the client when the exception is thrown.</param>
        /// <param name="innerException">The InnerException, if any, that threwthe current exception.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        public DataAccessException(string message, Exception innerException, IFormatProvider formatProvider = null)
            : base(message, innerException)
        {
            this.FormatProvider = formatProvider ?? CultureInfo.CurrentCulture;
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="DataAccessException" /> class with the specified error message
        ///     status code and InnerException property.
        /// </summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="message">The message to display to the client when the exception is thrown.</param>
        /// <param name="statusCode">The Status Code to display when the exception is thrown.</param>
        /// <param name="innerException">The InnerException, if any, that threwthe current exception.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        public DataAccessException(string message, int statusCode, Exception innerException, IFormatProvider formatProvider = null)
            : this(message, innerException, formatProvider)
        {
            this.StatusCode = statusCode;
        }

        /// <summary>
        ///     Initializes a new instance of the <see cref="DataAccessException" /> class with the specified error message
        ///     and status code.
        /// </summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="message">The message to display to the client when the exception is thrown.</param>
        /// <param name="statusCode">The Status Code to display when the exception is thrown.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        public DataAccessException(string message, int statusCode, IFormatProvider formatProvider)
            : this(message, statusCode, null, formatProvider)
        {
            this.StatusCode = statusCode;
        }

        /// <summary>Initializes a new instance of the <see cref="DataAccessException" /> class with the InnerException property.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="innerException">The InnerException, if any, that threw the current exception.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        public DataAccessException(Exception innerException, IFormatProvider formatProvider = null)
            : this(innerException.Message, innerException, formatProvider)
        {
            this.FormatProvider = formatProvider ?? CultureInfo.CurrentCulture;
        }

        /// <summary>Initializes a new instance of the <see cref="DataAccessException"/> class.</summary>
        /// <param name="message">The message.</param>
        public DataAccessException(string message)
            : this(message, CultureInfo.CurrentCulture)
        {
        }

        /// <summary>Initializes a new instance of the <see cref="DataAccessException"/> class.</summary>
        /// <param name="message">The message.</param>
        /// <param name="innerException">The inner exception.</param>
        public DataAccessException(string message, Exception innerException)
            : this(message, innerException, CultureInfo.CurrentCulture)
        {
        }

        #endregion Public Constructors

        #region Protected Constructors

        /// <summary>Initializes a new instance of the <see cref="DataAccessException" /> class with serialized data.</summary>
        /// <remarks>
        ///     This constructor is called during deserialization to reconstitute the exception object transmitted over a
        ///     stream.
        /// </remarks>
        /// <param name="info">The object that holds the serialized object data.</param>
        /// <param name="context">The contextual information about the source or destination.</param>
        /// <param name="formatProvider">(Optional) The format provider.</param>
        protected DataAccessException(SerializationInfo info, StreamingContext context, IFormatProvider formatProvider)
            : base(info, context)
        {
            this.FormatProvider = formatProvider;
        }

        /// <summary>Initializes a new instance of the <see cref="DataAccessException"/> class.</summary>
        /// <param name="info">The info.</param>
        /// <param name="context">The context.</param>
        protected DataAccessException(SerializationInfo info, StreamingContext context)
            : this(info, context, CultureInfo.CurrentCulture)
        {
        }

        #endregion Protected Constructors

        #region Public Properties

        /// <summary>Gets or sets the format provider.</summary>
        /// <value>The format provider.</value>
        public IFormatProvider FormatProvider { get; set; }

        /// <summary>Gets or sets the status code (BugNet specific status codes from the data provider).</summary>
        /// <value>The status code.</value>
        public int StatusCode
        {
            get =>
                this.Data.Contains(BnStatusCodeDataFieldName)
                    ? int.Parse(this.Data[BnStatusCodeDataFieldName].ToString(), this.FormatProvider ?? CultureInfo.CurrentCulture)
                    : 0;

            set
            {
                if (!this.Data.Contains(BnStatusCodeDataFieldName))
                {
                    this.Data.Add(BnStatusCodeDataFieldName, value);
                }
                else
                {
                    this.Data[BnStatusCodeDataFieldName] = value;
                }
            }
        }

        #endregion Public Properties
    }
}