#!/bin/bash

echo "==================================="
echo "Camera Stream mit rpicam-vid"
echo "==================================="
echo "Starting MJPEG stream on port 8080..."

while true; do
    rpicam-vid -t 0 --inline \
        --width 640 --height 480 \
        --codec mjpeg \
        -o - | nc -l -p 8080
    echo "Connection closed, restarting..."
    sleep 1
done
