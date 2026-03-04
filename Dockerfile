FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies (remove mysqlclient if you don't need it)
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000
CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000"]