# Custom Trash-Enabled `rm` Command

## Project Overview
This project implements a **safe custom `rm` command** for Linux systems that moves deleted files to a **trash directory** instead of permanently deleting them.  
It also supports restoring files to their original directory and permanent deletion from the trash.

**Project Objectives:**
- Protect your files from accidental deletion.
- Learn shell scripting and environment variable management.
- Understand aliasing and custom command creation.

---

## Project Structure

custom-trash-rm/

 trash.sh # Main script implementing trash functionality
 README.md # Project documentation
 test_files/ # Folder to create test files

---

## Setup

1. **Clone the repository** (or create your folder)

git clone <your-repo-url>
cd custom-trash-rm
Make script executable:

chmod +x trash.sh

Optional: Alias rm to trash script:

alias rm="/usr/local/bin/trash.sh"
Now rm file.txt moves files to trash instead of deleting them.

**Usage:**
Move files to trash (default)

rm file1.txt "file[@].txt"

**Restore files:**

rm --restore file1.txt_1695901234


**Permanently delete files:**

rm --del file1.txt_1695901234

**Check trash folder:**

ls $HOME/.local/share/Trash/files

**Add alias for all users:**

echo 'alias rm="/usr/local/bin/trash.sh"' | sudo tee -a /etc/bash.bashrc

source /etc/bash.bashrc

**Optional: Set up trash directories for all new users:**

sudo mkdir -p /etc/skel/.local/share/Trash/files

sudo mkdir -p /etc/skel/.local/share/Trash/files_info

sudo chmod -R 700 /etc/skel/.local/share/Trash


