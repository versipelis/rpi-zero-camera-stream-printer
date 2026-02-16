#!/bin/bash

# Initialize Git repository and create initial commit

echo "Initializing Git repository..."
git init

echo "Adding files..."
git add .

echo "Creating initial commit..."
git commit -m "Initial commit - v0.1.0

- Add Balena deployment configuration
- Add camera streaming service with Flask
- Support for CSI camera with night vision
- MJPEG stream endpoint for DuetWiFi integration
- Configurable resolution, framerate, and quality
- Add README with setup instructions"

echo ""
echo "Repository initialized!"
echo ""
echo "Next steps:"
echo "1. Create a new repository on GitHub"
echo "2. Run: git remote add origin <your-github-repo-url>"
echo "3. Run: git branch -M main"
echo "4. Run: git push -u origin main"
echo ""
echo "To deploy with Balena:"
echo "1. Install Balena CLI: npm install -g balena-cli"
echo "2. Login: balena login"
echo "3. Create fleet on balena.io for Raspberry Pi Zero 2 W"
echo "4. Push: balena push <fleet-name>"
