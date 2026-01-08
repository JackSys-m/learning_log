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

# Создание суперпользователя, если не существует
echo "=== Creating superuser ==="
python manage.py shell -c "
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='ll_admin').exists():
    User.objects.create_superuser(
        username='ll_admin',
        email='admin@example.com',
        password='${ADMIN_PASSWORD}'
    )
    print('Superuser created successfully')
else:
    print('Superuser already exists')
"