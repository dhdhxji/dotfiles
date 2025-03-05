#!/bin/bash

set -eu

test_in_docker () {
    image=$1
    shift
    options=$@

    commands="cp -r /workspace ~/dotfiles && cd ~ && ~/dotfiles/bootstrap.sh ; bash"
    docker run --rm -it -v $(pwd):/workspace:ro ${options} ${image} bash -c "${commands}"
}

docker build -t dotfiles-test:ubuntu-latest - << 'EOF'
FROM ubuntu

RUN DEBIAN_FRONTEND=noninteractive apt update && apt install --yes xz-utils curl sudo 

RUN useradd -m dhdhxji
RUN usermod -aG sudo dhdhxji
RUN echo "dhdhxji ALL=(ALL:ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/dhdhxji

USER dhdhxji
EOF

test_in_docker dotfiles-test:ubuntu-latest "-e USER=dhdhxji -e XDG_CONFIG_HOME=/home/dhdhxji/.config"
