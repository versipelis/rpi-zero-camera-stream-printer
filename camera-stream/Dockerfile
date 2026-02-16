FROM balenalib/raspberry-pi2-debian:bullseye

# Install only motion - it's in Debian repos
RUN install_packages motion v4l-utils

WORKDIR /app
COPY motion.conf /app/motion.conf
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080 8081
CMD ["/app/start.sh"]
