using Avalonia.Controls;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.ViewModels;
using System;

namespace SecConfHub.Desktop.Views
{
    public partial class MainWindow : Window
    {
        private readonly MainWindowViewModel _viewModel;
        private readonly IServiceProvider _services;

        public MainWindow()
        {
            InitializeComponent();
        }

        public MainWindow(IServiceProvider services) : this()
        {
            _services = services;

            _viewModel = services.GetRequiredService<MainWindowViewModel>();
            DataContext = _viewModel;
        }

        private void GoToAuth_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
        {
            var authWindow = _services.GetRequiredService<AuthWindow>();

            authWindow.SizeTo(this);
            authWindow.Show();

            this.Close();
        }
    }
}