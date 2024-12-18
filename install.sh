#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install apache2 -y
sudo apt install libreoffice -y

chmod +x ConvertWordToPdf.sh
chmod +x ConvertPhoto.sh
chmod +x apache.sh

echo "Конвертация файлов из word в pfd."
./ConvertWordToPdf.sh
echo "Конвертация изображений в jpeg"
./ConvertPhoto.sh
echo "Развёртка apache"
./apache.sh
