# 🗑️ Custom Trash-Enabled Command

## 🚀 Project Overview

This project implements a **safe custom `rm` command** for Linux systems that moves deleted files to a **trash directory** instead of permanently deleting them. 💾

It also supports restoring files to their original directory and permanently deleting files from the trash.

**Project Objectives:**

* 🛡️ Protect your files from accidental deletion
* 💻 Learn shell scripting and environment variable management
* 🔧 Understand aliasing and custom command creation

---

## 📁 Project Structure

```
custom-trash-rm/
├── trash.sh        # Main script implementing trash functionality
├── README.md       # Project documentation
└── test_files/     # Folder to create test files
```

---

## ⚙️ Setup

1. **Clone the repository** (or create your folder):

```bash
git clone <your-repo-url>
cd custom-trash-rm
```

2. **Make the script executable**:

```bash
chmod +x trash.sh
```

3. **Optional: Alias `rm` to trash script**:

```bash
alias trm="/usr/local/bin/trash.sh"
```

> Now `trm file.txt` moves files to trash instead of deleting them.

---

## 📝 Usage

### Move files to trash (default)

```bash
trm file1.txt
```

### Restore files

```bash
trm --restore file1.txt_1695901234
```

### Permanently delete files

```bash
trm --del file1.txt_1695901234
```

### Check trash folder

```bash
ls $HOME/.local/share/Trash/files
```

---

## 🔧 Optional Configuration

### Add alias for all users

```bash
echo 'alias trm="/usr/local/bin/trash.sh"' | sudo tee -a /etc/bash.bashrc
source /etc/bash.bashrc
```

### Set up trash directories for all new users

```bash
sudo mkdir -p /etc/skel/.local/share/Trash/files
sudo mkdir -p /etc/skel/.local/share/Trash/files_info
sudo chmod -R 700 /etc/skel/.local/share/Trash
```

### Make a login message appear (optional)

```bash
sudo tee -a /etc/motd << 'EOF'
====================================
🗑️ Use 'trm <file>' to safely move files to trash instead of deleting.
Restore: trm --restore <filename>
Permanently delete: trm --del <filename>
====================================
EOF
```

---

✨ **Now you can manage your files safely and avoid accidental deletion!**
