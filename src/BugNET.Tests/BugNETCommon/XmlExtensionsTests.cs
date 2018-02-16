namespace BugNET.Tests.BugNETCommon
{
    #region Using Statements

    using BugNET.Common.Extensions;
    using BugNET.Tests.TestCommon;

    using Xunit;

    #endregion

    /// <summary>An XML extensions tests.</summary>
    /// <remarks>Rob Moloney, 14/02/2018.</remarks>
    public class XmlExtensionsTests
    {
        #region Private Fields

        /// <summary>The XML.</summary>
        private const string Xml = "<XmlClassTest><DecimalValue>77.77</DecimalValue><StringlValue>tttt</StringlValue></XmlClassTest>";

        #endregion Private Fields

        #region Public Methods

        /// <summary>Tests from XML.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        [Fact]
        public void FromXmlTest()
        {
            var xmlClass = Xml.FromXml<XmlClassTest>();
            var xmlClass2 = new XmlClassTest { DecimalValue = 77.77m, StringlValue = "tttt" };

            Assert.True(xmlClass.DecimalValue.Equals(xmlClass2.DecimalValue));
            Assert.Equal(xmlClass.StringlValue, xmlClass2.StringlValue);
        }

        /// <summary>Converts this object to an XML test.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        [Fact]
        public void ToXmlTest()
        {
            var xmlClass = new XmlClassTest { DecimalValue = 77.77m, StringlValue = "tttt" };

            string xml = xmlClass.ToXml();

            Assert.Equal(Xml, xml, true);
        }

        #endregion Public Methods
    }
}