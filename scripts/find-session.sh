#!/bin/bash

# Find a session by its JSONL filename
# Usage: ./find-session.sh <session-id>
# Example: ./find-session.sh 8469bc0c-6ca3-430c-b6af-0a22e0ab5bc8

if [ -z "$1" ]; then
  echo "Usage: $0 <session-id>"
  echo "Example: $0 8469bc0c-6ca3-430c-b6af-0a22e0ab5bc8"
  exit 1
fi

SESSION_ID="$1"
SEARCH_DIRS=("$HOME/.factory-dev" "$HOME/.factory")

for dir in "${SEARCH_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    result=$(find "$dir" -name "${SESSION_ID}.jsonl" 2>/dev/null)
    if [ -n "$result" ]; then
      echo "Found: $result"
      osascript -e "set the clipboard to (POSIX file \"$result\")"
      echo "Copied to clipboard as file - ready to paste"
      exit 0
    fi
  fi
done

echo "Session not found: ${SESSION_ID}" >&2
exit 1
