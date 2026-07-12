#!/bin/bash

GREEN="\033[0;32m"
NC="\033[0m"

echo -e "${GREEN}=== Встановлення інструментів ===${NC}"

# 1. Docker
if ! command -v docker &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo -e "${GREEN}Docker вже є в системі.${NC}"
fi

# 2. Docker Compose
if ! command -v docker-compose &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo -e "${GREEN}Docker Compose вже є в системі.${NC}"
fi

# 3. Python 3
if ! command -v python3 &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y python3 python3-pip python3-venv
else
    echo -e "${GREEN}Python 3 вже є в системі.${NC}"
fi

# 4. Django
if ! python3 -m django --version &> /dev/null; then
    # Додано лише один прапорець, щоб уникнути помилок на нових Ubuntu
    pip3 install django --break-system-packages 2>/dev/null || pip3 install django
else
    echo -e "${GREEN}Django вже є в системі.${NC}"
fi
