using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.ViewModels;
using System;

namespace SecConfHub.Desktop;

public partial class ModeratorsJouriousRegistrationWindow : Window
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ModeratorsJouriorsRegistrationViewModel _viewModel;

    public ModeratorsJouriousRegistrationWindow()
    {
        InitializeComponent();
    }

    public ModeratorsJouriousRegistrationWindow(IServiceProvider serviceProvider) : this()
    {
        _serviceProvider = serviceProvider;
        _viewModel = _serviceProvider.GetRequiredService<ModeratorsJouriorsRegistrationViewModel>();

        DataContext = _viewModel;
    }

    private void CancelButton_Click(object? sender, RoutedEventArgs e)
    {
        var window = _serviceProvider.GetRequiredService<OrganizerWindow>();

        window.SizeTo(this);
        window.Show();

        this.Close();
    }

    private void SubmitUserButton_Click(object? sender, RoutedEventArgs e)
    {
        if (!_viewModel.TrySubmit())
        {
            return;
        }

        var window = _serviceProvider.GetRequiredService<OrganizerWindow>();

        window.SizeTo(this);
        window.Show();

        this.Close();
    }
}