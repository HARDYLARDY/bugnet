namespace BugNET.Tests.BugNETCommon.Extensions
{
    #region Using Statements

    using System.Collections;
    using System.Collections.Generic;
    using System.Linq;

    using AutoMoqCore;

    using BugNET.Common.Extensions;

    using Xunit;

    #endregion

    /// <summary>(Unit Test Fixture) an enumerable extension tests.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class EnumerableExtensionTests
    {
        #region Public Methods

        /// <summary>(Unit Test Method) tests sort.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        [Fact]
        public static void SortTest()
        {
            IEnumerable<int> items = new List<int>() { 1, 5, 44, 33, 22, 2 };

            IEnumerable<dynamic> sortedValues = items.Select(i => new { Value = i }).Sort("Value desc");

            Assert.Equal(44, sortedValues.First().Value);
        }

        #endregion Public Methods
    }
}