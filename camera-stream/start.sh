#!/bin/bash

# Get configuration from environment
RESOLUTION=${RESOLUTION:-1640x1232}
FRAMERATE=${FRAMERATE:-15}
QUALITY=${QUALITY:-85}

echo "Starting camera stream with:"
echo "  Resolution: $RESOLUTION"
echo "  Framerate: $FRAMERATE fps"
echo "  Quality: $QUALITY"

# Load camera module
modprobe bcm2835-v4l2

# Wait for camera device
sleep 3

# Start mjpg-streamer
/usr/local/bin/mjpg_streamer \
    -i "/usr/local/lib/mjpg-streamer/input_uvc.so -d /dev/video0 -r $RESOLUTION -f $FRAMERATE -q $QUALITY" \
    -o "/usr/local/lib/mjpg-streamer/output_http.so -p 8080 -w /usr/local/share/mjpg-streamer/www"
```

## 3. LÖSCHE die Datei `camera-stream/stream.py`

Sie wird nicht mehr gebraucht!

---

## Die anderen Dateien bleiben gleich:
- `balena.yml` - unverändert
- `docker-compose.yml` - unverändert  
- `.gitignore` - unverändert

## Wichtig für DuetWiFi:

Nach dem Deploy nutze diese URLs:

**Stream URL für DuetWiFi:**
```
http://<raspberry-pi-ip>:8080/?action=stream
```

**Snapshot URL:**
```
http://<raspberry-pi-ip>:8080/?action=snapshot
