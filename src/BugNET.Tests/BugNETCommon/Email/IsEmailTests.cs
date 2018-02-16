namespace BugNET.Tests.BugNETCommon.Email
{
    #region Using Statements

    using BugNET.Common;

    using Xunit;

    #endregion

    /// <summary>The is email tests.</summary>
    /// <remarks>Rob Moloney, 28/01/2018.</remarks>
    public class IsEmailTests
    {
        #region Public Methods

        /// <summary>(Unit Test Method) tests is email valid.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void IsEmailValidTest()
        {
            var email = new IsEMail();

            Assert.False(email.IsEmailValid("kkkl///;;"));
            Assert.True(email.IsEmailValid("test@gmail.com"));
            Assert.True(email.IsEmailValid("test@jjj.gmail.com"));
            Assert.True(email.IsEmailValid("test.Roger@jjj.gmail.com"));
            Assert.False(email.IsEmailValid("@gmail.com"));
            Assert.True(email.IsEmailValid("test@gmail"));
            Assert.False(email.IsEmailValid("test jason@gmail.com"));
            Assert.False(email.IsEmailValid("test.jason@gmail com"));
        }

        #endregion Public Methods
    }
}