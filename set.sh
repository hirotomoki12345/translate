#!/bin/bash

REPO_URL="https://github.com/hirotomoki12345/translate.git"
APP_DIR="translate"

show_help() {
    clear
    echo "Usage: $0"
    echo ""
    echo "Commands:"
    echo "  1 - Start the application."
    echo "  2 - Stop the application."
    echo "  3 - Quit the application."
    echo "  4 - Show this help message."
}

while true; do
    show_help

    echo "Please enter a command (1, 2, 3, 4):"
    read -r command

    case "$command" in
        1)
            if [ ! -d "$APP_DIR" ]; then
                git clone "$REPO_URL"
            fi
            cd "$APP_DIR" || exit
            npm install
            pm2 start server.js --name translate-app
            pm2 save
            echo "Application started."
            ;;
        2)
            pm2 stop translate-app
            pm2 save
            echo "Application stopped."
            ;;
        3)
            pm2 delete translate-app
            pm2 save
            echo "Application quit."
            break  # Exit the loop
            ;;
        4)
            show_help
            ;;
        *)
            echo "Invalid command."
            ;;
    esac

    echo ""  # Blank line for better readability
done
