# shell-menu

Easy to use menu system to run complex scripts as options.

Created for Terminal (BASH)

### Installing

Step 1.

Download the project to your desired directory location

Step 2.

Add the following command to the bottom of .bashrc (Change the command to use your setup)

```
echo "alias menu='bash ~/shell-menu/menu.sh'" >> ~/.bashrc
```

Step 3.

exit and restart terminal

Step 4.

Type your alias name to run the menu

```
menu
```

### Loading options using the commands directory

Menu options are created by scanning the commands directory and building the menu based on the names of the directories and shell scripts.

Directory Structure:

```
shell-menu (parent dir)
--- commands (dir)
------ memory (dir)
--------- clear_ram_memory.sh
--------- show_current_memory.sh
```

Guide:

* Directories in the commands folder will get processed as sub menus which will be displayed with "..." after the option.

* Underscores will get converted to spaces.

* Words will get converted to upper case first.

**Example:** memory (dir) converts to  Option (1): Memory...

**Example:** clear_ram_memory.sh converts to Option (1): Clear Ram Memory
