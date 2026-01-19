#!/bin/bash

# macOS Development Tools Cleanup Script
# This script cleans caches and temporary files from various development tools
# Run with: ./cleanup_dev_storage.sh

echo "=========================================="
echo "macOS Development Storage Cleanup"
echo "=========================================="
echo ""

# Function to display size freed
calculate_size() {
    du -sh "$1" 2>/dev/null | awk '{print $1}'
}

# Xcode Cleanup
echo "🧹 Cleaning Xcode..."
if [ -d ~/Library/Developer/Xcode ]; then
    echo "  - Removing DerivedData..."
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
    
    echo "  - Removing Xcode caches..."
    rm -rf ~/Library/Caches/com.apple.dt.Xcode
    
    echo "  - Removing Archives..."
    rm -rf ~/Library/Developer/Xcode/Archives/*
    
    echo "  - Removing old iOS Device Support..."
    rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport/*
    
    echo "  - Removing Module Cache..."
    rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache/*
    
    echo "  ✅ Xcode cleanup completed"
else
    echo "  ⏭️  Xcode not found, skipping..."
fi
echo ""

# Android Studio Cleanup
echo "🧹 Cleaning Android Studio..."
if [ -d ~/Library/Application\ Support/Google/AndroidStudio* ] || [ -d ~/.gradle ]; then
    echo "  - Removing Android Studio caches..."
    rm -rf ~/Library/Caches/AndroidStudio*
    rm -rf ~/Library/Application\ Support/AndroidStudio*
    rm -rf ~/Library/Logs/AndroidStudio*
    
    echo "  - Removing Gradle caches..."
    rm -rf ~/.gradle/caches/
    rm -rf ~/.gradle/daemon/
    
    echo "  - Removing Android build cache..."
    rm -rf ~/.android/build-cache/
    
    echo "  ✅ Android Studio cleanup completed"
else
    echo "  ⏭️  Android Studio not found, skipping..."
fi
echo ""

# Docker Cleanup
echo "🧹 Cleaning Docker..."
if command -v docker &> /dev/null; then
    echo "  - Pruning Docker system..."
    docker system prune -a -f --volumes 2>/dev/null
    
    echo "  - Removing all stopped containers..."
    docker container prune -f 2>/dev/null
    
    echo "  - Removing unused images..."
    docker image prune -a -f 2>/dev/null
    
    echo "  - Removing unused volumes..."
    docker volume prune -f 2>/dev/null
    
    echo "  - Removing unused networks..."
    docker network prune -f 2>/dev/null
    
    echo "  ✅ Docker cleanup completed"
else
    echo "  ⏭️  Docker not found, skipping..."
fi
echo ""

# VS Code Cleanup
echo "🧹 Cleaning VS Code..."
if [ -d ~/Library/Application\ Support/Code ]; then
    echo "  - Removing VS Code caches..."
    rm -rf ~/Library/Application\ Support/Code/Cache/*
    rm -rf ~/Library/Application\ Support/Code/CachedData/*
    rm -rf ~/Library/Application\ Support/Code/CachedExtensions/*
    rm -rf ~/Library/Application\ Support/Code/CachedExtensionVSIXs/*
    rm -rf ~/Library/Application\ Support/Code/logs/*
    
    echo "  - Removing VS Code backup files..."
    rm -rf ~/Library/Application\ Support/Code/Backups/*
    
    echo "  ✅ VS Code cleanup completed"
else
    echo "  ⏭️  VS Code not found, skipping..."
fi
echo ""

# npm Cleanup
echo "🧹 Cleaning npm..."
if command -v npm &> /dev/null; then
    echo "  - Clearing npm cache..."
    npm cache clean --force 2>/dev/null
    echo "  - Verifying npm cache..."
    npm cache verify 2>/dev/null
    echo "  ✅ npm cleanup completed"
else
    echo "  ⏭️  npm not found, skipping..."
fi
echo ""

# yarn Cleanup
echo "🧹 Cleaning yarn..."
if command -v yarn &> /dev/null; then
    echo "  - Clearing yarn cache..."
    yarn cache clean --all 2>/dev/null
    echo "  ✅ yarn cleanup completed"
else
    echo "  ⏭️  yarn not found, skipping..."
fi
echo ""

# pnpm Cleanup
echo "🧹 Cleaning pnpm..."
if command -v pnpm &> /dev/null; then
    echo "  - Clearing pnpm store..."
    pnpm store prune 2>/dev/null
    echo "  ✅ pnpm cleanup completed"
else
    echo "  ⏭️  pnpm not found, skipping..."
fi
echo ""

# Browser Caches
echo "🧹 Cleaning Browser Caches..."

# Microsoft Edge
if [ -d ~/Library/Caches/Microsoft\ Edge ]; then
    echo "  - Removing Microsoft Edge cache..."
    rm -rf ~/Library/Caches/Microsoft\ Edge/*
    echo "  ✅ Edge cache cleared"
fi

# Opera
if [ -d ~/Library/Caches/com.operasoftware.Opera ]; then
    echo "  - Removing Opera cache..."
    rm -rf ~/Library/Caches/com.operasoftware.Opera/*
    rm -rf ~/Library/Application\ Support/com.operasoftware.Opera/Cache/*
    echo "  ✅ Opera cache cleared"
fi

# Firefox (Mozilla)
if [ -d ~/Library/Caches/Firefox ]; then
    echo "  - Removing Firefox cache..."
    rm -rf ~/Library/Caches/Firefox/*
    rm -rf ~/Library/Caches/Mozilla/Firefox/*
    echo "  ✅ Firefox cache cleared"
fi
echo ""

# System Caches (General)
echo "🧹 Cleaning System & App Caches..."
echo "  - Removing user cache files..."
rm -rf ~/Library/Caches/Homebrew/* 2>/dev/null
rm -rf ~/Library/Logs/DiagnosticReports/* 2>/dev/null

# CocoaPods cache
if [ -d ~/Library/Caches/CocoaPods ]; then
    echo "  - Removing CocoaPods cache..."
    rm -rf ~/Library/Caches/CocoaPods/*
fi

echo "  ✅ System caches cleaned"
echo ""

# Empty Trash
echo "🗑️  Emptying Trash..."
rm -rf ~/.Trash/*
echo "  ✅ Trash emptied"
echo ""

echo "=========================================="
echo "✨ Cleanup Complete!"
echo "=========================================="
echo ""
echo "💡 Tips:"
echo "  - Restart your applications to rebuild necessary caches"
echo "  - Run 'docker system df' to check Docker disk usage"
echo "  - Consider running Disk Utility to verify disk integrity"
echo ""
