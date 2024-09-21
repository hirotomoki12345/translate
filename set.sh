#!/bin/bash

REPO_URL="https://github.com/hirotomoki12345/translate.git"
APP_DIR="translate"

case "$1" in
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
    *)
        echo "Usage: $0 {start|stop|quit}"
        exit 1
        ;;
esac
