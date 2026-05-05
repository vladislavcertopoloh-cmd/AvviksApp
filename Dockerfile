# Сборка
FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Копируем абсолютно всё, что есть в репозитории
COPY . .

# Переходим в папку с проектом (Render видит её в корне)
WORKDIR "/src/WebApplication1"

# Восстанавливаем и публикуем
RUN dotnet publish "WebApplication1.csproj" -c Release -o /app/publish

# Финальный образ
FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview
WORKDIR /app
COPY --from=build /app/publish .

# Запуск
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
