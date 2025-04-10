# Use the official .NET 5 SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# Copy the project files and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the remaining files and build the application
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official ASP.NET Core runtime image to run the application
# We don’t need the SDK anymore. This image is smaller and only includes what's needed to run the app.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Expose the port the application runs on
EXPOSE 5000

# Define the entry point for the container
ENTRYPOINT ["dotnet", "dockeraizedProject.dll"]
