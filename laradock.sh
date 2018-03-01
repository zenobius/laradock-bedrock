#!/bin/bash

# This shell script is an optional tool to simplify
# the installation and usage of laradock in general.

# To run, make sure to add permissions to this file:
# chmod +x laradock.sh

# USAGE EXAMPLE:
# SSH into workspace: ./laradock.sh ssh
# SSH into workspace as root: ./laradock.sh ssh --root
# Composer install: ./laradock.sh -- composer install
# Composer update: ./laradock.sh -- composer update

# prints colored text
print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    print_style "Available options:\n" "info";
    print_style "   up" "success"; printf "\t\t\t Runs docker compose.\n"
    print_style "   down" "success"; printf "\t\t\t Stops containers.\n"
    print_style "   ssh [--root]" "success"; printf "\t\t Opens bash on the workspace, optionally as root user.\n"
    print_style "   -- [command]" "success"; printf "\t\t Executes any command in workspace.\n"
    print_style "\nExample:" "info"; printf "\t\t ./laradock.sh -- composer install --no-dev --optimize-autoloader\n"
}

up () {
    source .env
    docker-compose up -d $DEFAULT_WEBSERVER $DEFAULT_DB_SYSTEM;
}

if [[ $# -eq 0 ]] ; then
    print_style "Missing arguments.\n" "danger"
    display_options
    exit 1
fi


if [ "$1" == "up" ] ; then
    print_style "Initializing Docker Compose\n" "info"
    if [ ! -f .env ]; then
        print_style "No .env file found!\n" "danger"
        while true; do
            printf "Use the default .env file?\n"
            read -p "" yn
            case $yn in
                [Yy]* ) cp env-example .env && up; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    else
        up
    fi

elif [ "$1" == "down" ]; then
    print_style "Stopping Docker Compose\n" "info"
    docker-compose stop

elif [ "$1" == "ssh" ] ; then
    SSHUSER=laradock
    if [ "$2" == "--root" ] ; then
        SSHUSER=root
    fi
    print_style "SSH into workspace as user $SSHUSER\n" "info"
    docker-composer exec --user=$SSHUSER workspace bash;

elif [ "$1" == "--" ] ; then
    shift # removing first argument
    docker-compose exec --user=laradock workspace bash -c "$*"

else
    print_style "Invalid arguments.\n" "danger"
    display_options
    exit 1
fi
