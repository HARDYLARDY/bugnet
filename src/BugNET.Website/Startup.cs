namespace BugNET.Website
{
    #region Using Statements

    using System.Collections.Generic;
    using System.Globalization;
    using System.Linq;

    using BugNET.Website.Data;
    using BugNET.Website.Models;
    using BugNET.Website.Services;

    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.Identity;
    using Microsoft.AspNetCore.Localization;
    using Microsoft.EntityFrameworkCore;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;

    #endregion

    /// <summary>A startup.</summary>
    /// <remarks>Rob Moloney, 28/01/2018.</remarks>
    public class Startup
    {
        #region Public Constructors

        /// <summary>Initializes a new instance of the <see cref="Startup"/> class.</summary>
        /// <param name="configuration">The configuration.</param>
        public Startup(IConfiguration configuration)
        {
            this.Configuration = configuration;
        }

        #endregion Public Constructors

        #region Public Properties

        /// <summary>Gets the configuration.</summary>
        /// <value>The configuration.</value>
        public IConfiguration Configuration { get; }

        #endregion Public Properties

        #region Public Methods

        /// <summary>This method gets called by the runtime. Use this method to configure the HTTP request pipeline.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <param name="app">The application.</param>
        /// <param name="env">The environment.</param>
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            var supportedCultures = new List<CultureInfo>
                                        {
                                            new CultureInfo("en-GB"),
                                            new CultureInfo("en-US"),
                                            new CultureInfo("en-AU"),
                                            new CultureInfo("es-ES"),
                                            new CultureInfo("ja-JP"),
                                            new CultureInfo("fr-FR"),
                                            new CultureInfo("zh"),
                                            new CultureInfo("zh-CN")
                                        };
            var options = new RequestLocalizationOptions
                              {
                                  DefaultRequestCulture = new RequestCulture("en-GB"),
                                  SupportedCultures = supportedCultures,
                                  SupportedUICultures = supportedCultures
                              };

            CookieRequestCultureProvider cookieProvider = options.RequestCultureProviders.OfType<CookieRequestCultureProvider>().First();
            
            cookieProvider.CookieName = "UserCulture";
            
            app.UseRequestLocalization(options);

            if (env.IsDevelopment())
            {
                app.UseBrowserLink();
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();

            app.UseAuthentication();

            app.UseMvc(routes => { routes.MapRoute("default", "{controller=Home}/{action=Index}/{id?}"); });
        }

        /// <summary>This method gets called by the runtime. Use this method to add services to the container.</summary>
        /// <remarks>Rob Moloney, 28/01/2018.</remarks>
        /// <param name="services">The services.</param>
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<ApplicationDbContext>(options => options.UseSqlServer(this.Configuration.GetConnectionString("DefaultConnection")));

            services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<ApplicationDbContext>().AddDefaultTokenProviders();

            // Add application services.
            services.AddTransient<IEmailSender, EmailSender>();

            services.AddMvc().AddViewLocalization().AddDataAnnotationsLocalization();
        }

        #endregion Public Methods
    }
}