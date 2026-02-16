#!/bin/bash

# Load camera module
modprobe bcm2835-v4l2

# Wait for camera to be ready
sleep 2

# Start the streaming application
python3 /app/stream.py
