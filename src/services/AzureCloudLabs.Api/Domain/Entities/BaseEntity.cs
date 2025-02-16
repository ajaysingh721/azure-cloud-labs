
namespace AzureCloudLabs.Api.Domain.Entities
{

    public class BaseEntity
    {
        public required string Id { get; set; }

        public DateTime CreatedAt { get; set; }
    }

}