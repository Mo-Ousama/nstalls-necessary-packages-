#!/bin/bash

# تحديث الحزم
echo "🔄 Updating package lists..."
if [[ -f /etc/debian_version ]]; then
    sudo apt update -y && sudo apt upgrade -y
elif [[ -f /etc/redhat-release ]]; then
    sudo yum update -y
else
    echo "❌ Unsupported OS"
    exit 1
fi

# تثبيت Git
echo "📦 Installing Git..."
if [[ -f /etc/debian_version ]]; then
    sudo apt install -y git
elif [[ -f /etc/redhat-release ]]; then
    sudo yum install -y git
fi

# تثبيت Node.js
echo "📦 Installing Node.js..."
if [[ -f /etc/debian_version ]]; then
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
elif [[ -f /etc/redhat-release ]]; then
    curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
    sudo yum install -y nodejs
fi

# تثبيت Docker
echo "📦 Installing Docker..."
if [[ -f /etc/debian_version ]]; then
    sudo apt install -y docker.io
elif [[ -f /etc/redhat-release ]]; then
    sudo yum install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# إضافة المستخدم إلى مجموعة Docker (اختياري)
sudo usermod -aG docker $USER

# تأكيد التثبيت
echo "✅ Installation complete!"
git --version
node -v
docker --version
