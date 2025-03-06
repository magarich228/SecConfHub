using Avalonia.Media.Imaging;
using Microsoft.EntityFrameworkCore;
using SecConfHub.Desktop.Models;
using SecConfHub.Infrastructure.Context;
using SecConfHub.Infrastructure.Models;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;

namespace SecConfHub.Desktop.ViewModels
{
    public partial class MainWindowViewModel : ViewModelBase
    {
        private readonly ConferenceDbContext _db;

        public MainWindowViewModel() { }

        public MainWindowViewModel(ConferenceDbContext db)
        {
            _db = db;

            var events = _db.Events
                .AsNoTracking()
                .Include(e => e.City)
                .Select(e => new EventDto
            {
                Id = e.Id,
                City = e.City.Name,
                Days = e.Days,
                Photo = new Bitmap($"Images/Events/{e.PhotoPath}"),
                StartDate = e.StartDate,
                Title = e.Title
            });

            Events = new ObservableCollection<EventDto>(events);

            base.PropertyChanged += OnPropertyChanged;
        }

        public ObservableCollection<EventDto> Events { get; set; }

        private void OnPropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            
        }
    }
}
