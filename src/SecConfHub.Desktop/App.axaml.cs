using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Data.Core.Plugins;
using Avalonia.Markup.Xaml;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Services;
using SecConfHub.Desktop.ViewModels;
using SecConfHub.Desktop.Views;
using SecConfHub.Infrastructure.Context;
using System;

namespace SecConfHub.Desktop
{
    public partial class App : Application
    {
        public override void Initialize()
        {
            AvaloniaXamlLoader.Load(this);
        }

        public override void OnFrameworkInitializationCompleted()
        {
            var serviceProvider = ConfigureServices();

            if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
            {
                // Line below is needed to remove Avalonia data validation.
                // Without this line you will get duplicate validations from both Avalonia and CT
                BindingPlugins.DataValidators.RemoveAt(0);

                desktop.MainWindow = serviceProvider.GetRequiredService<MainWindow>();
            }

            base.OnFrameworkInitializationCompleted();
        }

        private IServiceProvider ConfigureServices()
        {
            ServiceCollection services = new ServiceCollection();

            services.AddSingleton<UserContainer>();

            services.AddDbContext<ConferenceDbContext>(optionsBuilder =>
                optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=SecConfHub;Username=postgres;Password=yougifted"));

            services.AddTransient<MainWindowViewModel>();
            services.AddTransient<MainWindow>();

            services.AddTransient<AuthViewModel>();
            services.AddTransient<AuthWindow>();

            services.AddTransient<OrganizerViewModel>();
            services.AddTransient<OrganizerWindow>();

            services.AddTransient<ModeratorsJouriorsRegistrationViewModel>();
            services.AddTransient<ModeratorsJouriousRegistrationWindow>();

            return services.BuildServiceProvider();
        }
    }
}