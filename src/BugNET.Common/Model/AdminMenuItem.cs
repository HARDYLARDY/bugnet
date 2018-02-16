namespace BugNET.Common.Model
{
    /// <summary>An admin menu item.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public class AdminMenuItem
    {
        #region Public Properties

        /// <summary>Gets or sets the identifier.</summary>
        /// <value>The identifier.</value>
        public int Id { get; set; }

        /// <summary>Gets or sets the argument.</summary>
        /// <value>The argument.</value>
        public string Argument { get; set; }

        /// <summary>Gets or sets URL of the image.</summary>
        /// <value>The image URL.</value>
        public System.Uri ImageUrl { get; set; }

        /// <summary>Gets or sets the text.</summary>
        /// <value>The text.</value>
        public string Text { get; set; }

        #endregion Public Properties
    }
}