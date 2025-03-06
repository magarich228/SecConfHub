using Avalonia.Controls;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Services;
using SecConfHub.Desktop.ViewModels;
using System;

namespace SecConfHub.Desktop;

public partial class OrganizerWindow : Window
{
    private readonly OrganizerViewModel _viewModel;
    private readonly IServiceProvider _serviceProvider;

    public OrganizerWindow()
    {
        InitializeComponent();
    }

    public OrganizerWindow(IServiceProvider serviceProvider) : this()
    {
        _serviceProvider = serviceProvider;
        _viewModel = _serviceProvider.GetRequiredService<OrganizerViewModel>();

        DataContext = _viewModel;
    }

    private void ExitButton_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        var container = _serviceProvider.GetRequiredService<UserContainer>();
        container.CurrentUser = null;

        var authWindow = _serviceProvider.GetRequiredService<AuthWindow>();

        authWindow.SizeTo(this);
        authWindow.Show();

        this.Close();
    }

    private void RegisterButton_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {

    }
}