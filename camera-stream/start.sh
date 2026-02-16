#!/bin/bash
modprobe bcm2835-v4l2
sleep 3
motion -c /app/motion.conf
```

**Das Image ist nur ~50-70MB!** Download in 2-3 Minuten über WLAN.

**Stream URL für DuetWiFi:**
```
http://<pi-ip>:8081/
