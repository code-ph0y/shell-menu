# Load config file
source "$DIR/config.sh";

run_menu_command()
{
    # Get command name from first input
    command_name=$1;
    source "$command_path$command_name.sh";
}

set_menu_path()
{
	command_path="$base_command_path$1/";
	menu_name=$(encode_human_readable $2);
}

strtolower()
{
    lc ()
    {
        case "$1" in
            [A-Z])
            n=$(printf "%d" "'$1")
            n=$((n+32))
            printf \\$(printf "%o" "$n")
            ;;
            *)
            printf "%s" "$1"
            ;;
        esac
    }

    word=$1

    for((i=0;i<${#word};i++))
    do
        ch="${word:$i:1}"
        lc "$ch"
    done
}

str_replace()
{
    haystack=$1;
    needle=$2;
    replace_string=$3;

    echo "${haystack//$needle/$replace_string}";
}

encode_human_readable()
{
    string_to_encode=$1;
    string_to_encode=$(str_replace $string_to_encode "_" " ");

    echo $string_to_encode | tr [A-Z] [a-z] | sed -e 's/^./\U&/g; s/ ./\U&/g';
}

get_menu_header()
{
    echo;
    echo '==============================';
    echo $menu_name;
    echo '------------------------------';
    echo 'Please enter your choice:';
    echo;
    echo;
}

get_menu_options()
{
    count=1;
    for entry in "$command_path"*
    do
        filename=$(basename "$entry");

        # Empty directories will get skipped
        if [ -d "$command_path${filename}" ] ;
        then
            if [ $(ls $command_path${filename} | wc -l) == 0 ]
            then
                continue;
            fi;
        fi;

        extension="${filename##*.}";
        filename="${filename%.*}";
        entryname="$filename"
        filename=$(encode_human_readable $filename);


        if [ -d "$command_path$entryname" ]
        then
			echo "Option ($count): $filename...";
		else
			echo "Option ($count): $filename";
        fi

        # Increment count
        ((count++))
    done

    if [ $command_path != $base_command_path ]
    then
		echo "Option (b): Back";
	fi

    echo "Option (q): Quit";
}

take_in_input()
{
    echo;
    echo "Enter choice: ";

    options=();

    for entry in "$command_path"*
    do
        filename=$(basename "$entry");
        extension="${filename##*.}";
        filename="${filename%.*}";

        options+=("$filename");
    done

    # Take input from user
    read menu_input

    # Check quit or back command
    if [ $menu_input = "q" ]
    then
        echo;
        echo "Good Bye!";
        exit 0;
    elif [ $menu_input = "b"  ]
    then
		set_menu_path "" "menu_system";
		return;
    fi

    # Process request
    if [ $menu_input -eq $menu_input 2>/dev/null ]
    then
        # Get the correct array key
        menu_input=$(($menu_input-1));

        if [ ${options[$menu_input]+isset} ]
        then
			if [ -d "$command_path${options[$menu_input]}" ]
			then
				set_menu_path "${options[$menu_input]}" "${options[$menu_input]}";

            else
				run_menu_command ${options[$menu_input]}
				exit 1
            fi
        else
            echo "Option entered is invalid";
        fi
    else
        echo "Option entered is invalid";
    fi
}
