using CommunityToolkit.Mvvm.ComponentModel;
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
    }
}
