namespace BugNET.Tests.BugNETCommon.Extensions
{
    #region Using Statements

    using System;

    using BugNET.Common.Extensions;

    using Xunit;

    #endregion

    /// <summary>A convertible extension tests.</summary>
    /// <remarks>Rob Moloney, 16/02/2018.</remarks>
    public class ConvertibleExtensionTests
    {
        #region Public Methods

        /// <summary>Converts this object to a date time test.</summary>
        /// <remarks>Rob Moloney, 16/02/2018.</remarks>
        [Fact]
        public void ConvertToDateTimeTest()
        {
            Assert.Equal(new DateTime(2017, 12, 31), "31/12/2017".To<DateTime>());
            Assert.Throws<FormatException>(() => "sww.0".To<DateTime>());
            Assert.Equal(new DateTime(2017, 1, 1), "sss".ToOrDefault(new DateTime(2017, 1, 1)));
            Assert.Equal(new DateTime(2017, 12, 31), "31/12/2017".ToOrDefault(new DateTime(2017, 1, 1)));
        }

        /// <summary>Converts this object to a decimal test.</summary>
        /// <remarks>Rob Moloney, 16/02/2018.</remarks>
        [Fact]
        public void ConvertToDecimalTest()
        {
            Assert.Equal(20m, "20.0".To<decimal>());
            Assert.Throws<FormatException>(() => "sww.0".To<decimal>());
            Assert.Equal(20m, "sss".ToOrDefault(20m));
            Assert.Equal(21m, "21".ToOrDefault(20m));
            Assert.Equal(20m, "20".To<decimal>());
            Assert.Equal(20.1m, "20.1".To<decimal>());
        }

        /// <summary>Converts this object to an int test.</summary>
        /// <remarks>Rob Moloney, 16/02/2018.</remarks>
        [Fact]
        public void ConvertToIntTest()
        {
            Assert.Equal(20, "20".To<int>());
            Assert.Throws<FormatException>(() => "sww.0".To<int>());
            Assert.Equal(20, "sss".ToOrDefault(20m));
            Assert.Equal(21, "21".ToOrDefault(20m));
        }

        #endregion Public Methods
    }
}