using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.ViewModels;
using System;

namespace SecConfHub.Desktop;

public partial class ModeratorsJouriousRegistrationWindow : Window
{
    private readonly ModeratorsJouriorsRegistrationViewModel viewModel;

    public ModeratorsJouriousRegistrationWindow()
    {
        InitializeComponent();
    }

    public ModeratorsJouriousRegistrationWindow(IServiceProvider serviceProvider) : this()
    {
        viewModel = serviceProvider.GetRequiredService<ModeratorsJouriorsRegistrationViewModel>();
    }
}