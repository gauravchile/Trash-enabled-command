#!/bin/bash
# trash.sh - Safe trash command for Linux
# Production-ready: move, restore, permanent delete
# Works from any directory

TRASH_DIR="$HOME/.local/share/Trash/files"
mkdir -p "$TRASH_DIR"

# ---------------------------
# Color definitions
# ---------------------------
RED='\033[0;31m'       # errors
GREEN='\033[0;32m'     # success
YELLOW='\033[1;33m'    # warnings
BLUE='\033[0;34m'      # info
NC='\033[0m'           # no color

# ---------------------------
# Functions
# ---------------------------
move_to_trash() {
    local FILE="$1"
    if [ ! -f "$FILE" ]; then
        echo -e "${RED} File not found: $FILE${NC}"
        return
    fi
    local TIMESTAMP=$(date +%H-%M-%S)
    local BASENAME=$(basename "$FILE")
    mv "$FILE" "$TRASH_DIR/${BASENAME}_$TIMESTAMP"
    echo -e "${GREEN} Moved to trash:${NC} $FILE -> $TRASH_DIR/${BASENAME}_$TIMESTAMP"
}

restore_file() {
    local FILE="$1"
    local MATCHES=($(ls "$TRASH_DIR" | grep "^${FILE}_"))
    if [ ${#MATCHES[@]} -eq 0 ]; then
        echo -e "${RED} File not found in trash: $FILE${NC}"
        return
    elif [ ${#MATCHES[@]} -eq 1 ]; then
        mv "$TRASH_DIR/${MATCHES[0]}" "./$FILE"
        echo -e "${GREEN} Restored:${NC} $FILE"
    else
        echo -e "${YELLOW} Multiple matches found for $FILE:${NC}"
        for i in "${!MATCHES[@]}"; do
            echo "[$i] ${MATCHES[$i]}"
        done
        read -p "Enter the number of the file to restore: " idx
        mv "$TRASH_DIR/${MATCHES[$idx]}" "./$FILE"
        echo -e "${GREEN} Restored:${NC} $FILE"
    fi
}

delete_file() {
    local FILE="$1"

    if [ -f "$FILE" ]; then
        echo -e "${BLUE} File exists in original location. Moving to trash first...${NC}"
        move_to_trash "$FILE"
    fi

    local MATCHES=($(ls "$TRASH_DIR" | grep "^${FILE}_"))
    if [ ${#MATCHES[@]} -eq 0 ]; then
        echo -e "${RED} File not found in trash: $FILE${NC}"
        return
    elif [ ${#MATCHES[@]} -eq 1 ]; then
        rm -f "$TRASH_DIR/${MATCHES[0]}"
        echo -e "${GREEN} Permanently deleted:${NC} $FILE"
    else
        echo -e "${YELLOW} Multiple matches found for $FILE:${NC}"
        for i in "${!MATCHES[@]}"; do
            echo "[$i] ${MATCHES[$i]}"
        done
        read -p "Enter the number of the file to permanently delete: " idx
        rm -f "$TRASH_DIR/${MATCHES[$idx]}"
        echo -e "${GREEN} Permanently deleted:${NC} $FILE"
    fi
}

# ---------------------------
# Main
# ---------------------------
case "$1" in
    --restore)
        restore_file "$2"
        ;;
    --del)
        delete_file "$2"
        ;;
    *)
        move_to_trash "$1"
        ;;
esac
