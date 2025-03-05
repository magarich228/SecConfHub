using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("activity_day")]
public partial class ActivityDay
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("title")]
    [StringLength(100)]
    public string Title { get; set; } = null!;

    [Column("day_num")]
    public int DayNum { get; set; }

    [Column("start_time")]
    public TimeOnly StartTime { get; set; }

    [Column("moderator_id")]
    public int? ModeratorId { get; set; }

    [Column("activity_id")]
    public int ActivityId { get; set; }

    [ForeignKey("ActivityId")]
    [InverseProperty("ActivityDays")]
    public virtual Activity Activity { get; set; } = null!;

    [ForeignKey("ModeratorId")]
    [InverseProperty("ActivityDays")]
    public virtual Moderator? Moderator { get; set; }

    [ForeignKey("ActivityDayId")]
    [InverseProperty("ActivityDays")]
    public virtual ICollection<Jury> Juries { get; set; } = new List<Jury>();
}
