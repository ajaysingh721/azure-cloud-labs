using AzureCloudLabs.Api.Domain.Entities;

namespace AzureCloudLabs.Api;

public class WeatherForecast : BaseEntity
{
    public DateTime Date { get; set; }

    public int TemperatureC { get; set; }

    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);

    public string? Summary { get; set; }
}
