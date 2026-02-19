#!/bin/bash

echo "==================================="
echo "Camera Stream with v4l2 + ffmpeg"
echo "==================================="
echo "Starting MJPEG stream on port 8080..."

python3 - <<'EOF'
import subprocess
import socket

def handle_client(conn):
    try:
        conn.recv(1024)
        conn.sendall(b"HTTP/1.0 200 OK\r\n")
        conn.sendall(b"Content-Type: multipart/x-mixed-replace; boundary=frame\r\n\r\n")
        
        ffmpeg = subprocess.Popen([
            'ffmpeg', '-f', 'v4l2',
            '-video_size', '640x480',
            '-framerate', '5',
            '-i', '/dev/video0',
            '-vf', 'format=yuv420p',
            '-vcodec', 'mpjpeg',
            '-f', 'mjpeg',
            '-q:v', '10',
            '-'
        ], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
        
        while True:
            data = ffmpeg.stdout.read(4096)
            if not data:
                break
            conn.sendall(data)
    except:
        pass
    finally:
        try:
            ffmpeg.kill()
        except:
            pass
        conn.close()

server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', 8080))
server.listen(1)
print("Listening on port 8080...")

while True:
    conn, addr = server.accept()
    print(f"Connection from {addr}")
    handle_client(conn)
EOF
