#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

src_dir="$(cd "$(dirname "$0")" && pwd)"

if [[ $EUID -eq 0 ]]; then
  dest_dir="/usr/share/"
else
  dest_dir="${HOME}/.local/share/"
fi

main() {
  copy_files "KDE" "${src_dir}/color-schemes/*.colors" "${dest_dir}/color-schemes/"
  copy_files "Konsole" "${src_dir}/konsole/*.colorscheme" "${dest_dir}/konsole/"
  exit_success "BigLinux Colors successfully installed"
}

copy_files() {
  if [[ ! -d ${3} ]]; then
    mkdir -p "${3}"
  fi
  
  echo "Copying ${1} colors..."
  if ! cp -f ${2} ${3}; then
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
