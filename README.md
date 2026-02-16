# Raspberry Pi Camera Stream for DuetWiFi

[![balena deploy button](https://www.balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/YOUR-USERNAME/rpi-camera-stream)

A Balena-deployable camera streaming service for Raspberry Pi Zero 2 W with CSI camera support (including night vision cameras). Designed to integrate with DuetWiFi 3D printer web interface.

## Version
Current version: **0.1.0** (see `balena.yml`)

## Features

- MJPEG stream over HTTP
- Night vision camera support
- Configurable resolution and framerate
- Easy deployment via Balena
- Compatible with DuetWiFi webcam integration
- One-click deployment button

## Hardware Requirements

- Raspberry Pi Zero 2 W
- CSI camera module (standard or night vision variant)
- MicroSD card (8GB+)

## Deployment

### Option 1: One-Click Deploy (Easiest!)

1. Click the **"Deploy with Balena"** button above
2. Log in to Balena Cloud (or create free account)
3. Create a new fleet for Raspberry Pi Zero 2 W
4. Flash BalenaOS to your SD card
5. Boot your Pi - it will auto-deploy!

### Option 2: Deploy with Balena Cloud

1. Create a Balena account at https://balena.io
2. Create a new fleet (application) for Raspberry Pi Zero 2 W
3. Add your device and flash the BalenaOS image to your SD card
4. Clone this repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/rpi-camera-stream.git
   cd rpi-camera-stream
   ```
5. Push to Balena:
   ```bash
   balena push <fleet-name>
   ```

### Option 3: Deploy with Balena CLI (local)

1. Install Balena CLI: https://github.com/balena-io/balena-cli
2. Clone this repository
3. Push to your device:
   ```bash
   balena push <device-ip>
   ```

## Configuration

Edit environment variables in the Balena dashboard or in `docker-compose.yml`:

- `RESOLUTION`: Camera resolution (default: `1640x1232`)
  - Common options: `1640x1232`, `1280x720`, `640x480`
- `FRAMERATE`: Frames per second (default: `15`)
  - Range: `1-30` (lower values reduce CPU load)
- `QUALITY`: JPEG quality (default: `85`)
  - Range: `1-100` (higher = better quality, larger bandwidth)

## Usage

### Accessing the Stream

Once deployed, the stream is available at:

- **Stream URL**: `http://<device-ip>:8080/stream`
- **Snapshot URL**: `http://<device-ip>:8080/snapshot`
- **Web Interface**: `http://<device-ip>:8080/`

### Integrating with DuetWiFi

1. Access your DuetWiFi web interface
2. Go to **Settings** > **Machine-Specific**
3. Add a webcam with the following settings:
   - **URL**: `http://<raspberry-pi-ip>:8080/stream`
   - Alternatively, for snapshot mode: `http://<raspberry-pi-ip>:8080/snapshot`
4. Save and refresh the page

The camera stream should now appear in your DuetWiFi interface!

## Troubleshooting

### Camera not detected

1. Check camera cable connection to CSI port
2. Verify camera is enabled:
   - SSH into device
   - Run: `vcgencmd get_camera`
   - Should show: `supported=1 detected=1`

### Stream not loading

1. Check device logs in Balena dashboard
2. Verify port 8080 is accessible (check firewall)
3. Try accessing `http://<device-ip>:8080/` directly

### Poor image quality

- Increase `QUALITY` environment variable (up to 100)
- Increase `RESOLUTION` for better detail
- Ensure adequate lighting (or verify night vision IR is working)

### High CPU usage / lag

- Decrease `RESOLUTION` (try `1280x720` or `640x480`)
- Decrease `FRAMERATE` (try `10` or `5`)
- Lower `QUALITY` setting

## Network Setup

For best performance:
- Use wired Ethernet via USB adapter (if available)
- Ensure Raspberry Pi and DuetWiFi are on the same network
- Consider setting a static IP for the Raspberry Pi

## File Structure

```
rpi-camera-stream/
├── balena.yml              # Version and project metadata
├── docker-compose.yml      # Balena service configuration
├── camera-stream/
│   ├── Dockerfile          # Container build instructions
│   ├── stream.py           # Python streaming application
│   └── start.sh            # Startup script
└── README.md               # This file
```

## Version History

- **0.1.0** (Initial Release)
  - MJPEG streaming support
  - Configurable resolution/framerate
  - Snapshot endpoint
  - DuetWiFi integration ready

## License

MIT License - feel free to modify and distribute

## Contributing

Pull requests welcome! Please update the version in `balena.yml` following semantic versioning.
