#!/bin/bash

set -exu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ensure_command_exists () {
    command=$1
    error_message=${2:-"Err: The command '${command}' is not available!"}

    if ! command -v ${command} > /dev/null
    then
        echo ${error_message}
        return 1
    fi

    return 0
}


ensure_variable_set () {
    variable=$1
    error_message=${2:-"Err: The variable '${variable}' is not set!"}

    if [ ! -n ${!variable:-""} ] > /dev/null
    then
        echo ${error_message}
        return 1
    fi

    return 0
}

ask_yes_or_no() {
    message=${1}
    read -r -p "${message} [y/N]: " response
    case "${response}" in 
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

install_nix_singleuser () {
    ensure_command_exists bash || return 1
    ensure_command_exists curl || return 1

    bash -c "sh <(curl -L https://nixos.org/nix/install) --no-daemon"
}

stow_dotfiles() {
    STOW_DIR=${SCRIPT_DIR}/stow-modules nix run nixpkgs\#stow -- $(ls ${SCRIPT_DIR}/stow-modules) --target=$HOME
}

bootstrap_home_manager () {
    ensure_command_exists nix || return 1
    
    nix run home-manager/master -- build
    nix run home-manager/master -- switch
}





ensure_variable_set "USER" "Err: USER variable is required for nix to be set"
ensure_variable_set "XDG_CONFIG_HOME"

[ -e ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh
ensure_command_exists nix "Err: Nix pakcage manager is required for this to work. https://nixos.org/download/" \
    || (ask_yes_or_no "Install nix for single user?" && install_nix_singleuser)
. ~/.nix-profile/etc/profile.d/nix.sh


# This will work only for bootstrapping, the rest of config relies on dotfdiles
export NIX_CONF_DIR="${SCRIPT_DIR}/stow-modules/nix/"
stow_dotfiles || ask_yes_or_no "Stow has exited with error >_<. Continue?"
bootstrap_home_manager 



exit 0

STOW_MODULES="git nvim tmux bash"

for module in ${STOW_MODULES}
do
    stow ${module} --target=$HOME
done

# And run additional setups here 
! grep -q "source ~/.bashrc.custom" ~/.bashrc && echo "source ~/.bashrc.custom" >> ~/.bashrc
