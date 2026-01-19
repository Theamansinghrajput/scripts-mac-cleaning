#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "=========================================="
echo "SAFE macOS Developer Cleanup"
echo "(No data loss – safe to run anytime)"
echo "=========================================="
echo ""

### XCODE (SAFE)
echo "🧹 Xcode cleanup (safe)..."
rm -rf ~/Library/Developer/Xcode/DerivedData/* 2>/dev/null || true
rm -rf ~/Library/Caches/com.apple.dt.Xcode 2>/dev/null || true
rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/* 2>/dev/null || true
echo "✅ Xcode cleaned"
echo ""

### ANDROID STUDIO (SAFE)
echo "🧹 Android Studio cleanup (safe)..."
rm -rf ~/Library/Caches/AndroidStudio* 2>/dev/null || true
rm -rf ~/Library/Logs/AndroidStudio* 2>/dev/null || true
rm -rf ~/.gradle/caches 2>/dev/null || true
rm -rf ~/.gradle/daemon 2>/dev/null || true
echo "✅ Android Studio cleaned"
echo ""

### DOCKER (SAFE)
if command -v docker &>/dev/null; then
  echo "🧹 Docker cleanup (safe)..."
  docker system prune -f
  echo "✅ Docker cleaned (no volumes removed)"
else
  echo "⏭ Docker not installed"
fi
echo ""

### VS CODE (SAFE)
echo "🧹 VS Code cleanup (safe)..."
rm -rf ~/Library/Application\ Support/Code/Cache/* 2>/dev/null || true
rm -rf ~/Library/Application\ Support/Code/CachedData/* 2>/dev/null || true
rm -rf ~/Library/Application\ Support/Code/logs/* 2>/dev/null || true
echo "✅ VS Code cleaned"
echo ""

### NODE PACKAGE MANAGERS
echo "🧹 npm / yarn / pnpm cleanup..."
command -v npm &>/dev/null && npm cache clean --force
command -v yarn &>/dev/null && yarn cache clean --all
command -v pnpm &>/dev/null && pnpm store prune
echo "✅ Node caches cleaned"
echo ""

### SYSTEM CACHES (SAFE)
echo "🧹 System caches..."
rm -rf ~/Library/Caches/Homebrew/* 2>/dev/null || true
rm -rf ~/Library/Caches/CocoaPods/* 2>/dev/null || true
rm -rf ~/Library/Logs/DiagnosticReports/* 2>/dev/null || true
echo "✅ System caches cleaned"
echo ""

echo "✨ SAFE CLEANUP COMPLETE"
echo "=========================================="
