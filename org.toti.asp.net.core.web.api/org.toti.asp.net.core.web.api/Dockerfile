#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["org.toti.asp.net.core.web.api/org.toti.asp.net.core.web.api.csproj", "org.toti.asp.net.core.web.api/"]
RUN dotnet restore "org.toti.asp.net.core.web.api/org.toti.asp.net.core.web.api.csproj"
COPY . .
WORKDIR "/src/org.toti.asp.net.core.web.api"
RUN dotnet build "org.toti.asp.net.core.web.api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "org.toti.asp.net.core.web.api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "org.toti.asp.net.core.web.api.dll"]