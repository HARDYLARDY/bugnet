namespace BugNET.Common.Model
{
    #region Using Statements

    using BugNET.Common.Enums;

    #endregion

    /// <summary>Additional information for action events.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public class ActionEventArguements
    {
        #region Public Properties

        /// <summary>Gets or sets information describing the extra data.</summary>
        /// <value>Information describing the extra.</value>
        public object ExtraData { get; set; }

        /// <summary>Gets or sets a value indicating whether the success.</summary>
        /// <value>True if success, false if not.</value>
        public bool Success { get; set; }

        /// <summary>Gets or sets the trigger.</summary>
        /// <value>The trigger.</value>
        public ActionTrigger Trigger { get; set; }

        #endregion Public Properties
    }
}