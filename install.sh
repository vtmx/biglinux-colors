#!/usr/bin/env bash

src_dir="$(cd "$(dirname "$0")" && pwd)"

[[ $EUID -eq 0 ]] && dest_dir="/usr/share" || dest_dir="$HOME/.local/share"

main() {
  copy_files "KDE" "$src_dir/color-schemes/*.colors" "$dest_dir/color-schemes"
  copy_files "Konsole" "$src_dir/konsole/*.colorscheme" "$dest_dir/konsole"
  exit_success "BigLinux Colors successfully installed"
}

copy_files() {
  [[ ! -d $3 ]] && mkdir -p $3
  
  echo "Copying $1 colors..."
  if ! cp -f $2 $3; then
    exit_error "Fail in copy"
  fi
}

exit_success() {
  local message="$1"
  local green="\033[0;32m"
  local color_off="\033[0m"
  echo -e "${green}${message}${color_off}"
  exit 0
}

exit_error() {
  local message="$1"
  local red="\033[0;31m"
  local color_off="\033[0m"
  echo -e "${red}${message}${color_off}"
  exit 1
}

main
