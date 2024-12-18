#!/bin/bash

# Функция для установки LibreOffice
install_libreoffice() {
    echo "LibreOffice не установлен. Устанавливаем LibreOffice..."
    sudo apt update
    sudo apt install -y libreoffice
}

# Проверка наличия LibreOffice
if ! command -v libreoffice &> /dev/null; then
    install_libreoffice
fi

# Определяем директории
input_dir="word"
output_dir="pdf"

# Создаем выходную директорию, если она не существует
mkdir -p "$output_dir"

# Проверяем наличие файлов DOCX в входной директории
shopt -s nullglob  # Включаем режим, чтобы избежать ошибок при отсутствии файлов
docx_files=("$input_dir"/*.docx)

if [ ${#docx_files[@]} -eq 0 ]; then
    echo "В папке '$input_dir' нет файлов DOCX для конвертации."
    exit 1
fi

# Конвертация каждого файла DOCX в PDF
for file in "${docx_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "Конвертация '$file' в PDF..."
        libreoffice --headless --convert-to pdf --outdir "$output_dir" "$file"
        echo "Файл '$file' успешно сконвертирован в PDF и помещен в '$output_dir'."
    else
        echo "Файл '$file' не найден."
    fi
done

echo "Конвертация файлов из word в pfd завершена."
