#!/usr/bin/env bash
mapfile -t l < <(get_app_list "$LIST_DIR/npm.list")
if [[ ${l[*]} ]]; then
    run_sudo
    sudo npm install -g "${l[@]}"
else
    print_error "Cannot find npm.list or it's empty!"
fi
