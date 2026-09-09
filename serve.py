#!/usr/bin/env python3
import http.server
import socketserver
import os
import mimetypes

PORT = int(os.environ.get("PORT", "3000"))
DIRECTORY = "/export"

mimetypes.add_type("application/wasm", ".wasm")
mimetypes.add_type("application/javascript", ".js")

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        super().end_headers()

if __name__ == "__main__":
    with socketserver.TCPServer(("0.0.0.0", PORT), Handler) as httpd:
        print(f"Serving Godot web export at http://0.0.0.0:{PORT}")
        httpd.serve_forever()
