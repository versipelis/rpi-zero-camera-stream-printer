FROM balenalib/raspberry-pi2-alpine:latest

RUN apk add --no-cache bash v4l-utils motion

WORKDIR /app
COPY motion.conf /app/motion.conf
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080 8081
CMD ["/app/start.sh"]
