using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace SecConfHub.Desktop;

public partial class ModeratorView : Window
{
    private readonly IServiceProvider _serviceProvider;

    public ModeratorView()
    {
        InitializeComponent();
    }

    public ModeratorView(IServiceProvider serviceProvider) : this()
    {
        _serviceProvider = serviceProvider;
    }

    private void ExitButton_Click(object? sender, RoutedEventArgs e)
    {
        var window = _serviceProvider.GetRequiredService<AuthWindow>();

        window.SizeTo(this);
        window.Show();

        this.Close();
    }
}