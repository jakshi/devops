#!/bin/bash

HUGO_VERSION=0.55.6

# Dependency needed for hugo extended on travis
wget -q -O libstdc++6 http://security.ubuntu.com/ubuntu/pool/main/g/gcc-5/libstdc++6_5.4.0-6ubuntu1~16.04.10_amd64.deb
sudo dpkg --force-all -i libstdc++6

# And installing hugo itself

wget -q -O hugo.deb https://github.com/gohugoio/hugo/releases/download/v"$HUGO_VERSION"/hugo_extended_"$HUGO_VERSION"_Linux_64bit.deb
sudo dpkg -i hugo.deb
