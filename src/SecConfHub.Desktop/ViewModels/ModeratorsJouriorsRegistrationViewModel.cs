using Microsoft.Extensions.DependencyInjection;
using SecConfHub.Infrastructure.Context;
using System;

namespace SecConfHub.Desktop.ViewModels
{
    public partial class ModeratorsJouriorsRegistrationViewModel : ViewModelBase
    {
        private readonly ConferenceDbContext _db;

        public ModeratorsJouriorsRegistrationViewModel()
        {
            
        }

        public ModeratorsJouriorsRegistrationViewModel(IServiceProvider serviceProvider)
        {
            _db = serviceProvider.GetRequiredService<ConferenceDbContext>();
        }
    }
}
