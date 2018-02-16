namespace BugNET.Tests.BugNETCommon.Extensions
{
    #region Using Statements

    using BugNET.Common.Enums;
    using BugNET.Common.Extensions;

    using Xunit;

    #endregion

    /// <summary>An integer extension tests.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public static class IntegerExtensionTests
    {
        #region Public Methods

        /// <summary>(Unit Test Method) converts this object to an enum test.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        [Fact]
        public static void ToEnumTest()
        {
            UpgradeStatus status = 1.ToEnum(UpgradeStatus.None);

            Assert.Equal(UpgradeStatus.Install, status);

            status = 20.ToEnum(UpgradeStatus.None);

            Assert.Equal(UpgradeStatus.None, status);

            status = 1.ToEnum(UpgradeStatus.None);

            Assert.NotEqual(UpgradeStatus.Authenticated, status);
        }

        #endregion Public Methods
    }
}