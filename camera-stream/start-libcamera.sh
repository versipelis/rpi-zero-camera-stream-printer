#!/bin/bash

echo "==================================="
echo "Camera Debug & Stream"
echo "==================================="

echo ""
echo "Available video devices:"
ls -la /dev/video*

echo ""
echo "Testing video devices with v4l2-ctl:"
for dev in /dev/video*; do
    echo "--- Device: $dev ---"
    v4l2-ctl --device=$dev --list-formats-ext 2>/dev/null || echo "No formats available"
done

echo ""
echo "Checking for cameras with libcamera:"
libcamera-hello --list-cameras

echo ""
echo "Starting MJPEG stream on port 8080..."
libcamera-vid -t 0 --width 640 --height 480 --codec mjpeg --inline -o - | nc -l -p 8080 -k
