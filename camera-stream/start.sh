#!/bin/bash

# Get configuration from environment
RESOLUTION=${RESOLUTION:-1280x720}
FRAMERATE=${FRAMERATE:-10}

echo "Starting camera stream with ffmpeg"
echo "Resolution: $RESOLUTION"
echo "Framerate: $FRAMERATE fps"

# Load camera module
modprobe bcm2835-v4l2

# Wait for camera
sleep 3

# Stream with ffmpeg (viel kleiner und schneller!)
ffmpeg -f v4l2 \
    -input_format h264 \
    -video_size $RESOLUTION \
    -framerate $FRAMERATE \
    -i /dev/video0 \
    -f mpjpeg \
    -q:v 5 \
    -listen 1 \
    http://0.0.0.0:8080/stream
