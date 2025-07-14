#!/bin/sh

# Run the command script corresponding to the selected option
run_menu_command() {
    command_name="$1"
    . "$command_path${command_name}.sh"
}

# Set the current command path and readable menu name
set_menu_path() {
    subpath="$1"
    name="$2"
    command_path="${base_command_path}${subpath:+$subpath/}"
    menu_name=$(encode_human_readable "$name")
}

# Display the menu header
get_menu_header() {
    print_header
}

# Display the menu options based on the current path
get_menu_options() {
    count=1

    for entry in "$command_path"*; do
        [ ! -e "$entry" ] && continue

        filename=$(basename "$entry")
        extension="${filename##*.}"
        base="${filename%.*}"

        # Skip empty directories
        if [ -d "$entry" ] && [ -z "$(ls -A "$entry")" ]; then
            continue
        fi

        display_name=$(encode_human_readable "$base")

        if [ -d "$entry" ]; then
            print_option "$count" "${display_name}..."
            count=$((count + 1))
        elif [ "$extension" = "sh" ]; then
            print_option "$count" "$display_name"
            count=$((count + 1))
        fi
    done

    if [ "$command_path" != "$base_command_path" ]; then
        print_back_option
    fi

    print_quit_option
}
