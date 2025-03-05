using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("event")]
public partial class Event
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("title")]
    public string Title { get; set; } = null!;

    [Column("start_date")]
    public DateOnly StartDate { get; set; }

    [Column("days")]
    public int Days { get; set; }

    [Column("city_id")]
    public int CityId { get; set; }

    [Column("photo_path", TypeName = "character varying")]
    public string? PhotoPath { get; set; }

    [InverseProperty("Event")]
    public virtual ICollection<Activity> Activities { get; set; } = new List<Activity>();

    [ForeignKey("CityId")]
    [InverseProperty("Events")]
    public virtual City City { get; set; } = null!;
}
