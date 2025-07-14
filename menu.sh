#!/bin/sh

# -------------------------------------
# Menu System Entrypoint
# -------------------------------------

# Load core config and libraries
. "$(dirname "$0")/config.sh"
. "$DIR/lib/functions.sh"
. "$DIR/lib/utils.sh"
. "$DIR/lib/ui.sh"
. "$DIR/lib/input.sh"

# Initial Display
get_menu_header
get_menu_options
take_in_input

# Main Menu Loop
while true; do
    get_menu_header
    get_menu_options
    take_in_input
done

exit 0