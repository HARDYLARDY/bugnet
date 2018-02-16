namespace BugNET.Tests.BugNETCommon.Extensions
{
    #region Using Statements

    using System;
    using System.Collections.Specialized;

    using BugNET.Common.Extensions;

    using Xunit;

    #endregion

    /// <summary>A name value collection extension tests.</summary>
    /// <remarks>Rob Moloney, 14/02/2018.</remarks>
    public class NameValueCollectionExtensionTests
    {
        #region Public Methods

        /// <summary>Tests get by string.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        [Fact]
        public void GetByStringTest()
        {
            var myCol = new NameValueCollection { { "red", "1" }, { "green", "2" }, { "blue", "azul" }, { "orange", "rouge" } };

            Assert.Equal(1, myCol.Get<int>("red"));
            Assert.Equal(0m, myCol.Get("essew", 0m));
            Assert.Equal(2d, myCol.Get<double>("green"));
            Assert.Equal("rouge", myCol.Get<string>("orange"));
            Assert.Throws<ArgumentNullException>(() => myCol.Get<int>(string.Empty));
            Assert.Equal(0, myCol.Get<int>("ddd"));
            Assert.Null(myCol.Get<int?>("ddd"));
        }

        #endregion Public Methods
    }
}