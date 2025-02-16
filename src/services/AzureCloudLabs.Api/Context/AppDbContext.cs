using Microsoft.EntityFrameworkCore;

namespace AzureCloudLabs.Api.Context
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<WeatherForecast> WeatherForecasts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<WeatherForecast>()
                .ToContainer("WeatherForecast");

            modelBuilder.Entity<WeatherForecast>()
                .Property(p => p.Id)
                .ToJsonProperty("id");
        }
    }
}
