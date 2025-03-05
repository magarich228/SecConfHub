using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using SecConfHub.Infrastructure.Models;

namespace SecConfHub.Infrastructure.Context;

public partial class MyDbContext(DbContextOptions<MyDbContext> options) : DbContext(options)
{
    public virtual DbSet<Activity> Activities { get; set; } = null!;

    public virtual DbSet<ActivityDay> ActivityDays { get; set; } = null!;

    public virtual DbSet<ActivityDirection> ActivityDirections { get; set; } = null!;

    public virtual DbSet<City> Cities { get; set; } = null!;

    public virtual DbSet<Country> Countries { get; set; } = null!;

    public virtual DbSet<Event> Events { get; set; } = null!;

    public virtual DbSet<EventType> EventTypes { get; set; } = null!;

    public virtual DbSet<Jury> Juries { get; set; } = null!;

    public virtual DbSet<Moderator> Moderators { get; set; } = null!;

    public virtual DbSet<User> Users { get; set; } = null!;

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=SecConfHub;Username=postgres;Password=yougifted");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .HasPostgresEnum("gender_enum", new[] { "мужской", "женский" })
            .HasPostgresEnum("role_enum", new[] { "moderator", "jury", "organizer", "member" });

        modelBuilder.Entity<Activity>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("activity_pkey");

            entity.Property(e => e.Days).HasDefaultValue(1);

            entity.HasOne(d => d.Event).WithMany(p => p.Activities).HasConstraintName("activity_event_id_fkey");

            entity.HasOne(d => d.Winner).WithMany(p => p.Activities)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("activity_winner_id_fkey");
        });

        modelBuilder.Entity<ActivityDay>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("activity_day_pkey");

            entity.Property(e => e.DayNum).HasDefaultValue(1);

            entity.HasOne(d => d.Activity).WithMany(p => p.ActivityDays).HasConstraintName("activity_day_activity_id_fkey");

            entity.HasOne(d => d.Moderator).WithMany(p => p.ActivityDays)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("activity_day_moderator_id_fkey");

            entity.HasMany(d => d.Juries).WithMany(p => p.ActivityDays)
                .UsingEntity<Dictionary<string, object>>(
                    "ActivityDayJourior",
                    r => r.HasOne<Jury>().WithMany()
                        .HasForeignKey("JuryId")
                        .HasConstraintName("ativity_day_jouriors_jury_id_fkey"),
                    l => l.HasOne<ActivityDay>().WithMany()
                        .HasForeignKey("ActivityDayId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("activity_day_jouriors_activity_day_id_fkey"),
                    j =>
                    {
                        j.HasKey("ActivityDayId", "JuryId").HasName("ativity_day_jouriors_pkey");
                        j.ToTable("activity_day_jouriors");
                        j.IndexerProperty<int>("ActivityDayId").HasColumnName("activity_day_id");
                        j.IndexerProperty<int>("JuryId").HasColumnName("jury_id");
                    });
        });

        modelBuilder.Entity<ActivityDirection>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("activity_directions_pkey");
        });

        modelBuilder.Entity<City>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("city_pkey");
        });

        modelBuilder.Entity<Country>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("country_pkey");
        });

        modelBuilder.Entity<Event>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("event_pkey");

            entity.Property(e => e.Days).HasDefaultValue(1);

            entity.HasOne(d => d.City).WithMany(p => p.Events).HasConstraintName("event_city_id_fkey");
        });

        modelBuilder.Entity<EventType>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("event_types_pkey");
        });

        modelBuilder.Entity<Jury>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("jury_pkey");

            entity.Property(e => e.UserId).ValueGeneratedNever();

            entity.HasOne(d => d.ActivityDirection).WithMany(p => p.Juries)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("jury_activity_direction_id_fkey");

            entity.HasOne(d => d.User).WithOne(p => p.Jury).HasConstraintName("jury_user_id_fkey");
        });

        modelBuilder.Entity<Moderator>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("moderator_pkey");

            entity.Property(e => e.UserId).ValueGeneratedNever();

            entity.HasOne(d => d.ActivityDirection).WithMany(p => p.Moderators)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("moderator_activity_direction_id_fkey");

            entity.HasOne(d => d.EventType).WithMany(p => p.Moderators)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("moderator_event_type_id_fkey");

            entity.HasOne(d => d.User).WithOne(p => p.Moderator).HasConstraintName("moderator_user_id_fkey");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("user_pkey");

            entity.HasOne(d => d.Country).WithMany(p => p.Users).HasConstraintName("user_country_id_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
