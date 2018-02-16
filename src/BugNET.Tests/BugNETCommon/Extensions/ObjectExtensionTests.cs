namespace BugNET.Tests.BugNETCommon.Extensions
{
    #region Using Statements

    using System;

    using BugNET.Common.Extensions;

    using Xunit;

    #endregion

    /// <summary>An object extension tests.</summary>
    /// <remarks>Rob Moloney, 14/02/2018.</remarks>
    public class ObjectExtensionTests
    {
        #region Public Methods

        /// <summary>Tests get value.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        [Fact]
        public void GetValueTest()
        {
            Assert.Equal(22.23m, "22.23".GetValue(0m));
            Assert.Equal(0m, "22.dd23".GetValue(0m));
            Assert.Equal(new DateTime(2017, 2, 2), "2/2/2017".GetValue(new DateTime(1900, 1, 1)));
            Assert.Equal(new DateTime(1900, 1, 1), "//2/2017".GetValue(new DateTime(1900, 1, 1)));
        }

        #endregion Public Methods
    }
}