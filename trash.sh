#!/usr/bin/env bash

TRASH="$HOME/.local/share/Trash/files"
INFO="$HOME/.local/share/Trash/files_info"
mkdir -p "$TRASH" "$INFO"

cmd="$1"; shift || true

case "$cmd" in

  --restore)
    for f in "$@"; do
      info_file="$INFO/$f.info"
      if [[ ! -e "$TRASH/$f" || ! -e "$info_file" ]]; then
        echo "File not found in trash: $f"
        continue
      fi
      orig_path=$(cat "$info_file")
      mkdir -p "$(dirname "$orig_path")"
      mv "$TRASH/$f" "$orig_path"
      rm -f "$info_file"
      echo "Restored: $f -> $orig_path"
    done
    ;;

  --del)
    for f in "$@"; do
      if [[ ! -e "$TRASH/$f" ]]; then
        echo "File not found in trash: $f"
        continue
      fi
      rm -rf "$TRASH/$f"
      rm -f "$INFO/$f.info"
      echo "Permanently deleted: $f"
    done
    ;;

  *)
    for f in "$cmd" "$@"; do
      abs_f="$(readlink -f "$f")"
      [[ -e "$abs_f" ]] || { echo "File not found: $f"; continue; }

      # Prevent overwriting in trash
      base="$(basename "$abs_f")"
      ts=$(date +%s)
      dest="$TRASH/${base}_$ts"

      mv "$abs_f" "$dest"
      # Save original path for restore
      echo "$abs_f" > "$INFO/$(basename "$dest").info"
      echo "Moved to trash: $f -> $dest"
    done
    ;;
esac

