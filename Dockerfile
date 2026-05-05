FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src

# Копируем вообще всё
COPY . .

# Ищем любой файл .csproj и собираем его, куда бы ты его ни положил
RUN dotnet publish $(find . -name "*.csproj" | head -n 1) -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview
WORKDIR /app
COPY --from=build /app/publish .

# Запуск (имя файла должно совпадать с тем, что в логах)
ENTRYPOINT ["dotnet", "WebApplication1.dll"]
