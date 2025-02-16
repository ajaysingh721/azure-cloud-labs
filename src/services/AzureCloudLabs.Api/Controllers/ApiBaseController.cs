// API base controller

using Microsoft.AspNetCore.Mvc;
using AzureCloudLabs.Api.Domain.Entities;


[Route("api/[controllers]")]
public class ApiBaseController<T>: ControllerBase where T :BaseEntity
{
    protected readonly ILogger<T> _logger;

    public ApiBaseController(ILogger<T> logger)
    {
        _logger = logger;
    }
}