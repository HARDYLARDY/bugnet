namespace BugNET.Common.Extensions
{
    #region Using Statements

    using System.IO;
    using System.Text;
    using System.Xml;
    using System.Xml.Serialization;

    #endregion

    /// <summary>An XML extension.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class XmlExtension
    {
        #region Public Methods

        /// <summary>De-serialize an value string in to an object of Type T</summary>
        /// <typeparam name="T">Any class type</typeparam>
        /// <param name="xml">Xml as string to De-serialize from</param>
        /// <returns>A new object of type T is successful, null if failed</returns>
        public static T FromXml<T>(this string xml)
            where T : class
        {
            var xs = new XmlSerializer(typeof(T));

            using (var memoryStream = new MemoryStream(new UTF8Encoding().GetBytes(xml)))
            {
                return (T)xs.Deserialize(memoryStream);
            }
        }

        /// <summary>Serializes an object of type T in to an xml string</summary>
        /// <typeparam name="T">Any class type</typeparam>
        /// <param name="value">Object to serialize</param>
        /// <returns>A string that represents Xml, empty otherwise</returns>
        public static string ToXml<T>(this T value)
            where T : class
        {
            var settings = new XmlWriterSettings { OmitXmlDeclaration = true };
            var builder = new StringBuilder();
            var xmlnsEmpty = new XmlSerializerNamespaces();

            xmlnsEmpty.Add(string.Empty, string.Empty); // kill any namespaces

            var xs = new XmlSerializer(value.GetType());

            using (XmlWriter stringWriter = XmlWriter.Create(builder, settings))
            {
                xs.Serialize(stringWriter, value, xmlnsEmpty);

                return builder.ToString();
            }
        }

        #endregion Public Methods
    }
}