using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("activity")]
public partial class Activity
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("event_id")]
    public int EventId { get; set; }

    [Column("winner_id")]
    public int? WinnerId { get; set; }

    [Column("days")]
    public int Days { get; set; }

    [InverseProperty("Activity")]
    public virtual ICollection<ActivityDay> ActivityDays { get; set; } = new List<ActivityDay>();

    [ForeignKey("EventId")]
    [InverseProperty("Activities")]
    public virtual Event Event { get; set; } = null!;

    [ForeignKey("WinnerId")]
    [InverseProperty("Activities")]
    public virtual User? Winner { get; set; }
}
