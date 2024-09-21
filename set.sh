#!/bin/bash

REPO_URL="https://github.com/hirotomoki12345/translate.git"
APP_DIR="translate"

show_help() {
    echo "Usage: $0 {start|stop|quit|help}"
    echo ""
    echo "Commands:"
    echo "  start   Clone the repository, install dependencies, and start the application."
    echo "  stop    Stop the application."
    echo "  quit    Remove the application from PM2."
    echo "  help    Show this help message."
}

read_command() {
    echo "Please enter a command (start, stop, quit, help):"
    read -r command
    echo "$command"
}

command="${1:-$(read_command)}"

case "$command" in
    start)
        if [ ! -d "$APP_DIR" ]; then
            git clone "$REPO_URL"
        fi
        cd "$APP_DIR" || exit
        npm install
        pm2 start server.js --name translate-app
        pm2 save
        ;;
    stop)
        pm2 stop translate-app
        pm2 save
        ;;
    quit)
        pm2 delete translate-app
        pm2 save
        ;;
    help)
        show_help
        ;;
    *)
        echo "Invalid command."
        show_help
        exit 1
        ;;
esac
