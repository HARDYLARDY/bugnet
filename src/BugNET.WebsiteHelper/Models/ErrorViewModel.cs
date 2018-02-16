namespace BugNET.WebsiteHelper.Models
{
    /// <summary>A ViewModel for the error.</summary>
    /// <remarks>Rob Moloney, 28/01/2018.</remarks>
    public class ErrorViewModel
    {
        #region Public Properties

        /// <summary>Gets or sets the identifier of the request.</summary>
        /// <value>The identifier of the request.</value>
        public string RequestId { get; set; }

        /// <summary>Gets or sets a value indicating whether the request identifier is shown.</summary>
        /// <value>True if show request identifier, false if not.</value>
        public bool ShowRequestId => !string.IsNullOrEmpty(this.RequestId);

        #endregion Public Properties
    }
}