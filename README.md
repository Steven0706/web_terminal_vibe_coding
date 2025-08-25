# 🚀 Web Terminal - Browser-Based Development Environment for vibe coding

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue)](https://www.linux.org/)
[![Terminal](https://img.shields.io/badge/Terminal-ttyd-green)](https://github.com/tsl0922/ttyd)
[![IDE](https://img.shields.io/badge/IDE-VSCode-blue)](https://github.com/coder/code-server)

A comprehensive web-based development environment that brings terminal access, VS Code IDE, and voice transcription capabilities to your browser. Perfect for remote development, teaching, or accessing your development environment from any device.

![Web Terminal Interface](https://via.placeholder.com/800x400/667eea/ffffff?text=Web+Terminal+Interface)
<img width="1436" height="920" alt="image" src="https://github.com/user-attachments/assets/e88b0190-84cf-4434-a4c4-8687bd74bc97" />

## ✨ Features

### 🖥️ **Web Terminal**
- Full terminal access through your browser using [ttyd](https://github.com/tsl0922/ttyd)
- Supports multiple concurrent sessions
- Auto-reconnect capability
- Responsive design for mobile and desktop

### 📝 **VS Code in Browser**
- Full-featured VS Code IDE using [code-server](https://github.com/coder/code-server)
- File system access and editing
- Extension support
- Integrated terminal

### 🎤 **Voice Transcription** (Optional)
- Voice-to-text using Whisper API
- Multi-language support
- Auto-copy to clipboard
- Perfect for voice commands and dictation

### 🔒 **Security Features**
- Password-protected access
- Session management with expiration
- SHA-256 password hashing
- HTTPS support with reverse proxy

## 🚀 Quick Start

### Prerequisites
- Linux server (Ubuntu/Debian recommended)
- Python 3.8+
- Node.js 14+ (for code-server)
- 2GB+ RAM recommended

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/Steven0706/web_terminal_vibe_coding.git
cd web_terminal_vibe_coding
```

2. **Install ttyd:**
```bash
wget -qO ttyd https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64
chmod +x ttyd
sudo mv ttyd /usr/local/bin/
```

3. **Install code-server:**
```bash
curl -fsSL https://code-server.dev/install.sh | sh
```

4. **Set up password protection:**
```bash
# Open change-password.html in a browser
# Generate a new password hash
# Update login.html with your hash
```

5. **Start the services:**
```bash
./start-terminal-server.sh
```

6. **Access the interface:**
- Main Interface: `http://localhost:9012`
- Terminal Direct: `http://localhost:7681`
- VS Code Direct: `http://localhost:10001`

## 🔧 Configuration

### Password Setup
1. Open `change-password.html` in your browser
2. Enter your desired password
3. Copy the generated SHA-256 hash
4. Edit `login.html` and replace `CHANGE_THIS_HASH` with your hash

### Service Ports
Edit `start-terminal-server.sh` to change default ports:
- Terminal: 7681
- VS Code: 10001
- Web Interface: 9012

### HTTPS Setup with NGINX
```nginx
# Terminal proxy
server {
    listen 443 ssl;
    server_name terminal.yourdomain.com;
    
    location / {
        proxy_pass http://localhost:7681;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

# VS Code proxy
server {
    listen 443 ssl;
    server_name vscode.yourdomain.com;
    
    location / {
        proxy_pass http://localhost:10001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

# Main interface proxy
server {
    listen 443 ssl;
    server_name dev.yourdomain.com;
    
    location / {
        proxy_pass http://localhost:9012;
    }
}
```

## 🏃 Running as a System Service

1. **Create service file:**
```bash
sudo nano /etc/systemd/system/webterminal.service
```

2. **Add service configuration:**
```ini
[Unit]
Description=Web Terminal Server
After=network.target

[Service]
Type=simple
User=YOUR_USERNAME
WorkingDirectory=/path/to/web_terminal_vibe_coding
ExecStart=/path/to/web_terminal_vibe_coding/start-terminal-server.sh
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
```

3. **Enable and start:**
```bash
sudo systemctl daemon-reload
sudo systemctl enable webterminal
sudo systemctl start webterminal
```

## 🎤 Voice Transcription Setup (Optional)

### Using OpenAI Whisper API
1. Set up a Whisper API endpoint
2. Update the endpoint in Settings (gear icon)
3. Click the microphone button to start recording
4. Transcription auto-copies to clipboard

### Supported Languages
- Auto-detect (default)
- English, Chinese, Spanish, French
- German, Japanese, Korean, Russian
- Arabic, Hindi, Portuguese, Italian

## 📁 Project Structure

```
web_terminal_vibe_coding/
├── index.html              # Main web interface
├── login.html              # Authentication page
├── change-password.html    # Password hash generator
├── start-terminal-server.sh # Service startup script
├── README.md              # This file
├── LICENSE                # MIT License
└── docs/                  # Additional documentation
```

## 🔒 Security Considerations

⚠️ **Important Security Notes:**

1. **Change the default password immediately**
2. **Use HTTPS in production** (SSL/TLS certificates required)
3. **Implement firewall rules** to restrict access
4. **Regular security updates** for all components
5. **Consider VPN access** for additional security

### Firewall Configuration
```bash
# Allow only specific IPs (example)
sudo ufw allow from 192.168.1.0/24 to any port 9012
sudo ufw allow from 192.168.1.0/24 to any port 7681
sudo ufw allow from 192.168.1.0/24 to any port 10001
```

## 🛠️ Troubleshooting

### Terminal not connecting
- Check if ttyd is running: `ps aux | grep ttyd`
- Verify firewall rules: `sudo ufw status`
- Check browser console for WebSocket errors

### VS Code not loading
- Verify code-server installation: `code-server --version`
- Check port availability: `sudo netstat -tlnp | grep 10001`

### Password not working
- Regenerate hash using `change-password.html`
- Clear browser cache and cookies
- Check browser console for errors

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [ttyd](https://github.com/tsl0922/ttyd) - Terminal server
- [code-server](https://github.com/coder/code-server) - VS Code in browser
- [xterm.js](https://xtermjs.org/) - Terminal rendering
- OpenAI Whisper - Voice transcription

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/Steven0706/web_terminal_vibe_coding/issues)
- **Discussions:** [GitHub Discussions](https://github.com/Steven0706/web_terminal_vibe_coding/discussions)

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Steven0706/web_terminal_vibe_coding&type=Date)](https://star-history.com/#Steven0706/web_terminal_vibe_coding&Date)

---

**Made with ❤️ for developers who need access to their development environment from anywhere**
