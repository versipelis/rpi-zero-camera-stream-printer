FROM balenalib/raspberry-pi2-debian:bullseye

# Install system dependencies
RUN install_packages \
    python3 \
    python3-pip \
    python3-picamera2 \
    python3-libcamera \
    python3-kms++ \
    libcamera-apps \
    v4l-utils \
    && apt-get clean

# Install Flask
RUN pip3 install --no-cache-dir flask

# Set working directory
WORKDIR /app

# Copy application files
COPY start.sh /app/
COPY stream.py /app/

# Make start script executable
RUN chmod +x /app/start.sh

# Start the application
CMD ["/app/start.sh"]
