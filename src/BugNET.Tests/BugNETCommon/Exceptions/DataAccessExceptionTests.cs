namespace BugNET.Tests.BugNETCommon.Exceptions
{
    #region Using Statements

    using System;

    using BugNET.Common.Exceptions;

    using Xunit;

    #endregion

    /// <summary>A data access exception tests.</summary>
    /// <remarks>Rob Moloney, 28/01/2018.</remarks>
    public class DataAccessExceptionTests
    {
        #region Public Methods

        /// <summary>(Unit Test Method) tests status code.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        [Fact]
        public void StatusCodeTest()
        {
            var applicationException = new ArithmeticException("Test");
            var exception = new DataAccessException(applicationException);

            exception.Data["BNStatusCode"] = 10;

            Assert.True(exception.StatusCode == 10);
        }

        #endregion Public Methods
    }
}