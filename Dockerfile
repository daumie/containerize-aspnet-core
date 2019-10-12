FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /src
COPY ["HelloAsspNetCore.csproj", "./"]
RUN dotnet restore "./HelloAsspNetCore.csproj"
COPY . .
RUN dotnet build "HelloAsspNetCore.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HelloAsspNetCore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloAsspNetCore.dll"]
