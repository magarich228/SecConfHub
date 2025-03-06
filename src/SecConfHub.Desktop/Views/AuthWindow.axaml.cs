using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Services;
using SecConfHub.Desktop.ViewModels;
using SecConfHub.Desktop.Views;
using System;
using System.Collections.Generic;

namespace SecConfHub.Desktop;

public partial class AuthWindow : Window
{
    private readonly AuthViewModel _viewModel;
    private readonly IServiceProvider _services;

    private readonly Dictionary<string, Type> _roleWindows = new Dictionary<string, Type>()
    {
        { "organizer", typeof(OrganizerWindow) }
    };

    public AuthWindow()
    {
        InitializeComponent();
    }

    public AuthWindow(IServiceProvider services) : this()
    {
        _services = services;
        _viewModel = services.GetRequiredService<AuthViewModel>();

        DataContext = _viewModel;
    }

    private void GoToBack_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        var mainWindow = _services.GetRequiredService<MainWindow>();

        mainWindow.SizeTo(this);
        mainWindow.Show();

        this.Close();
    }

    private void SubmitButton_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        if (!_viewModel.TryAuth(out var user) &&
            user is null)
        {
            return;
        }

        var container = _services.GetRequiredService<UserContainer>();
        container.CurrentUser = user;

        if (!_roleWindows.TryGetValue(user!.Role, out var windowType))
        {
            throw new ApplicationException("неизвестная роль");
        }

        var nextWindow = (Window)_services.GetRequiredService(windowType);

        nextWindow.SizeTo(this);
        nextWindow.Show();

        this.Close();
    }
}