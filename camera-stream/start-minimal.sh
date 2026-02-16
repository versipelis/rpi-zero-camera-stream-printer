#!/bin/bash
modprobe bcm2835-v4l2
sleep 3

echo "Starting minimal MJPEG stream on port 8080"

while true; do
  v4l2-ctl --device=/dev/video0 --set-fmt-video=width=640,height=480,pixelformat=MJPG --stream-mmap --stream-to=- | nc -l -p 8080 -q 1
done
