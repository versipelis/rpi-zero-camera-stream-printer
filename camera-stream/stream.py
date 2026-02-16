#!/usr/bin/env python3
import io
import os
from threading import Condition
from flask import Flask, Response
from picamera2 import Picamera2
from picamera2.encoders import JpegEncoder
from picamera2.outputs import FileOutput

app = Flask(__name__)

# Get configuration from environment variables
RESOLUTION = os.getenv('RESOLUTION', '1640x1232')
FRAMERATE = int(os.getenv('FRAMERATE', '15'))
QUALITY = int(os.getenv('QUALITY', '85'))

# Parse resolution
width, height = map(int, RESOLUTION.split('x'))

class StreamingOutput(io.BufferedIOBase):
    def __init__(self):
        self.frame = None
        self.condition = Condition()

    def write(self, buf):
        with self.condition:
            self.frame = buf
            self.condition.notify_all()

def gen_frames():
    output = StreamingOutput()
    picam2 = Picamera2()
    
    # Configure camera
    config = picam2.create_video_configuration(
        main={"size": (width, height), "format": "RGB888"}
    )
    picam2.configure(config)
    
    # Start recording
    encoder = JpegEncoder(q=QUALITY)
    picam2.start_recording(encoder, FileOutput(output))
    
    try:
        while True:
            with output.condition:
                output.condition.wait()
                frame = output.frame
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
    finally:
        picam2.stop_recording()

@app.route('/')
def index():
    return '''
    <html>
        <head>
            <title>Camera Stream</title>
        </head>
        <body>
            <h1>Raspberry Pi Camera Stream</h1>
            <img src="/stream" width="100%">
            <p>Stream URL: <code>http://&lt;device-ip&gt;:8080/stream</code></p>
        </body>
    </html>
    '''

@app.route('/stream')
def video_feed():
    return Response(gen_frames(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/snapshot')
def snapshot():
    """Single JPEG snapshot endpoint for compatibility"""
    picam2 = Picamera2()
    config = picam2.create_still_configuration(
        main={"size": (width, height)}
    )
    picam2.configure(config)
    picam2.start()
    
    stream = io.BytesIO()
    picam2.capture_file(stream, format='jpeg')
    picam2.stop()
    
    stream.seek(0)
    return Response(stream.read(), mimetype='image/jpeg')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, threaded=True)
