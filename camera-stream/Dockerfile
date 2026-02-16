FROM balenalib/raspberry-pi2-alpine:latest

# Minimal install
RUN apk add --no-cache bash v4l-utils motion

WORKDIR /app
COPY motion.conf /app/motion.conf
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080 8081
CMD ["/app/start.sh"]
```

## 2. `camera-stream/motion.conf` (NEU ERSTELLEN):
```
daemon off
process_id_file /var/run/motion/motion.pid
videodevice /dev/video0
v4l2_palette 17
width 1280
height 720
framerate 10
stream_port 8081
stream_localhost off
stream_motion off
webcontrol_port 8080
webcontrol_localhost off
output_pictures off
ffmpeg_output_movies off
