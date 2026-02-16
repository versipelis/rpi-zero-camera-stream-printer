FROM balenalib/raspberry-pi2-debian:bullseye as builder

# Build ffmpeg binary
RUN install_packages \
    build-essential \
    pkg-config \
    yasm \
    libx264-dev \
    wget

WORKDIR /tmp
RUN wget https://ffmpeg.org/releases/ffmpeg-4.4.tar.gz && \
    tar xzf ffmpeg-4.4.tar.gz && \
    cd ffmpeg-4.4 && \
    ./configure --enable-gpl --enable-libx264 --disable-doc --disable-htmlpages --disable-manpages && \
    make -j4 && \
    make install

# Final minimal image
FROM balenalib/raspberry-pi2-debian:bullseye

RUN install_packages v4l-utils
COPY --from=builder /usr/local/bin/ffmpeg /usr/local/bin/

WORKDIR /app
COPY start-simple.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
