#!/bin/bash

# Web Development Environment Server
# This script starts ttyd (terminal server), code-server (VS Code), and HTTP server

echo "========================================"
echo "    Web Development Environment"
echo "========================================"

# Get the local IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Kill any existing instances
echo "Cleaning up existing processes..."
pkill -f "ttyd" 2>/dev/null
pkill -f "python3 -m http.server 9012" 2>/dev/null
pkill -f "code-server" 2>/dev/null
sleep 1

# Start ttyd terminal server on port 7681
echo -e "${BLUE}Starting ttyd terminal server on port 7681...${NC}"
~/ttyd --port 7681 --interface 0.0.0.0 --max-clients 10 --writable bash &
TTYD_PID=$!
echo "ttyd started with PID: $TTYD_PID"

# Start code-server (VS Code) on port 10001
echo -e "${YELLOW}Starting code-server (VS Code) on port 10001...${NC}"
code-server --bind-addr 0.0.0.0:10001 --auth none --disable-file-downloads --disable-workspace-trust > /dev/null 2>&1 &
CODE_PID=$!
echo "code-server started with PID: $CODE_PID"

# Start Python HTTP server on port 10000 for the HTML interface
echo -e "${BLUE}Starting HTTP server on port 9012...${NC}"
cd /home/steven/webterminal
python3 -m http.server 9012 --bind 0.0.0.0 > /dev/null 2>&1 &
HTTP_PID=$!
echo "HTTP server started with PID: $HTTP_PID"

echo ""
echo "========================================"
echo -e "${GREEN}✓ Web Development Environment is running!${NC}"
echo "========================================"
echo ""
echo "Access from your local network:"
echo -e "${GREEN}Main Interface:${NC} http://$IP_ADDRESS:9012"
echo -e "${BLUE}Terminal:${NC} http://$IP_ADDRESS:7681"
echo -e "${YELLOW}VS Code:${NC} http://$IP_ADDRESS:10001"
echo ""
echo "Local access:"
echo -e "${GREEN}Main Interface:${NC} http://localhost:9012"
echo -e "${BLUE}Terminal:${NC} http://localhost:7681"
echo -e "${YELLOW}VS Code:${NC} http://localhost:10001"
echo ""
echo "Press Ctrl+C to stop all services"
echo ""

# Function to handle cleanup on exit
cleanup() {
    echo ""
    echo "Shutting down services..."
    kill $TTYD_PID 2>/dev/null
    kill $CODE_PID 2>/dev/null
    kill $HTTP_PID 2>/dev/null
    pkill -f "ttyd" 2>/dev/null
    pkill -f "code-server" 2>/dev/null
    pkill -f "python3 -m http.server 9012" 2>/dev/null
        echo "Services stopped."
    exit 0
}

# Set up trap to cleanup on Ctrl+C
trap cleanup SIGINT SIGTERM

# Keep script running
while true; do
    sleep 1
done