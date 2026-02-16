FROM balenalib/raspberry-pi2-alpine:latest

# Install minimal packages
RUN apk add --no-cache \
    bash \
    v4l-utils \
    wget

# Download pre-built mjpg-streamer
RUN wget -O /tmp/mjpg-streamer.tar.gz \
    https://github.com/jacksonliam/mjpg-streamer/releases/download/v1.0/mjpg-streamer-rpi.tar.gz || \
    (apk add git make gcc musl-dev libjpeg-turbo-dev cmake && \
     cd /tmp && \
     git clone --depth 1 https://github.com/jacksonliam/mjpg-streamer.git && \
     cd mjpg-streamer/mjpg-streamer-experimental && \
     make && \
     make install)

WORKDIR /app
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
