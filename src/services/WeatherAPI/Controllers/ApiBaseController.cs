// API base controller

using Microsoft.AspNetCore.Mvc;
using WeatherAPI.Domain.Entities;


[Route("api/")]
public class ApiBaseController<T>: ControllerBase where T :BaseEntity
{
    protected readonly ILogger<T> _logger;

    public ApiBaseController(ILogger<T> logger)
    {
        _logger = logger;
    }
}