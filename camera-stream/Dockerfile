FROM balenalib/raspberry-pi2-debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    v4l-utils \
    libraspberrypi-bin \
    libraspberrypi0 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install flask picamera2

# Set working directory
WORKDIR /app

# Copy application files
COPY start.sh /app/
COPY stream.py /app/

# Make start script executable
RUN chmod +x /app/start.sh

# Start the application
CMD ["/app/start.sh"]
