using Avalonia.Media.Imaging;
using CommunityToolkit.Mvvm.ComponentModel;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Desktop.Models;
using SecConfHub.Infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;

namespace SecConfHub.Desktop.ViewModels
{
    public partial class MainWindowViewModel : ViewModelBase
    {
        private readonly ConferenceDbContext _db;
        private const string EventTypeNameStubValue = "Все";

        public MainWindowViewModel()
        {

        }

        public MainWindowViewModel(IServiceProvider serviceProvider)
        {
            _db = serviceProvider.GetRequiredService<ConferenceDbContext>();

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
                    Title = e.Title,
                    EventTypeName = e.EventType!.Name
                });

            Events = new ObservableCollection<EventDto>(events);

            var stubEventTypeName = new string[] { EventTypeNameStubValue };

            var eventTypeNames = _db.EventTypes
                .AsNoTracking()
                .Select(t => t.Name);

            EventTypeNames = stubEventTypeName.Union(eventTypeNames);

            EventTypeNameFilter = stubEventTypeName.First();

            StartDateStart = new DateTime(2000, 1, 1);
            StartDateEnd = new DateTime(2030, 1, 1);

            base.PropertyChanged += OnPropertyChanged;
        }

        public IEnumerable<string> EventTypeNames { get; set; }

        public ObservableCollection<EventDto> Events { get; set; }

        [ObservableProperty]
        private DateTimeOffset _startDateStart;

        [ObservableProperty]
        private DateTimeOffset _startDateEnd;

        [ObservableProperty]
        private string _eventTypeNameFilter;

        private void OnPropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            if (e.PropertyName == nameof(StartDateStart) ||
                e.PropertyName == nameof(StartDateEnd) ||
                e.PropertyName == nameof(EventTypeNameFilter))
            {
                var events = _db.Events
                    .AsNoTracking()
                    .Include(e => e.EventType)
                    .Include(e => e.City)
                    .Where(e => e.StartDate.ToDateTime(TimeOnly.MinValue).ToUniversalTime() >= StartDateStart.UtcDateTime &&
                                e.StartDate.ToDateTime(TimeOnly.MinValue).ToUniversalTime() <= StartDateEnd.UtcDateTime)
                    .Where(e => EventTypeNameFilter == EventTypeNameStubValue ||
                                e.EventType!.Name == EventTypeNameFilter)
                    .Select(e => new EventDto
                    {
                        Id = e.Id,
                        City = e.City.Name,
                        Days = e.Days,
                        Photo = new Bitmap($"Images/Events/{e.PhotoPath}"),
                        StartDate = e.StartDate,
                        Title = e.Title,
                        EventTypeName = e.EventType!.Name
                    });



                Events.ReplaceWith(events);
            }
        }
    }
}
