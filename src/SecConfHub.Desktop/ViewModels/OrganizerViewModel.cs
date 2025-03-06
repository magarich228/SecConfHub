using Avalonia.Media.Imaging;
using CommunityToolkit.Mvvm.ComponentModel;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Services;
using SecConfHub.Infrastructure.Context;
using SecConfHub.Infrastructure.Models;
using System;

namespace SecConfHub.Desktop.ViewModels
{
    public partial class OrganizerViewModel : ViewModelBase
    {
        private readonly ConferenceDbContext _db;

        public OrganizerViewModel()
        {

        }

        public OrganizerViewModel(IServiceProvider serviceProvider)
        {
            _db = serviceProvider.GetRequiredService<ConferenceDbContext>();
            _user = serviceProvider.GetRequiredService<UserContainer>().CurrentUser ??
                throw new InvalidOperationException("Пользователь неизвестен");

            var now = DateTime.Now;

            var morning = DateTime.Today.AddHours(6);
            var day = DateTime.Today.AddHours(14);
            var evening = DateTime.Today.AddHours(18);

            Greeting = now >= morning ? 
                (now >= day ? 
                    (now >= evening ? 
                            "вечер" : 
                            throw new InvalidOperationException()) : 
                        "день") : 
                "утро";

            Appeal = _user.Gender == "мужской" ? 
                $"Mr. {_user.FullName}" : 
                $"Mrs. {_user.FullName}";

            var imagePath = _user.PhotoPath;
            Image = !string.IsNullOrWhiteSpace(imagePath) ? 
                new Bitmap($"Images/Users/{imagePath}") : 
                new Bitmap("Assets/default.jpg");
        }

        [ObservableProperty]
        private User _user;

        [ObservableProperty]
        private string _greeting;

        [ObservableProperty]
        private string _appeal;

        public Bitmap Image { get; set; }
    }
}
