#!/usr/bin/env python3
"""
Simple demo server to showcase the Silsilah App Flutter project structure.
This serves the project files and provides a web interface to explore the codebase.
"""

import http.server
import socketserver
import os
import json
from urllib.parse import urlparse, parse_qs
import mimetypes

class SilsilahDemoHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory="/workspace/alhands-map-silsilah", **kwargs)
    
    def do_GET(self):
        parsed_path = urlparse(self.path)
        
        if parsed_path.path == '/':
            self.send_demo_page()
        elif parsed_path.path == '/api/project-structure':
            self.send_project_structure()
        elif parsed_path.path == '/api/file-content':
            query = parse_qs(parsed_path.query)
            file_path = query.get('path', [''])[0]
            self.send_file_content(file_path)
        else:
            super().do_GET()
    
    def send_demo_page(self):
        html_content = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Silsilah App - Flutter Project Demo</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 20px; 
        }
        .header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }
        .header h1 {
            color: #2c3e50;
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        .header p {
            color: #7f8c8d;
            font-size: 1.2em;
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-card h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.3em;
        }
        .feature-card ul {
            list-style: none;
        }
        .feature-card li {
            padding: 5px 0;
            color: #555;
        }
        .feature-card li:before {
            content: "✓ ";
            color: #27ae60;
            font-weight: bold;
        }
        .project-explorer {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .project-explorer h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .file-tree {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            max-height: 400px;
            overflow-y: auto;
        }
        .file-item {
            padding: 3px 0;
            cursor: pointer;
            transition: background 0.2s;
        }
        .file-item:hover {
            background: #e9ecef;
        }
        .folder { color: #3498db; font-weight: bold; }
        .dart-file { color: #0175c2; }
        .config-file { color: #e67e22; }
        .doc-file { color: #27ae60; }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .stat-card {
            background: #3498db;
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            display: block;
        }
        .links {
            margin-top: 30px;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            margin: 0 10px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #2980b9;
        }
        .btn.secondary {
            background: #95a5a6;
        }
        .btn.secondary:hover {
            background: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🌳 Silsilah App</h1>
            <p>Modern Family Tree Gallery with Clean Architecture & GetX</p>
        </div>
        
        <div class="features">
            <div class="feature-card">
                <h3>🏗️ Architecture</h3>
                <ul>
                    <li>Clean Architecture Pattern</li>
                    <li>GetX State Management</li>
                    <li>GoRouter Navigation</li>
                    <li>Dependency Injection</li>
                    <li>Repository Pattern</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>🗺️ Map Features</h3>
                <ul>
                    <li>OpenStreetMap (Free Users)</li>
                    <li>Mapbox SDK (Premium Users)</li>
                    <li>Family Member Markers</li>
                    <li>Search & Filter</li>
                    <li>Location Details</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>📱 UI/UX</h3>
                <ul>
                    <li>Material Design 3</li>
                    <li>Light/Dark Themes</li>
                    <li>Responsive Layout</li>
                    <li>Smooth Animations</li>
                    <li>Indonesian Localization</li>
                </ul>
            </div>
            
            <div class="feature-card">
                <h3>🔐 Authentication</h3>
                <ul>
                    <li>Demo Login System</li>
                    <li>Free/Premium Roles</li>
                    <li>Feature Access Control</li>
                    <li>Local Storage</li>
                    <li>Session Management</li>
                </ul>
            </div>
        </div>
        
        <div class="project-explorer">
            <h2>📁 Project Structure</h2>
            <div class="file-tree" id="fileTree">
                <div class="file-item folder">📁 lib/</div>
                <div class="file-item folder" style="margin-left: 20px;">📁 core/</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 constants/app_constants.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 themes/app_theme.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 error/failures.dart</div>
                <div class="file-item folder" style="margin-left: 20px;">📁 data/</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 datasources/mock_data_source.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 models/family_member_model.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 repositories/family_repository_impl.dart</div>
                <div class="file-item folder" style="margin-left: 20px;">📁 domain/</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 entities/family_member.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 usecases/get_family_members.dart</div>
                <div class="file-item folder" style="margin-left: 20px;">📁 presentation/</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 controllers/family_map_controller.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 pages/family_map_page.dart</div>
                <div class="file-item dart-file" style="margin-left: 40px;">📄 components/family_member_marker.dart</div>
                <div class="file-item dart-file" style="margin-left: 20px;">📄 main.dart</div>
                <div class="file-item folder">📁 android/</div>
                <div class="file-item folder">📁 ios/</div>
                <div class="file-item folder">📁 web/</div>
                <div class="file-item config-file">📄 pubspec.yaml</div>
                <div class="file-item doc-file">📄 README.md</div>
            </div>
            
            <div class="stats">
                <div class="stat-card">
                    <span class="stat-number">28+</span>
                    Dart Files
                </div>
                <div class="stat-card">
                    <span class="stat-number">55+</span>
                    Mock Family Members
                </div>
                <div class="stat-card">
                    <span class="stat-number">5</span>
                    Main Features
                </div>
                <div class="stat-card">
                    <span class="stat-number">3</span>
                    Platforms
                </div>
            </div>
        </div>
        
        <div class="links">
            <a href="/README.md" class="btn">📖 Documentation</a>
            <a href="/flutter_project_setup.md" class="btn">🚀 Setup Guide</a>
            <a href="/lib/" class="btn secondary">📁 Browse Code</a>
            <a href="https://github.com/ilisium-tech/alhands-map-silsilah" class="btn secondary">🔗 GitHub</a>
        </div>
    </div>
</body>
</html>
        """
        
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(html_content.encode())
    
    def send_project_structure(self):
        # This would return the project structure as JSON
        structure = {
            "lib": {
                "core": ["constants", "themes", "error"],
                "data": ["datasources", "models", "repositories"],
                "domain": ["entities", "usecases", "repositories"],
                "presentation": ["controllers", "pages", "components"],
                "routes": ["app_router.dart"]
            }
        }
        
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(structure).encode())
    
    def send_file_content(self, file_path):
        try:
            full_path = os.path.join("/workspace/alhands-map-silsilah", file_path.lstrip('/'))
            if os.path.exists(full_path) and os.path.isfile(full_path):
                with open(full_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                self.send_response(200)
                self.send_header('Content-type', 'text/plain')
                self.end_headers()
                self.wfile.write(content.encode())
            else:
                self.send_error(404, "File not found")
        except Exception as e:
            self.send_error(500, str(e))

if __name__ == "__main__":
    PORT = 12000
    
    with socketserver.TCPServer(("0.0.0.0", PORT), SilsilahDemoHandler) as httpd:
        print(f"🌳 Silsilah App Demo Server running at:")
        print(f"   Local: http://localhost:{PORT}")
        print(f"   Network: https://work-1-blxreqrywvtalzvk.prod-runtime.all-hands.dev")
        print(f"\n📁 Serving Flutter project from: /workspace/alhands-map-silsilah")
        print(f"🚀 Ready to explore the Silsilah App codebase!")
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print(f"\n👋 Server stopped.")