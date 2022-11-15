#!/usr/bin/env bash
install_app_from_github() {
    # Install app from GitHub repo, supports binary, .zip and .tar
    #   $1: app name
    #   $2: release url or raw url
    #   $3: arch
    #   $4: extension: .zip or "" (binary)
    #   $DOWNLOAD_DIR: global var, download directory
    if [[ ! $(command -v "$1") ]]; then
        local latest link app
        if [[ "$2" == *"raw.githubusercontent.com"* ]]; then
            link="$2"
        else
            latest=$(curl -sS -I "${2}/latest" | grep 'locations:' | awk '{print $2}' | sed -E 's/\/tag\//\/expanded_assets\//')
            link="https://github.com$(curl -sS "$latest" | grep href | grep "$3" | head -1 | sed -E 's/.*href=\"//;s/\" rel=.*//')"
        fi
        app="${DOWNLOAD_DIR}/${1}${4}"
        wget "$link" -O "$app"

        run_sudo
        [[ "$4" == ".zip" ]] && unzip "$app" -d "${DOWNLOAD_DIR}"

        if [[ "$4" == ".tar" ]]; then
            local fname
            fname=$(tar -xvf "$app" --directory "${DOWNLOAD_DIR}")
            mv "${DOWNLOAD_DIR}/${fname}" "${DOWNLOAD_DIR}/${1}"
        fi

        chmod +x "${DOWNLOAD_DIR}/${1}"
        sudo ln -s -f "${DOWNLOAD_DIR}/${1}" "/usr/bin/${1}"
    else
        print_info "$1 exists, skip installation"
    fi
}

print_info "Installing app from git repo..."
mkdir -p "$DOWNLOAD_DIR"
while read -r l; do
    if [[ "$l" != "#"* ]]; then
        a1=$(awk '{print $1}' <<< "$l")
        a2=$(awk '{print $2}' <<< "$l")
        a3=$(awk '{print $3}' <<< "$l")
        a4=$(awk '{print $4}' <<< "$l")
        install_app_from_github "$a1" "$a2" "$a3" "$a4"
    fi
done < "$LIST_DIR/githubapp.list"
