#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"

# resolve $SOURCE until the file is no longer a symlink
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"

  # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Get the project functions
source "$DIR/functions.sh";

# Get main header - change menu header in config
get_menu_header;
# Get menu options
get_menu_options;
# Request input from user
take_in_input;

# Deal with sub menus
while true
do
	get_menu_header;
	get_menu_options;
	take_in_input;
done

exit;
