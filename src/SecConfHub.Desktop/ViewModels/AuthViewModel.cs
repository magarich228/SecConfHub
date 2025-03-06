using CommunityToolkit.Mvvm.ComponentModel;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Infrastructure.Context;
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
        }

        [ObservableProperty]
        private string _idNumber;

        [ObservableProperty]
        private string _password;

        [ObservableProperty]
        private string _errorMessage;

        //public string IdNumber { get; set; } = null!;
        //public string Password { get; set; } = null!;
        //public string ErrorMessage { get; set; } = null!;

        public bool TryAuth()
        {
            if (!int.TryParse(IdNumber, out var id))
            {
                ErrorMessage = "Некорректный формат идентификатора";
                IdNumber = string.Empty;

                return false;
            }

            if (!_db.Users.Any(u => u.Id == id &&
                                    u.Pass == Password))
            {
                ErrorMessage = "Неверный идентификатор или пароль";

                return false;
            }

            ErrorMessage = string.Empty;

            return true;
        }
    }
}
