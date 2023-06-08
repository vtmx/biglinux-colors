#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main() {
  copy_files "kde/*.colors" "${HOME}/.local/share/color-schemes"
  copy_files "konsole/*.colorscheme" "${HOME}/.local/share/konsole"
  copy_files "kate/*.theme" "${HOME}/.local/share/org.kde.syntax-highlighting/themes"
}

copy_files() {
  if ! cp -f "${1}" "${2}" 2>/dev/null; then
    exit_error "No such directory: '${2}'"
  fi
}

exit_success() {
  local message="$1"
  local green="\033[0;32m"
  local color_off="\033[0m"
  echo -e "${green}${message}${color_off}\n"
  exit 0
}

exit_error() {
  local message="$1"
  local red="\033[0;31m"
  local color_off="\033[0m"
  echo -e "${red}${message}${color_off}\n"
  exit 1
}

main
exit_success "BigLinux Colors successfully installed"
