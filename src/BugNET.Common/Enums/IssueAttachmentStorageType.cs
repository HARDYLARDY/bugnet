namespace BugNET.Common.Enums
{
    #region Using Statements

    using System.Xml.Serialization;

    #endregion

    /// <summary>Enumeration for the storage type of attachments.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public enum IssueAttachmentStorageType
    {
        /// <summary>An enum constant representing the none option.</summary>
        [XmlEnum(Name = "None")]
        None = 0,

        /// <summary>An enum constant representing the file system option.</summary>
        [XmlEnum(Name = "FileSystem")]
        FileSystem = 1,

        /// <summary>An enum constant representing the database option.</summary>
        [XmlEnum(Name = "Database")]
        Database = 2
    }
}