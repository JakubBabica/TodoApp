FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["FileData/FileData.csproj", "FileData/"]
COPY ["Application/Application.csproj", "Application/"]
COPY ["Domain/Domain.csproj", "Domain/"]
RUN dotnet restore "FileData/FileData.csproj"
COPY . .
WORKDIR "/src/FileData"
RUN dotnet build "FileData.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "FileData.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FileData.dll"]
