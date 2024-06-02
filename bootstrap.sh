#!/bin/sh

YADM_LOCATION="$HOME/.local/bin/yadm"
mkdir -p $(dirname $YADM_LOCATION)
curl -fLo $YADM_LOCATION https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x $YADM_LOCATION

$YADM_LOCATION clone https://github.com/dhdhxji/dotfiles --bootstrap