#!/bin/bash

echo "Loading camera module..."
modprobe bcm2835-v4l2

echo "Waiting for camera..."
sleep 3

echo "Starting Motion stream server..."
motion -c /app/motion.conf
