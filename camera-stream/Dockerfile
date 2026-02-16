FROM balenalib/raspberry-pi2-debian:bullseye

RUN install_packages v4l-utils netcat-openbsd

WORKDIR /app
COPY start-minimal.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
