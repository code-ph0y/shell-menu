# Load config file
source "$DIR/config.sh";

run_menu_command()
{
    # Get command name from first input
    command_name=$1;

    source "$command_path$command_name.sh";
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
        extension="${filename##*.}";
        filename="${filename%.*}";
        filename=$(encode_human_readable $filename);
        echo "Option ($count): $filename";

        # Increment count
        ((count++))
    done
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
    read input

    # Check quit command
    if [ $input = "q" ]
    then
        echo "Good Bye!";
        exit;
    fi

    # Process request
    if [ $input -eq $input 2>/dev/null ]
    then
        # Get the correct array key
        input=$(($input-1));

        if [ ${options[$input]+isset} ]
        then
            run_menu_command ${options[$input]}
        else
            echo "Option entered is invalid";
        fi
    else
        echo "Option entered is invalid";
    fi
}
