# We use this stage to build/prepare the dotnet app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-stage
WORKDIR /ausemartweb
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# We use this stage to serve the app
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /ausemartweb
COPY --from=build-stage /ausemartweb/out .
ENTRYPOINT ["dotnet", "ausemartweb.dll"]
