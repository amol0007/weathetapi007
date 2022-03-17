#Get Base image (Full .Net Core SDK)
FROM mcr.microsoft.com/dotnet/sdk:5.0 As build-env
WORKDIR /app

#Copy .csproj and restore
COPY *.csproj ./
RUN dotnet restore

#Copy everything else and build
COPY . ./
RUN dotnet publish -c release -o out

#Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "WEATHERAPI.dll" ]



