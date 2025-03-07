using Avalonia;
using CommunityToolkit.Mvvm.ComponentModel;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Models;
using SecConfHub.Infrastructure.Context;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace SecConfHub.Desktop.ViewModels
{
    public partial class ModeratorsJouriorsRegistrationViewModel : ViewModelBase
    {
        private readonly ConferenceDbContext _db;

        public ModeratorsJouriorsRegistrationViewModel() { }

        public ModeratorsJouriorsRegistrationViewModel(IServiceProvider serviceProvider)
        {
            _db = serviceProvider.GetRequiredService<ConferenceDbContext>();

            base.PropertyChanged += OnPropertyChanged;

            Genders = new string[] { "мужской", "женский" };
            Roles = new string[] { "moderator", "jury" };

            ActivityDirections = _db.ActivityDirections
                .AsNoTracking()
                .Select(d => d.Name)
                .ToArray();

            EventNames = _db.Events
                .AsNoTracking()
                .Select(e => e.Title)
                .ToArray();

            NewUser = new NewUser();
            NewUser.Id = _db.Users.Max(u => u.Id) + 1;

            ShowConfirmPass = false;
            ConfirmPassChar = "*";
        }

        [ObservableProperty]
        private bool _showConfirmPass;

        [ObservableProperty]
        private bool _eventBinding;

        [ObservableProperty]
        private string _confirmPassChar;

        [ObservableProperty]
        private string _errors;

        public string[] Genders { get; set; }
        public string[] Roles { get; set; }
        public string[] ActivityDirections { get; set; }
        public string[] EventNames { get; set; }

        public NewUser NewUser { get; set; }

        public bool TrySubmit()
        {
            try
            {
                ValidationContext context = new(NewUser);
                Validator.ValidateObject(NewUser, context, true);

                var user = new Infrastructure.Models.User()
                {
                    FullName = NewUser.FullName,
                    Gender = NewUser.Gender,
                    Birth = DateOnly.FromDateTime(DateTime.Now),
                    Email = NewUser.Email,
                    Phone = NewUser.Phone,
                    Pass = NewUser.Password,
                    Role = NewUser.Role,
                };

                _db.Users.Add(user);

                // TODO: fix pg gerder_enum type, role_enum type
                //_db.SaveChanges();

                return true;
            }
            catch (ValidationException ex)
            {
                Errors = ex.ValidationResult?.ErrorMessage ?? string.Empty;

                return false;
            }
            catch (Exception ex)
            {
                Errors = ex.Message;

                return false;
            }
        }

        private void OnPropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == nameof(ShowConfirmPass))
            {
                ConfirmPassChar = ShowConfirmPass ? string.Empty : "*";
            }
        }
    }
}
