# .NET 5 Registration & Login API (Dockerized)

This project is a simple ASP.NET Core Web API for user registration and login, built with .NET 5 and containerized using Docker.  
It's based on [this original GitHub repo](https://github.com/cornflourblue/dotnet-5-registration-login-api).

---

## 🚀 How to Run with Docker

### 1. Build the Docker image:

```bash
docker build -t dockeraized-api .
```

### 2. Run the container:

```bash
docker run -d -p 5001:5000 dockeraized-api
```

### 3. Access the API:

Open your browser or Postman at:

```
http://localhost:5001
```

---

## 🐳 Dockerfile Explained

This project uses a **two-stage build** to separate building and running the application.

### Step 1: Build Stage

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app

# Copy project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy all files and build the project
COPY . ./
RUN dotnet publish -c Release -o out
```

### Step 2: Runtime Stage

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app

# Copy the compiled files from build stage
COPY --from=build /app/out ./

# Expose port 5000 inside the container
EXPOSE 5000

# Start the app when the container runs
ENTRYPOINT ["dotnet", "dockeraizedProject.dll"]
```

### ✅ Two-stage build:
- **First stage**: Builds and publishes the project  
- **Second stage**: Runs only the published output (smaller, faster image)

---

## 🙈 .gitignore Explained

The `.gitignore` file tells Git which files or folders not to track or upload to GitHub.  
This helps avoid committing unnecessary or sensitive files.

### Key Entries:

```gitignore
bin/
obj/
*.db
.vscode/
.env
```

### What they do:
- `bin/`, `obj/` → compiled binaries  
- `*.db` → any local database file  
- `.vscode/` → personal editor settings  
- `.env` → environment variable files (like secrets)
