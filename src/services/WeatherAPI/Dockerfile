# Dickerfile WeatherAPI

# Use the official image as a parent image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base

# Set the working directory in the container
WORKDIR /app
EXPOSE 8080

VOLUME [ "$env:USERPROFILR\.aspnet\https:/https/" ]

ENV ASPNETCORE_URLS="https://+;http://+"
ENV COMPlus_EnableDiagnostics=0
ENV ASPNETCORE_HTTPS_PORTS=8081
ENV ASPNETCORE_Kestrel__Certificates__Default__Password=$env:PWD
ENV ASPNETCORE_Kestrel__Certificates__Default__Path=$env:USERPROFILR\.aspnet\https\aspnetapp.pfx


# Copy the source code into the container
COPY . .

# Build the application

# Use the official image as a parent image
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Set the working directory in the container

WORKDIR /src

# Copy the source code into the container

COPY . .

# Build the application

RUN dotnet build "WeatherAPI.csproj" -c Release -o /app/build

# Publish the application

FROM build AS publish

RUN dotnet publish "WeatherAPI.csproj" -c Release -o /app/publish

# Final image

FROM base AS final

WORKDIR /app

COPY --from=publish /app/publish .

# Run the application

ENTRYPOINT ["dotnet", "WeatherAPI.dll"]

