# 🧹 macOS Developer Cleanup Scripts – README

This folder contains **multiple cleanup scripts** for macOS developer machines.
Each script has a **different safety level**.
**Read carefully before running anything.**

---

## 📁 Folder Structure

```text
~/scripts/
├── cleanup_safe.sh
├── cleanup_nuclear.sh
├── cleanup_dev_storage.sh   # Original script (AGGRESSIVE)
└── README.md
```

---

## 🟢 cleanup_safe.sh (RECOMMENDED – DAILY / MONTHLY)

### Purpose

Routine cleanup with **ZERO data loss**.

### Safety level

✅ **SAFE**

### What it cleans

* Xcode: DerivedData, caches, device support
* Android Studio: caches, logs, Gradle cache
* Docker: unused containers/images (⚠️ volumes preserved)
* VS Code: cache & logs only
* npm / yarn / pnpm caches
* CocoaPods cache
* Homebrew cache
* Diagnostic logs

### What it DOES NOT delete

* ❌ Docker volumes
* ❌ Databases
* ❌ IDE settings
* ❌ Projects or source code
* ❌ Unsaved files

### When to use

* Weekly or monthly
* Anytime disk usage grows
* Before builds start slowing down

### Run

```bash
./cleanup_safe.sh
```

---

## 🔴 cleanup_dev_storage.sh (AGGRESSIVE – YOUR ORIGINAL SCRIPT)

### Purpose

Large space recovery by **force-cleaning many developer tools**.

### Safety level

⚠️ **MODERATE → HIGH RISK**

This script **will work**, but **can cause data loss or reconfiguration pain**.

---

### What it cleans (GOOD)

✔ Xcode DerivedData, caches, device support
✔ npm / yarn / pnpm caches
✔ CocoaPods cache
✔ Browser caches
✔ System caches
✔ Trash

---

### ❌ What makes it RISKY

#### 1️⃣ Docker (VERY DANGEROUS)

```bash
docker system prune -a -f --volumes
```

Deletes:

* ❌ ALL Docker volumes
* ❌ ALL databases (MySQL, PostgreSQL, Redis)
* ❌ ALL stopped containers
* ❌ ALL unused images

⚠️ **Permanent data loss**

---

#### 2️⃣ Android Studio (Config loss)

```bash
rm -rf ~/Library/Application Support/AndroidStudio*
```

Deletes:

* ❌ Plugins
* ❌ IDE settings
* ❌ Keymaps
* ❌ UI configuration

---

#### 3️⃣ VS Code backups

```bash
rm -rf ~/Library/Application Support/Code/Backups/*
```

Deletes:

* ❌ Unsaved file recovery
* ❌ Crash backups

---

#### 4️⃣ Browsers

* Can log you out
* Can break active sessions
* Must be run with browsers CLOSED

---

### When SHOULD you use `cleanup_dev_storage.sh`

✅ Disk space is critically low
✅ You understand Docker data will be deleted
✅ You are okay reconfiguring IDEs
✅ You have backups

### When NOT to use it

❌ Regular maintenance
❌ Active development day
❌ If Docker volumes contain databases

### Run (ONLY if you understand the risk)

```bash
./cleanup_dev_storage.sh
```

---

## 🧨 cleanup_nuclear.sh (EXTREME – EMERGENCY ONLY)

### Purpose

Last-resort cleanup when disk is almost full.

### Safety level

☠️ **EXTREME RISK**

### What it deletes

* ❌ Docker containers, images, volumes
* ❌ Android Studio (full reset)
* ❌ VS Code backups
* ❌ Xcode archives
* ❌ Node caches
* ❌ Browser caches
* ❌ Trash

### Confirmation required

You must type **YES** before execution.

### Run

```bash
./cleanup_nuclear.sh
```

---

## 👤 USER & PERMISSIONS (VERY IMPORTANT)

### ✅ Always run as your MAIN USER

```bash
whoami
```

Expected output:

```
aman
```

### ❌ NEVER use

```bash
sudo su
```

Why:

* `~` changes to `/var/root`
* User caches will not clean correctly
* High risk of permission damage

### ✔ Acceptable sudo usage

```bash
sudo ./cleanup_safe.sh
```

(Only if Docker permissions require it)

---

## 🔐 First-Time Setup

```bash
chmod +x cleanup_safe.sh cleanup_dev_storage.sh cleanup_nuclear.sh
```

---

## ⭐ Recommended Usage Strategy

| Scenario                          | Script                   |
| --------------------------------- | ------------------------ |
| Regular cleanup                   | `cleanup_safe.sh`        |
| Need extra space, understand risk | `cleanup_dev_storage.sh` |
| Disk almost full                  | `cleanup_nuclear.sh`     |

---

## 🛡️ Best Practices

### Before running aggressive or nuclear cleanup

```bash
docker volume ls
```

Backup important volumes:

```bash
docker run --rm -v volume_name:/data -v $PWD:/backup alpine \
  tar czf /backup/volume_backup.tar.gz /data
```

### After cleanup

* Restart IDEs
* Expect slower first build
* Re-download dependencies as needed

---

## 📌 Summary

| Script                 | Safe       | Data Loss   | Recommended  |
| ---------------------- | ---------- | ----------- | ------------ |
| cleanup_safe.sh        | ✅ Yes      | ❌ No        | ⭐⭐⭐⭐⭐        |
| cleanup_dev_storage.sh | ⚠️ Partial | ⚠️ Possible | ⭐⭐           |
| cleanup_nuclear.sh     | ❌ No       | ✅ Yes       | ☠️ Emergency |

---

## 🧠 Final Advice

👉 **If unsure, always run `cleanup_safe.sh` first.**
👉 Use `cleanup_dev_storage.sh` only if you fully understand it.
👉 Treat `cleanup_nuclear.sh` as **last resort**.

---
