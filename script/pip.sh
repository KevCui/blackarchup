#!/usr/bin/env bash
mapfile -t l < <(get_app_list "$LIST_DIR/pip.list")
if [[ ${l[*]} ]]; then
    run_sudo
    sudo pip3 install "${l[@]}"
else
    print_error "Cannot find pip.list or it's empty!"
fi
