namespace BugNET.Tests.BugNETCommon.Extensions
{
    #region Using Statements

    using System;

    using BugNET.Common.Enums;
    using BugNET.Common.Extensions;

    using Xunit;

    #endregion

    /// <summary>A string extension tests.</summary>
    /// <remarks>Rob Moloney, 28/01/2018.</remarks>
    public class StringExtensionTests
    {
        #region Public Methods

        /// <summary>(Unit Test Method) tests format boolean as yes no.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void FormatBooleanAsYesNoTest()
        {
            Assert.Equal("Yes", "true".FormatBooleanAsYesNo(), true);
            Assert.Equal("No", "False".FormatBooleanAsYesNo(), true);
            Assert.Equal("No", "false".FormatBooleanAsYesNo(), true);
            Assert.Equal("No", "XXXX".FormatBooleanAsYesNo(), true);
            Assert.Equal("No", "Yes".FormatBooleanAsYesNo(), true);
        }

        /// <summary>(Unit Test Method) tests format quantity.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void FormatQuantityTest()
        {
            Assert.Equal("99", "98.89".FormatQuantity(), true);
            Assert.Equal("44,399", "44398.89".FormatQuantity(), true);
            Assert.True(string.IsNullOrEmpty("M44398.89".FormatQuantity()));
        }

        /// <summary>(Unit Test Method) tests format short date and 12 h time.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void FormatShortDateAnd12HTimeTest()
        {
            Assert.Equal("2001-12-06 07:08 pm", "6 DEC 2001 07:08pm".FormatShortDateAnd12HTime(), true);
        }

        /// <summary>(Unit Test Method) tests format short date and 24 h time.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void FormatShortDateAnd24HTimeTest()
        {
            Assert.Equal("2001-12-06 19:08", "6 DEC 2001 07:08pm".FormatShortDateAnd24HTime(), true);
            Assert.True(string.IsNullOrEmpty("DDDD 7777& 6 DEC 2001 07:08pm".FormatShortDateAnd24HTime()));
        }

        /// <summary>(Unit Test Method) tests format short date.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void FormatShortDateTest()
        {
            Assert.Equal("06/12/2001", "6 DEC 2001 07:08pm".FormatShortDate(), true);
        }

        /// <summary>(Unit Test Method) tests format short time.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void FormatShortTimeTest()
        {
            Assert.Equal("19:08", "6 DEC 2001 07:08pm".FormatShortTime(), true);
        }

        /// <summary>(Unit Test Method) tests is.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void IsTest()
        {
            Assert.True("true".Is<bool>());
            Assert.True("true".Is<string>());
            Assert.False("FFFF".Is<bool>());
            Assert.False("F%666".Is<int>());
            Assert.True("666666".Is<int>());
            Assert.False("666.88".Is<int>());
            Assert.True("666.88".Is<double>());
        }

        /// <summary>(Unit Test Method) tests js encode.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void JsEncodeTest()
        {
            Assert.Equal("\\\\", "\\".JsEncode(), true);
            Assert.Equal(@"\""\\\""", "\"\\\"".JsEncode(), true);
        }

        /// <summary>(Unit Test Method) tests replace carriage return line feed with line break.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void ReplaceCrLfWithBrTest()
        {
            Assert.Equal("<br/>", "\r\n".ReplaceCrLfWithBr(), true);
        }

        /// <summary>Tests string is.</summary>
        /// <remarks>Rob Moloney, 14/02/2018.</remarks>
        [Fact]
        public void StringIsTest()
        {
            Assert.True("10.10".Is<decimal>());
            Assert.False("10,.10".Is<decimal>());
            Assert.True("10.10".Is<double>());
            Assert.False("10,.10".Is<double>());
            Assert.False("10.10".Is<int>());
            Assert.True("10".Is<int>());
            Assert.False("10".Is<DateTime>());
            Assert.True("10/10/2017".Is<DateTime>());
            Assert.True("10/1/2017".Is<DateTime>());
            Assert.True("31/10/2017".Is<DateTime>());
            Assert.False("10/31/2017".Is<DateTime>());
        }

        /// <summary>(Unit Test Method) tests strip HTML.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void StripHTMLTest()
        {
            Assert.Equal("\r\r", "<p></p>".StripHTML(), true);
        }

        /// <summary>(Unit Test Method) converts this object to an enum test.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void ToEnumTest()
        {
            Assert.True("ErrorUrl".ToEnum(true, AppSettingKey.NotFoundUrl).Equals(AppSettingKey.ErrorUrl));
            Assert.True("XXXX".ToEnum(true, AppSettingKey.NotFoundUrl).Equals(AppSettingKey.NotFoundUrl));
            Assert.True("errorurl".ToEnum(false, AppSettingKey.NotFoundUrl).Equals(AppSettingKey.NotFoundUrl));
            Assert.True("errorurl".ToEnum(true, AppSettingKey.NotFoundUrl).Equals(AppSettingKey.ErrorUrl));
        }

        #endregion Public Methods
    }
}