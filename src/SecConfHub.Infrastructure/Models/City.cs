using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("city")]
[Index("Name", Name = "city_name_key", IsUnique = true)]
public partial class City
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("name")]
    [StringLength(100)]
    public string Name { get; set; } = null!;

    [Column("photo_path")]
    [StringLength(500)]
    public string? PhotoPath { get; set; }

    [InverseProperty("City")]
    public virtual ICollection<Event> Events { get; set; } = new List<Event>();
}
