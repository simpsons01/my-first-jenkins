#!/bin/bash

cd $HOME

curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash

mkdir .nvm/versions

nvm install v14.15.1

source .bashrc