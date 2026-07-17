FROM python:3.10-slim
WORKDIR /app

# Копіюємо файл залежностей у робочу директорію
COPY requirements.txt .

# Встановлюємо всі Python-залежності без збереження кешу для зменшення розміру образу
RUN pip install --no-cache-dir -r requirements.txt

# Задаємо змінні середовища для підключення до PostgreSQL
ENV POSTGRES_HOST=${POSTGRES_HOST}
ENV POSTGRES_PORT=${POSTGRES_PORT}
ENV POSTGRES_NAME=${POSTGRES_NAME}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Копіюємо всі файли нашого локального проєкту Django в контейнер
COPY . .

# Команда для запуску сервера розробника Django на порту 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]