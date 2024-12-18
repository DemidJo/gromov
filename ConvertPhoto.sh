# Функция для установки ImageMagick
install_imagemagick() {
    echo "ImageMagick не установлен. Устанавливаем ImageMagick..."
    sudo apt update
    sudo apt install -y imagemagick
}

# Проверка наличия ImageMagick
if ! command -v convert &> /dev/null; then
    install_imagemagick
fi

# Определяем директории
input_dir="img"
output_dir="jpeg"

# Создаем выходную директорию, если она не существует
mkdir -p "$output_dir"

# Проверяем наличие файлов изображений в входной директории
shopt -s nullglob  # Включаем режим, чтобы избежать ошибок при отсутствии файлов
image_files=("$input_dir"/*)

if [ ${#image_files[@]} -eq 0 ]; then
    echo "В папке '$input_dir' нет изображений для конвертации."
    exit 1
fi

# Конвертация каждого изображения в формат WebP
for file in "${image_files[@]}"; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        output_file="${output_dir}/${filename%.*}.jpeg"
        echo "Конвертация '$file' в '$output_file'..."
        convert "$file" "$output_file"
        echo "Файл '$file' успешно сконвертирован в '$output_file'."
    else
        echo "Файл '$file' не найден."
    fi
done

echo "Конвертация завершена."
