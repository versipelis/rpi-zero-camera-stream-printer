#!/bin/bash

echo "==================================="
echo "Camera Stream with v4l2 + ffmpeg"
echo "==================================="

echo "Starting MJPEG stream on port 8080..."

while true; do
    (
        printf "HTTP/1.0 200 OK\r\n"
        printf "Content-Type: multipart/x-mixed-replace; boundary=ffmpeg\r\n"
        printf "Cache-Control: no-cache\r\n"
        printf "\r\n"
        ffmpeg -f v4l2 \
            -input_format yuyv422 \
            -video_size 640x480 \
            -framerate 10 \
            -i /dev/video0 \
            -vcodec mjpeg \
            -f mpjpeg \
            -q:v 5 \
            - 2>/dev/null
    ) | nc -l -p 8080 -q 1

    echo "Connection closed, restarting stream..."
    sleep 0
done
