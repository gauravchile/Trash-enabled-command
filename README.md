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

Usage:
Move files to trash (default)

rm file1.txt "file[@].txt"

# Output:
# Moved to trash: file1.txt -> /home/user/.local/share/Trash/files/file1.txt_1695901234

Restore files:

rm --restore file1.txt_1695901234

# Output:
# Restored: file1.txt_1695901234 -> /home/user/test_files/file1.txt

Permanently delete files

rm --del file1.txt_1695901234

# Output:
# Permanently deleted: file1.txt_1695901234

Check trash folder

ls $HOME/.local/share/Trash/files

