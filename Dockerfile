﻿FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["WebAPl/WebAPl.csproj", "WebAPl/"]
COPY ["Application/Application.csproj", "Application/"]
COPY ["Domain/Domain.csproj", "Domain/"]
COPY ["FileData/FileData.csproj", "FileData/"]
RUN dotnet restore "WebAPl/WebAPl.csproj"
COPY . .
WORKDIR "/src/WebAPl"
RUN dotnet build "WebAPl.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebAPl.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebAPl.dll"]
