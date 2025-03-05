using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SecConfHub.Infrastructure.Models;

[Table("country")]
[Index("Code", Name = "country_code_key", IsUnique = true)]
[Index("Name", Name = "country_name_key", IsUnique = true)]
[Index("NumCode", Name = "country_num_code_key", IsUnique = true)]
[Index("UniformName", Name = "country_uniform_name_key", IsUnique = true)]
public partial class Country
{
    [Key]
    [Column("id")]
    public int Id { get; set; }

    [Column("name")]
    [StringLength(150)]
    public string Name { get; set; } = null!;

    [Column("uniform_name")]
    [StringLength(150)]
    public string UniformName { get; set; } = null!;

    [Column("code")]
    [StringLength(2)]
    public string Code { get; set; } = null!;

    [Column("num_code")]
    public int NumCode { get; set; }

    [InverseProperty("Country")]
    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
