#!/bin/sh

STOW_MODULES="git nvim tmux bash"

stow ${STOW_MODULES} --target=$HOME

# And run additional setups here 
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm || true
fi

! grep -q "source ~/.bashrc.custom" ~/.bashrc && echo "source ~/.bashrc.custom" >> ~/.bashrc
