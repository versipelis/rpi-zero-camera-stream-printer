#!/bin/bash

echo "==================================="
echo "Camera Stream with v4l2 + ffmpeg"
echo "==================================="

echo "Starting MJPEG stream on port 8080..."

while true; do
    ffmpeg -f v4l2 \
        -input_format yuv420p \
        -video_size 640x480 \
        -framerate 15 \
        -i /dev/video0 \
        -vcodec mjpeg \
        -f mpjpeg \
        -q:v 5 \
        - | nc -l -p 8080 -q 1
    
    echo "Connection closed, restarting stream..."
    sleep 1
done
