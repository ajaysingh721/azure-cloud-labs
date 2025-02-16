using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using AzureCloudLabs.Api.Domain.Entities;
using AzureCloudLabs.Api.Context;
using Microsoft.EntityFrameworkCore;

namespace AzureCloudLabs.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class WeatherForecastController(ILogger<WeatherForecast> logger, AppDbContext appDbContext) : ApiBaseController<WeatherForecast>(logger)
{

    [HttpGet(Name = "GetWeatherForecast")]
    public async Task<IEnumerable<WeatherForecast>> Get()
    {
        return await appDbContext.WeatherForecasts.ToListAsync();
    }

    [HttpPost(Name = "CreateWeatherForecast")]
    public async Task<IActionResult> Post([FromBody] WeatherForecast weatherForecast)
    {
        this._logger.LogInformation("Create weather forecast fomr PI service");


        // GUID 
        weatherForecast.Id = Guid.NewGuid().ToString();

        var entity = await appDbContext.WeatherForecasts.AddAsync(weatherForecast);

        return Ok(entity);
    }
}
