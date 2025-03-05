using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("activity_directions")]
[Index("Name", Name = "activity_directions_name_key", IsUnique = true)]
public partial class ActivityDirection
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("name")]
    [StringLength(100)]
    public string Name { get; set; } = null!;

    [InverseProperty("ActivityDirection")]
    public virtual ICollection<Jury> Juries { get; set; } = new List<Jury>();

    [InverseProperty("ActivityDirection")]
    public virtual ICollection<Moderator> Moderators { get; set; } = new List<Moderator>();
}
