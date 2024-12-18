#!/bin/bash

# Путь к директории с HTML-файлом
html_dir="html"
html_file="web.html"

# Проверяем, существует ли директория и файл
if [ ! -d "$html_dir" ]; then
    echo "Директория '$html_dir' не найдена."
    exit 1
fi

if [ ! -f "$html_dir/$html_file" ]; then
    echo "Файл '$html_file' не найден в директории '$html_dir'."
    exit 1
fi

# Установка Apache, если он не установлен
install_apache() {
    echo "Apache не установлен. Устанавливаем Apache..."
    sudo apt update
    sudo apt install -y apache2
}

# Проверка наличия Apache
if ! command -v apache2 &> /dev/null; then
    install_apache
fi

# Копирование HTML-файла в директорию по умолчанию для Apache
default_index="/var/www/html/index.html"
sudo cp "$html_dir/$html_file" "$default_index"

# Перезапуск Apache
sudo systemctl restart apache2

echo "Стандартная страница Apache успешно заменена на '$html_file'. Вы можете получить доступ к сайту по адресу http://localhost/"
