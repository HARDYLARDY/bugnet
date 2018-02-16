namespace BugNET.Common
{
    #region Using Statements

    using System;
    using System.IO;
    using System.Xml;
    using System.Xml.Xsl;

    using BugNET.Common.Transform;

    #endregion

    /// <summary>Form for viewing the XML XSL transaction.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class XmlXslTransform
    {
        #region Public Methods

        /// <summary>Loads the email XSL template.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="template">The template.</param>
        /// <param name="path">The path.</param>
        /// <returns>The email XSL template.</returns>
        public static string LoadEmailXslTemplate(string template, string path)
        {
            const string Ext = ".xslt";

            if (!template.EndsWith(Ext, StringComparison.InvariantCultureIgnoreCase))
            {
                template += Ext;
            }

            return File.ReadAllText(string.Concat(path, template));
        }

        /// <summary>Transforms the specified XML.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="xml">The XML.</param>
        /// <param name="xsl">The XSL.</param>
        /// <returns>A string.</returns>
        public static string Transform(string xml, string xsl)
        {
            var transformer = new XslCompiledTransform();
            XmlReader xmlReader = XmlReader.Create(new StringReader(xml));
            XmlReader xslReader = XmlReader.Create(new StringReader(xsl));
            var helpers = new XsltArgumentList();

            var args = new XslHelpers();

            helpers.AddExtensionObject("urn:xsl-helpers", args);

            using (var writer = new StringWriter())
            {
                transformer.Load(xslReader);
                transformer.Transform(xmlReader, helpers, writer);
                return writer.ToString();
            }
        }

        #endregion Public Methods
    }
}