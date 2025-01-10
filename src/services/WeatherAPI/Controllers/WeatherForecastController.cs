using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using WeatherAPI.Domain.Entities;

namespace WeatherAPI.Controllers;

[ApiController]
[Route("[controller]")]
public class WeatherForecastController(ILogger<WeatherForecast> logger) : ApiBaseController<WeatherForecast>(logger)
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    [HttpGet(Name = "GetWeatherForecast")]
    public IEnumerable<WeatherForecast> Get()u87yjh 1
    {
        this._logger.LogInformation("Get weather forecast fomr PI service");

        return Enumerable.Range(1, 5).Select(index => new WeatherForecast
        {
            Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            TemperatureC = Random.Shared.Next(-20, 55),
            Summary = Summaries[Random.Shared.Next(Summaries.Length)]
        })
        .ToArray();
    }
}
