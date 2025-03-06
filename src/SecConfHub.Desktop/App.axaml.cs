using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Data.Core;
using Avalonia.Data.Core.Plugins;
using Avalonia.Markup.Xaml;
using SecConfHub.Desktop.ViewModels;
using SecConfHub.Desktop.Views;
using SecConfHub.Infrastructure.Context;

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
            var db = GetDbContext();

            if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
            {
                // Line below is needed to remove Avalonia data validation.
                // Without this line you will get duplicate validations from both Avalonia and CT
                BindingPlugins.DataValidators.RemoveAt(0);
                desktop.MainWindow = new MainWindow
                {
                    DataContext = new MainWindowViewModel(db),
                };
            }

            base.OnFrameworkInitializationCompleted();
        }

        private ConferenceDbContext GetDbContext()
        {
            var options = new Microsoft.EntityFrameworkCore.DbContextOptions<ConferenceDbContext>();
            var db = new ConferenceDbContext(options);

            return db;
        }
    }
}