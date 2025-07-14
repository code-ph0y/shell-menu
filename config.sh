#!/bin/sh

# Resolve root directory of this script (handles symlinks)
SOURCE="${BASH_SOURCE:-$0}"
while [ -h "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [ "${SOURCE#/}" = "$SOURCE" ] && SOURCE="$DIR/$SOURCE"
done
DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"

# Set the base paths
base_command_path="$DIR/commands/"
command_path="$base_command_path"

# Menu display name
menu_name="Menu System"

# Default settings

MENU_HEADER_TEXT="Choose from:"
MENU_PROMPT="Enter your choice:"
QUIT_COMMAND="q"
BACK_COMMAND="b"

# Toggle color output
USE_COLOR=true

# Disable color if not running in a terminal
if [ ! -t 1 ]; then
    USE_COLOR=false
fi

# Export if other scripts might need them
export DIR
export base_command_path
export command_path
export menu_name

# Ensure commands directory exists
if [ ! -d "$base_command_path" ]; then
  echo "Error: Commands directory not found at: $base_command_path"
  echo "Please check your folder structure or DIR setting."
  exit 1
fi