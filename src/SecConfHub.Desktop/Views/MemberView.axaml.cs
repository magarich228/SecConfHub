using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using Microsoft.Extensions.DependencyInjection;
using System;

namespace SecConfHub.Desktop;

public partial class MemberView : Window
{
    private readonly IServiceProvider _serviceProvider;

    public MemberView()
    {
        InitializeComponent();

    }

    public MemberView(IServiceProvider serviceProvider) : this()
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