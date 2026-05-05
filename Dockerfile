FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Копируем всё содержимое репозитория
COPY . .

# Переходим в папку, где лежит код, и собираем
RUN cd WebApplication1 && dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview
WORKDIR /app
COPY --from=build /app/publish .

# Запуск (проверь, что файл называется именно так)
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
