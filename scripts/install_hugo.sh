#!/bin/bash

HUGO_VERSION=0.55.6

wget https://github.com/gohugoio/hugo/releases/download/v"$HUGO_VERSION"/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz -O /tmp/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz

tar -xzvf /tmp/hugo_extended_"$HUGO_VERSION"_Linux-64bit.tar.gz

suod mkdir -p /usr/local/bin
sudo mv hugo /usr/local/bin
