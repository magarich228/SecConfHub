using Avalonia.Media.Imaging;
using System;

namespace SecConfHub.Desktop.Models
{
    public class EventDto
    {
        public int Id { get; set; }
        public string Title { get; set; } = null!;
        public DateOnly StartDate { get; set; }
        public int Days { get; set; }
        public Bitmap Photo { get; set; } = null!;
        public string City { get; set; } = null!;
        public string EventTypeName { get; set; } = null!;
    }
}
