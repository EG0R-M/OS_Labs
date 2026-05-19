#!/bin/bash

# Функция вывода справки
show_help() {
    echo "Использование: $0 <путь_к_папке>"
    echo "Пример: $0 /home/user/photos"
    echo ""
    echo "Скопирует все изображения (jpg, jpeg, png, gif, heic) из указанной папки"
    echo "и всех её подпапок в новую папку <имя_папки>_backup_<дата>"
}

# Проверка аргументов
if [ -z "$1" ]; then
    echo "Ошибка: Не указан путь к папке"
    show_help
    exit 1
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

SRC="$1"
PARENT=$(dirname "$SRC")
BASENAME=$(basename "$SRC")
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_NAME="${BASENAME}_backup_${TIMESTAMP}"
DST="${PARENT}/${BACKUP_NAME}"

# Проверка существования исходной папки
if [ ! -d "$SRC" ]; then
    echo "Ошибка: Папка '$SRC' не существует"
    exit 1
fi

# Создание папки назначения
echo "Создаю папку для резервной копии: $DST"
mkdir -p "$DST"
if [ $? -ne 0 ]; then
    echo "Ошибка: Не удалось создать папку '$DST'"
    exit 1
fi

# Расширения изображений
EXTENSIONS=("jpg" "jpeg" "png" "gif" "heic")

# Построение аргументов для find
FIND_ARGS=()
for ext in "${EXTENSIONS[@]}"; do
    FIND_ARGS+=(-iname "*.$ext" -o)
done

unset 'FIND_ARGS[${#FIND_ARGS[@]}-1]'

echo "Поиск изображений в '$SRC'..."

COUNT=0

# Поиск и копирование с безопасной обработкой пробелов и спецсимволов
while IFS= read -r -d '' file; do
    cp "$file" "$DST/"
    if [ $? -eq 0 ]; then
        COUNT=$((COUNT + 1))
        echo "[$COUNT] Скопировано: $file"
    else
        echo "Ошибка при копировании: $file"
    fi
done < <(find "$SRC" -type f \( "${FIND_ARGS[@]}" \) -print0 2>/dev/null)

# Результат
if [ $COUNT -eq 0 ]; then
    echo "ВНИМАНИЕ: Изображения не найдены в папке '$SRC'"
    rmdir "$DST" 2>/dev/null
    echo "Пустая папка резервной копии удалена"
    exit 1
else
    echo ""
    echo "Готово: Резервное копирование завершено"
    echo "Скопировано файлов: $COUNT"
    echo "Папка назначения: $DST"
    exit 0
fi