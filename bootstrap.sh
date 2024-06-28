#!/bin/sh

STOW_MODULES="git nvim tmux bash"

stow ${STOW_MODULES} --target=$HOME

# And run additional setups here 
! grep -q "source ~/.bashrc.custom" ~/.bashrc && echo "source ~/.bashrc.custom" >> ~/.bashrc
