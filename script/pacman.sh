#!/usr/bin/env bash
mapfile -t l < <(get_app_list "$LIST_DIR/pacman.list")
if [[ ${l[*]} ]]; then
    run_sudo
    for m in "${l[@]}"; do
        sudo pacman -S "$m"
    done
else
    print_error "Cannot find pacman.list or it's empty!"
fi
