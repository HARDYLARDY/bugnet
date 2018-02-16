namespace BugNET.Website.Controllers
{
    #region Using Statements

    using System.Diagnostics;

    using BugNET.WebsiteHelper.Models;

    using Microsoft.AspNetCore.Mvc;

    #endregion

    /// <summary>A controller for handling homes.</summary>
    /// <remarks>Rob Moloney, 28/01/2018.</remarks>
    /// <seealso cref="T:Microsoft.AspNetCore.Mvc.Controller" />
    public class HomeController : Controller
    {
        #region Public Methods

        /// <summary>Gets the about.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <returns>An IActionResult.</returns>
        public IActionResult About()
        {
            this.ViewData["Message"] = "Your application description page.";

            return View();
        }

        /// <summary>Gets the contact.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <returns>An IActionResult.</returns>
        public IActionResult Contact()
        {
            this.ViewData["Message"] = "Your contact page.";

            return View();
        }

        /// <summary>Gets the error.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <returns>An IActionResult.</returns>
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? this.HttpContext.TraceIdentifier });
        }

        /// <summary>Gets the index.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <returns>An IActionResult.</returns>
        public IActionResult Index()
        {
            return View();
        }

        #endregion Public Methods
    }
}