#!/bin/bash

source "functions.sh";

PS3='Please enter your choice: '
options=("Option 1 - Clear Memory" "Option 2 - Show Memory" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Option 1 - Clear Memory")
            run_menu_command clear_ram_memory
            ;;
        "Option 2 - Show Memory")
            # Show Memory
            free -m;
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
