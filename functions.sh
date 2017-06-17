run_menu_command()
{
    # Get command name from first input
    command_name=$1;
    command_path="$PWD/commands/";

    source "$command_path$command_name.sh";
}
