#!/bin/bash

echo "==================================="
echo "Camera Stream Starting..."
echo "==================================="

echo ""
echo "Checking for available cameras..."
libcamera-hello --list-cameras

echo ""
echo "Starting MJPEG stream on port 8080..."
echo "Stream URL: http://<device-ip>:8080/"
echo ""

# Stream mit keep-alive (-k flag bei nc)
libcamera-vid -t 0 --width 640 --height 480 --codec mjpeg --inline -o - | nc -l -p 8080 -k
