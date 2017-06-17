#!/bin/bash

PS3='Please enter your choice: '
options=("Option 1 - Clear Memory" "Option 2 - Show Memory" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1 - Clear Memory")
            echo 'Before:';
            echo;
            # Show Memory
            free -m;
            # Clear the Random Access Memory
            sudo sh -c "sync; echo '3' > /proc/sys/vm/drop_caches";
            echo;
            echo 'After:';
            echo;
            # Show Memory
	        free -m;
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
