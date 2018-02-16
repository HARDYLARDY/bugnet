namespace BugNET.Website
{
    #region Using Statements

    using Microsoft.AspNetCore;
    using Microsoft.AspNetCore.Hosting;

    #endregion

    /// <summary>A program.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    public class Program
    {
        #region Public Methods

        /// <summary>Builds web host.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="args">The arguments.</param>
        /// <returns>An IWebHost.</returns>
        public static IWebHost BuildWebHost(string[] args)
        {
            return WebHost.CreateDefaultBuilder(args).UseStartup<Startup>().Build();
        }

        /// <summary>Main entry-point for this application.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="args">The arguments.</param>
        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }

        #endregion Public Methods
    }
}