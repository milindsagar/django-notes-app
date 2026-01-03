# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# System dependencies (mysqlclient साठी)
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (better caching)
COPY requirements.txt .

# Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install gunicorn mysqlclient

# Copy project files
COPY . .

EXPOSE 8000
