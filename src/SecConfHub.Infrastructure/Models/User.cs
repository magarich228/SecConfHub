using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("user")]
public partial class User
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("full_name")]
    [StringLength(200)]
    public string FullName { get; set; } = null!;

    [Column("birth")]
    public DateOnly Birth { get; set; }

    [Column("country_id")]
    public int? CountryId { get; set; }

    [Column("phone")]
    public string Phone { get; set; } = null!;

    [Column("pass", TypeName = "character varying")]
    public string Pass { get; set; } = null!;

    [Column("photo_path", TypeName = "character varying")]
    public string? PhotoPath { get; set; }

    [InverseProperty("Winner")]
    public virtual ICollection<Activity> Activities { get; set; } = new List<Activity>();

    [ForeignKey("CountryId")]
    [InverseProperty("Users")]
    public virtual Country? Country { get; set; }

    [InverseProperty("User")]
    public virtual Jury? Jury { get; set; }

    [InverseProperty("User")]
    public virtual Moderator? Moderator { get; set; }
}
