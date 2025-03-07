using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Infrastructure.Context;
using SecConfHub.Infrastructure.Models;
using System;
using System.Linq;

namespace SecConfHub.Desktop.ViewModels
{
    public partial class AuthViewModel : ViewModelBase
    {
        private readonly ConferenceDbContext _db;

        public AuthViewModel()
        {

        }

        public AuthViewModel(IServiceProvider serviceProvider)
        {
            _db = serviceProvider.GetRequiredService<ConferenceDbContext>();

            GenerateNewCaptcha();
        }

        [ObservableProperty]
        private string _idNumber;

        [ObservableProperty]
        private string _password;

        [ObservableProperty]
        private string _errorMessage;


        [ObservableProperty]
        private string _captchaCode;

        [ObservableProperty]
        private string _userInput;

        [ObservableProperty]
        private bool _isValid;

        [ObservableProperty]
        private string _statusMessage;


        public bool TryAuth(out User? user)
        {
            if (!int.TryParse(IdNumber, out var id))
            {
                ErrorMessage = "Некорректный формат идентификатора";

                user = null;

                return false;
            }

            var searchedUser = _db.Users.FirstOrDefault(u => u.Id == id &&
                                    u.Pass == Password);

            if (searchedUser is null)
            {
                ErrorMessage = "Неверный идентификатор или пароль";

                user = null;

                return false;
            }

            ErrorMessage = string.Empty;

            user = searchedUser;

            return true;
        }

        private void GenerateNewCaptcha()
        {
            var random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

            CaptchaCode = new string(Enumerable.Repeat(chars, 4)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }


        [RelayCommand]
        private void Validate()
        {
            IsValid = UserInput?.Equals(CaptchaCode, StringComparison.OrdinalIgnoreCase) ?? false;
            StatusMessage = IsValid ? "Проверка пройдена!" : "Неверный код. Попробуйте снова.";

            if (!IsValid)
            {
                GenerateNewCaptcha();
                UserInput = string.Empty;
            }
        }
    }
}
