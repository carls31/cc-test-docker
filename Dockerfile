# Use official slim Python image
FROM python:3.11-slim

# avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system packages required by geospatial libs (GDAL, PROJ, GEOS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gdal-bin \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    proj-bin \
    pkg-config \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Point pip build to GDAL headers (helps build some wheels)
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal

# Copy and install python dependencies
COPY requirements.txt /tmp/requirements.txt

# upgrade pip & install wheels
RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
 && pip install --no-cache-dir -r /tmp/requirements.txt

# app workdir and copy code
WORKDIR /app
COPY src/ /app/src/

# Default command
CMD ["python", "src/main.py"]
