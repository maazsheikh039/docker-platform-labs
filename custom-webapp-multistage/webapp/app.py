#!/usr/bin/env python3
import http.server, socketserver, os
from datetime import datetime

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/': self.path = '/index.html'
        elif self.path == '/health':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(f'{{"status": "healthy", "timestamp": "{datetime.now().isoformat()}"}}'.encode())
            return
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

PORT = int(os.environ.get('PORT', 8080))
with socketserver.TCPServer(("", PORT), CustomHandler) as httpd:
    print(f"Server running at http://localhost:{PORT}")
    httpd.serve_forever()
