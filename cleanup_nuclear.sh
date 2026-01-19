#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "=========================================="
echo "⚠️  NUCLEAR CLEANUP ⚠️"
echo "THIS WILL DELETE DATA"
echo "=========================================="
echo ""
read -p "Type YES to continue: " confirm
if [[ "$confirm" != "YES" ]]; then
  echo "❌ Aborted"
  exit 1
fi

### XCODE (FULL RESET)
echo "🧨 Xcode FULL cleanup..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*
rm -rf ~/Library/Developer/Xcode/Archives/*
rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/*
rm -rf ~/Library/Caches/com.apple.dt.Xcode
echo "💥 Xcode nuked"
echo ""

### ANDROID STUDIO (FULL RESET)
echo "🧨 Android Studio FULL reset..."
rm -rf ~/Library/Application\ Support/AndroidStudio*
rm -rf ~/Library/Caches/AndroidStudio*
rm -rf ~/Library/Logs/AndroidStudio*
rm -rf ~/.gradle
rm -rf ~/.android
echo "💥 Android Studio nuked"
echo ""

### DOCKER (FULL WIPE)
if command -v docker &>/dev/null; then
  echo "🧨 Docker FULL wipe..."
  docker system prune -a -f --volumes
  echo "💥 Docker nuked (ALL DATA REMOVED)"
else
  echo "⏭ Docker not installed"
fi
echo ""

### VS CODE (FULL RESET)
echo "🧨 VS Code FULL cleanup..."
rm -rf ~/Library/Application\ Support/Code/Cache/*
rm -rf ~/Library/Application\ Support/Code/CachedData/*
rm -rf ~/Library/Application\ Support/Code/Backups/*
rm -rf ~/Library/Application\ Support/Code/logs/*
echo "💥 VS Code nuked"
echo ""

### NODE ECOSYSTEM
echo "🧨 Node FULL cleanup..."
rm -rf ~/.npm ~/.yarn ~/.pnpm-store
npm cache clean --force 2>/dev/null || true
echo "💥 Node cache nuked"
echo ""

### BROWSERS
echo "🧨 Browser cache cleanup..."
rm -rf ~/Library/Caches/Google/Chrome/*
rm -rf ~/Library/Caches/Microsoft\ Edge/*
rm -rf ~/Library/Caches/Firefox/*
echo "💥 Browser caches nuked"
echo ""

### TRASH
echo "🧨 Emptying Trash..."
rm -rf ~/.Trash/*
echo "💥 Trash emptied"
echo ""

echo "🔥 NUCLEAR CLEANUP COMPLETE"
echo "=========================================="
echo "⚠️  REBOOT STRONGLY RECOMMENDED"
echo "=========================================="
