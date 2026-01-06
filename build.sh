#!/usr/bin/env bash
# build.sh

# Безопасность - скрипт остановится при любой ошибке
set -o errexit

# Показывает выполняемые команды в логах
set -o xtrace

# Установка зависимостей
pip install -r requirements.txt

# Сбор статических файлов - копирование всех CSS, JS, изображений в одну папку staticfiles
python manage.py collectstatic --noinput

# Применение миграции базы данных
python manage.py migrate