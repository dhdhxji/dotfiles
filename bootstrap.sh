#!/bin/sh

STOW_MODULES="git nvim tmux bash vim"

for module in ${STOW_MODULES}
do
    stow ${module} --target=$HOME
done

# And run additional setups here 
! grep -q "source ~/.bashrc.custom" ~/.bashrc && echo "source ~/.bashrc.custom" >> ~/.bashrc
