#!/usr/bin/env bash

packages=(
    curl
    g++
    git
    unzip
    stow
)

for package in ${packages[@]}; do
    apt-get install ${package}
done
