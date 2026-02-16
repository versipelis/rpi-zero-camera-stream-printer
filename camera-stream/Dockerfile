FROM balenalib/raspberry-pi2-debian:bullseye

# Install only essentials
RUN install_packages \
    v4l-utils \
    ffmpeg

# Set working directory
WORKDIR /app

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080

CMD ["/app/start.sh"]
