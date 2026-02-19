FROM balenalib/raspberry-pi2-debian:bullseye

RUN install_packages \
    ffmpeg \
    v4l-utils \
    netcat-openbsd

WORKDIR /app
COPY start-libcamera.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
