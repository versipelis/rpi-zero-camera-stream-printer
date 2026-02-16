FROM balenalib/raspberry-pi2-debian:bullseye

# Install dependencies
RUN install_packages \
    build-essential \
    cmake \
    git \
    libjpeg62-turbo-dev \
    imagemagick \
    v4l-utils \
    && apt-get clean

# Clone and build mjpg-streamer
WORKDIR /tmp
RUN git clone https://github.com/jacksonliam/mjpg-streamer.git && \
    cd mjpg-streamer/mjpg-streamer-experimental && \
    make && \
    make install

# Set working directory
WORKDIR /app

# Copy startup script
COPY start.sh /app/start.sh

# Make start script executable
RUN chmod +x /app/start.sh

# Expose port
EXPOSE 8080

# Start the application
CMD ["/app/start.sh"]
