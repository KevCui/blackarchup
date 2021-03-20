#!/usr/bin/env bash
mapfile -t l < <(get_app_list "$LIST_DIR/git.list")
if [[ ${l[*]} ]]; then
    mkdir -p "$GIT_DIR"
    dir=$(pwd)
    cd "$GIT_DIR" || exit
    for u in "${l[@]}"; do
        git clone --depth 1 "$u" || true
    done
    cd "$dir" || exit
else
    print_error "Cannot find git.list or it's empty!"
fi
