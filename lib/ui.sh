#!/bin/sh

if [ "$USE_COLOR" = true ]; then
    # ANSI color codes
    RESET=$(printf '\033[0m')
    BOLD=$(printf '\033[1m')

    # Foreground colors
    FG_RED=$(printf '\033[31m')
    FG_GREEN=$(printf '\033[32m')
    FG_YELLOW=$(printf '\033[33m')
    FG_BLUE=$(printf '\033[34m')
    FG_CYAN=$(printf '\033[36m')
    FG_WHITE=$(printf '\033[97m')
else
    # No color
    RESET=""
    BOLD=""
    FG_RED=""
    FG_GREEN=""
    FG_YELLOW=""
    FG_BLUE=""
    FG_CYAN=""
    FG_WHITE=""
fi

# UI Print Helpers

print_header() {
    echo "${BOLD}${FG_CYAN}==============================${RESET}"
    echo "${BOLD}${FG_WHITE}$menu_name${RESET}"
    echo "${BOLD}${FG_CYAN}==============================${RESET}"
    echo "${FG_YELLOW}$MENU_HEADER_TEXT${RESET}"
    echo
}

print_option() {
    local label="$1"
    local text="$2"
    echo "${FG_GREEN}Option ($label):${RESET} ${FG_WHITE}$text${RESET}"
}

print_back_option() {
    echo "${FG_BLUE}Option (${BACK_COMMAND}): Back${RESET}"
}

print_quit_option() {
    echo "${FG_RED}Option (${QUIT_COMMAND}): Quit${RESET}"
}

print_error() {
    echo "${FG_RED}Error:${RESET} $1"
}