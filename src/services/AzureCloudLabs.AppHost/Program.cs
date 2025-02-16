using Aspire.Hosting;

var builder = DistributedApplication.CreateBuilder(args);

var cosmos = builder.AddAzureCosmosDB(name: "cosmos-db")
    .AddDatabase("StoreDb")
    .WithExternalHttpEndpoints()
    .RunAsEmulator(emulator=>emulator.WithLifetime(ContainerLifetime.Persistent));

var webapi = builder.AddProject<Projects.AzureCloudLabs_Api>("azurecloudlabs-api")
       .WithExternalHttpEndpoints()
       .WithReference(cosmos)
       .WaitFor(cosmos);

builder.AddNodeApp("azurecloudlabs-web", "../../web/AzureCloudLabs.Web")
    .WithReference(webapi)
    .WaitFor(webapi)
    .WithHttpEndpoint(env: "PORT");

builder.Build().Run();
