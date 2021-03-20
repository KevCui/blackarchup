#!/usr/bin/env bash
mapfile -t l < <(get_app_list "$LIST_DIR/go.list")
if [[ ${l[*]} ]]; then
    run_sudo
    for m in "${l[@]}"; do
        go get -u "$m"
    done
else
    print_error "Cannot find go.list or it's empty!"
fi
