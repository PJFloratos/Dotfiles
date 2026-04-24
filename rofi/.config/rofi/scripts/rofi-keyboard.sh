#!/bin/bash

THEME="$HOME/.config/rofi/launchers/type-1/style-11.rasi"
LIST_FILE="$HOME/.config/rofi/scripts/my_languages.txt"

# 1. If the list file doesn't exist yet, create it with English and Greek
if [ ! -f "$LIST_FILE" ]; then
    echo -e "us\ngr" > "$LIST_FILE"
fi

# 2. Read the saved languages from the file
SAVED_LANGS=$(cat "$LIST_FILE")

# 3. Build the Rofi menu with Add/Remove options
OPTIONS="${SAVED_LANGS}\n──────────────────────\n[+] Add Language\n[-] Remove Language"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -i -theme "$THEME" -p "Keyboard")

# 4. Handle the user's choice
case "$CHOSEN" in
    "──────────────────────"|"")
        # If they click the separator or press Escape, do nothing safely
        exit 0 
        ;;
        
    "[+] Add Language")
        # Prompt the user to type a new 2-letter X11 code
        NEW_LANG=$(rofi -dmenu -theme "$THEME" -p "Type 2-letter code (e.g. fr, de, es):")
        if [ -n "$NEW_LANG" ]; then
            # Save it to the file and apply it immediately!
            echo "$NEW_LANG" >> "$LIST_FILE"
            setxkbmap "$NEW_LANG"
        fi
        ;;
        
    "[-] Remove Language")
        # Show the list again so they can pick which one to delete
        DEL_LANG=$(cat "$LIST_FILE" | rofi -dmenu -i -theme "$THEME" -p "Remove:")
        if [ -n "$DEL_LANG" ]; then
            # Delete that specific line from the text file
            sed -i "/^${DEL_LANG}$/d" "$LIST_FILE"
        fi
        ;;
        
    *)
        # If it's not Add or Remove, they clicked a language code! Apply it.
        setxkbmap "$CHOSEN"
        ;;
esac
