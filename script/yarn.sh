#!/usr/bin/env bash
mapfile -t l < <(get_app_list "$LIST_DIR/yarn.list")
if [[ ${l[*]} ]]; then
    run_sudo
    sudo yarn global add "${l[@]}"
else
    print_error "Cannot find yarn.list or it's empty!"
fi
