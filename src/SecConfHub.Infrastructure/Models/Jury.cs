using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("jury")]
public partial class Jury
{
    [Key]
    [Column("user_id")]
    public int UserId { get; set; }

    [Column("activity_direction_id")]
    public int? ActivityDirectionId { get; set; }

    [ForeignKey("ActivityDirectionId")]
    [InverseProperty("Juries")]
    public virtual ActivityDirection? ActivityDirection { get; set; }

    [ForeignKey("UserId")]
    [InverseProperty("Jury")]
    public virtual User User { get; set; } = null!;

    [ForeignKey("JuryId")]
    [InverseProperty("Juries")]
    public virtual ICollection<ActivityDay> ActivityDays { get; set; } = new List<ActivityDay>();
}
