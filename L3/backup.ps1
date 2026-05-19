param(
    [string]$Path
)

# Функция вывода справки
function Show-Help {
    Write-Host @"
Использование: .\backup.ps1 <путь_к_папке>
Пример: .\backup.ps1 C:\Users\User\Pictures

Скопирует все изображения (jpg, jpeg, png, gif, heic) из указанной папки
и всех её подпапок в новую папку <имя_папки>_backup_<дата>
"@
}

# Проверка аргументов
if (-not $Path) {
    Write-Host "Ошибка: Не указан путь к папке"
    Show-Help
    exit 1
}

if ($Path -eq "-h" -or $Path -eq "--help") {
    Show-Help
    exit 0
}

# Проверка существования исходной папки
if (-not (Test-Path $Path -PathType Container)) {
    Write-Host "Ошибка: Папка '$Path' не существует"
    exit 1
}

# Путь для резервной копии
$Parent = Split-Path $Path -Parent
$FolderName = Split-Path $Path -Leaf
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$BackupName = "${FolderName}_backup_${Timestamp}"
$Destination = Join-Path $Parent $BackupName

# Создание папки назначения
Write-Host "Создаю папку для резервной копии: $Destination"
try {
    New-Item -ItemType Directory -Path $Destination -Force -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "Ошибка: Не удалось создать папку '$Destination'"
    exit 1
}

# Расширения изображений
$Extensions = @("*.jpg", "*.jpeg", "*.png", "*.gif", "*.heic")

Write-Host "Поиск изображений в '$Path'..."

$Count = 0

foreach ($ext in $Extensions) {
    $files = Get-ChildItem -Path $Path -Recurse -Filter $ext -File -ErrorAction SilentlyContinue
    foreach ($file in $files) {
        try {
            Copy-Item -Path $file.FullName -Destination $Destination -ErrorAction Stop
            $Count++
            Write-Host "[$Count] Скопировано: $($file.FullName)"
        }
        catch {
            Write-Host "Ошибка при копировании: $($file.FullName)"
        }
    }
}

# Результат
if ($Count -eq 0) {
    Write-Host "ВНИМАНИЕ: Изображения не найдены в папке '$Path'"
    Remove-Item -Path $Destination -Force -ErrorAction SilentlyContinue
    Write-Host "Пустая папка резервной копии удалена"
    exit 1
} else {
    Write-Host ""
    Write-Host "Готово: Резервное копирование завершено"
    Write-Host "Скопировано файлов: $Count"
    Write-Host "Папка назначения: $Destination"
    exit 0
}