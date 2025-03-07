using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using Avalonia.Threading;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Services;
using SecConfHub.Desktop.ViewModels;
using SecConfHub.Desktop.Views;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SecConfHub.Desktop;

public partial class AuthWindow : Window
{
    private readonly AuthViewModel _viewModel;
    private readonly IServiceProvider _services;

    private int Attemps = 0;

    private readonly Dictionary<string, Type> _roleWindows = new Dictionary<string, Type>()
    {
        { "organizer", typeof(OrganizerWindow) },
        { "member", typeof(MemberView) },
        { "moderator", typeof(ModeratorView) },
        { "jury", typeof(JuryView) },
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
            Attemps++;

            if (Attemps == 3)
            {
                var submitBtn = this.GetControl<Button>("submit");
                Attemps = 0;

                Dispatcher.UIThread.Post(() =>
                {
                    submitBtn.Content = "Блокировка";

                    submitBtn.IsEnabled = false;
                });

                _ = Task.Run(async () =>
                {
                    await Task.Delay(10_000);

                    Dispatcher.UIThread.Post(() =>
                    {
                        submitBtn.Content = "Войти";
                        submitBtn.IsEnabled = true;
                    });
                });
            }

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