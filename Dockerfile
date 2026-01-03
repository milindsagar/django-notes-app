# Base image
FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements first (better caching)
COPY requirements.txt .

# System dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Python dependencies
RUN pip install --upgrade pip
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

# Copy project files
COPY . .

# Expose Django port
EXPOSE 8000

# Start Django using Gunicorn (keeps container running)
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]
