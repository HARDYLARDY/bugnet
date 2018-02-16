namespace BugNET.Website.Controllers
{
    #region Using Statements

    using System.Threading.Tasks;

    using BugNET.Website.Data;

    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Logging;

    #endregion

    /// <summary>A controller for handling accounts.</summary>
    /// <remarks>Rob Moloney, 27/01/2018.</remarks>
    /// <seealso cref="T:Microsoft.AspNetCore.Mvc.Controller" />
    [Route("[controller]/[action]")]
    public class AccountController : Controller
    {
        #region Private Fields

        /// <summary>The logger.</summary>
        private readonly ILogger logger;

        /// <summary>Manager for sign in.</summary>
        private readonly SignInManager<ApplicationUser> signInManager;

        #endregion Private Fields

        #region Public Constructors

        /// <summary>Initialises a new instance of the BugNET.Website.Controllers.AccountController class.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <param name="signInManager">Manager for sign in.</param>
        /// <param name="logger">The logger.</param>
        public AccountController(SignInManager<ApplicationUser> signInManager, ILogger logger)
        {
            this.signInManager = signInManager;
            this.logger = logger;
        }

        #endregion Public Constructors

        #region Public Methods

        /// <summary>(An Action that handles HTTP POST requests) logout.</summary>
        /// <remarks>Rob Moloney, 27/01/2018.</remarks>
        /// <returns>The asynchronous result that yields an IActionResult.</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Logout()
        {
            await this.signInManager.SignOutAsync();

            this.logger.LogInformation("User logged out.");

            return RedirectToPage("/Index");
        }

        #endregion Public Methods
    }
}