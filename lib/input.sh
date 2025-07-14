#!/bin/sh

# Take in the input from the user
take_in_input() {
    echo
    printf "%s " "$MENU_PROMPT"
    read -r menu_input

    # Check quit
    if [ "$menu_input" = "$QUIT_COMMAND" ]; then
        echo
        echo "Good Bye!"
        exit 0
    fi

    # Check back
    if [ "$menu_input" = "$BACK_COMMAND" ]; then
        set_menu_path "" "menu_system"
        return
    fi

    # Check numeric input
    case "$menu_input" in
        ''|*[!0-9]*)
            print_error "Option entered is invalid"
            return
            ;;
    esac

    # Map number to real file
    index=1
    for entry in "$command_path"*; do
        [ ! -e "$entry" ] && continue

        filename=$(basename "$entry")

        # Skip empty directories
        if [ -d "$entry" ] && [ -z "$(ls -A "$entry")" ]; then
            continue
        fi

        extension="${filename##*.}"
        base="${filename%.*}"

        if [ "$extension" = "sh" ] || [ -d "$entry" ]; then
            if [ "$index" -eq "$menu_input" ]; then
                # Match found!
                if [ -d "$command_path$base" ]; then
                    set_menu_path "$base" "$base"
                else
                    run_menu_command "$base"
                    exit 1
                fi
                return
            fi
            index=$((index + 1))
        fi
    done

    # If we reach here, no valid selection
    print_error "Option entered is invalid"
}
