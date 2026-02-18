#!/bin/bash

echo "==================================="
echo "Camera Stream with v4l2 + ffmpeg"
echo "==================================="

echo ""
echo "Using /dev/video31 (JPEG support)"
echo "Starting MJPEG stream on port 8080..."
echo "Stream URL: http://<device-ip>:8080/"
echo ""

# Stream mit ffmpeg - nutzt direkt /dev/video31
while true; do
    ffmpeg -f v4l2 \
        -input_format mjpeg \
        -video_size 640x480 \
        -framerate 15 \
        -i /dev/video31 \
        -f mpjpeg \
        -q:v 5 \
        - | nc -l -p 8080 -q 1
    
    echo "Connection closed, restarting stream..."
    sleep 1
done
