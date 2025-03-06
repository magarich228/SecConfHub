using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("event_types")]
[Index("Name", Name = "event_types_name_key", IsUnique = true)]
public partial class EventType
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("name")]
    [StringLength(100)]
    public string Name { get; set; } = null!;

    [InverseProperty("EventType")]
    public virtual ICollection<Event> Events { get; set; } = new List<Event>();

    [InverseProperty("EventType")]
    public virtual ICollection<Moderator> Moderators { get; set; } = new List<Moderator>();
}
