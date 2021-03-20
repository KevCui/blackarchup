#!/usr/bin/env bash
#
# Setup BlackArch Linux
#
#/ Usage:
#/   ./blackarch.sh [<script_name> <script_name2>...] [--help]

set -e
set -u

usage() {
    # Dislpay usage message
    #   $SCRIPT_DIR: global var, custom script directory
    printf "%b\n" "$(grep '^#/' "$0" | cut -c4-)"
    if [[ "$(find "$SCRIPT_DIR" -maxdepth 1 -name '*.sh' 2>/dev/null | wc -l)" -gt "0" ]]; then
        local s f
        printf "\n%s\n" 'Custom scripts:'
        for s in "$SCRIPT_DIR"/*.sh; do
            f=$(basename -- "$s")
            f=${f%.*}
            printf "%-20s" "  $f"
            printf "%-50s\n" "run $s"
        done
            printf "%-20s" "  <script_name>"
            printf "%-50s\n" "run $SCRIPT_DIR/<script_name>.sh"
    fi
    exit 0
}

set_var() {
    # Declare global variables
    CURRENT_DIR=$(dirname "$0")
    convert_yaml_to_var "$CURRENT_DIR/globalvar.yaml"
}

print_info() {
    # Display information
    #   $1: info message
    printf "%b\n" "\033[32m[INFO]\033[0m $1" >&2
}

print_error() {
    # Display error message
    #   $1: error message
    printf "%b\n" "\033[31m[ERROR]\033[0m $1" >&2
}

run_sudo() {
    # Run as root using sudo
    echo "$SUDO_PASSWORD" | sudo -S echo
}

convert_yaml_to_var() {
    # Declare global variable from yaml file
    #   $1: input yaml file
    while IFS= read -r line; do
        eval "$line"
    done < <(sed \
    -e '/^\s*$/d' \
    -e '/^#/d' \
    -e 's/[[:space:]]*$//' \
    -e '/:$/d' \
    -e "s/:[^:\/\/]/='/g" \
    -e "s/$/'/g" \
    -e 's/ *=/=/g' "$1")
}

get_app_list() {
    # Return an array from app list file
    #   $1: app list file
    if [[ -f "$1" ]]; then
        sed -E '/^#/d' "$1"
    else
        echo ""
    fi
}

main() {
    # main function
    #   $@: all arguments
    #   $SCRIPT_DIR: custom script directory
    local opts

    set_var
    expr "$*" : ".*--help" > /dev/null && usage
    [[ -z "${1:-}" ]] && usage

    opts=("$@")
    for i in "${opts[@]}"; do
        if [[ -f "$SCRIPT_DIR/${i}.sh" ]]; then
            print_info "Running ${i}.sh..."
            source "$SCRIPT_DIR/${i}.sh"
        else
            print_error "${i}.sh is not found!"
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
