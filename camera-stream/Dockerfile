FROM balenalib/raspberry-pi2-debian:bookworm

RUN install_packages curl gnupg ca-certificates

RUN curl -fsSL https://archive.raspberrypi.com/debian/raspberrypi.gpg.key | \
    gpg --dearmor -o /usr/share/keyrings/raspberrypi-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/raspberrypi-archive-keyring.gpg] https://archive.raspberrypi.com/debian/ bookworm main" \
    > /etc/apt/sources.list.d/raspi.list && \
    apt-get update && \
    apt-get install -y rpicam-apps python3 netcat-openbsd

WORKDIR /app
COPY start-libcamera.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
