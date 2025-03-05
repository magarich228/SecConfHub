using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("moderator")]
public partial class Moderator
{
    [Key]
    [Column("user_id")]
    public int UserId { get; set; }

    [Column("activity_direction_id")]
    public int? ActivityDirectionId { get; set; }

    [Column("event_type_id")]
    public int? EventTypeId { get; set; }

    [InverseProperty("Moderator")]
    public virtual ICollection<ActivityDay> ActivityDays { get; set; } = new List<ActivityDay>();

    [ForeignKey("ActivityDirectionId")]
    [InverseProperty("Moderators")]
    public virtual ActivityDirection? ActivityDirection { get; set; }

    [ForeignKey("EventTypeId")]
    [InverseProperty("Moderators")]
    public virtual EventType? EventType { get; set; }

    [ForeignKey("UserId")]
    [InverseProperty("Moderator")]
    public virtual User User { get; set; } = null!;
}
