using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.ViewModels;
using SecConfHub.Desktop.Views;
using System;

namespace SecConfHub.Desktop;

public partial class AuthWindow : Window
{
    private readonly AuthViewModel _viewModel;
    private readonly IServiceProvider _services;

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

        mainWindow.Show();
        this.Close();
    }

    private void SubmitButton_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
    {
        if (!_viewModel.TryAuth())
        {
            return;
        }
        
        this.Close();
    }
}