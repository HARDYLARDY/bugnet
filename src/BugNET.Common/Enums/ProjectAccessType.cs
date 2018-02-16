namespace BugNET.Common.Enums
{
    using System.Xml.Serialization;

    /// <summary>Values that represent project access types.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public enum ProjectAccessType
    {
        /// <summary>An enum constant representing the none option.</summary>
        [XmlEnum(Name = "None")]
        None = 0,

        /// <summary>An enum constant representing the public option.</summary>
        [XmlEnum(Name = "Public")]
        Public = 1,

        /// <summary>An enum constant representing the private option.</summary>
        [XmlEnum(Name = "Private")]
        Private = 2
    }
}