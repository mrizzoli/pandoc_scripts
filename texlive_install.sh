#!/bin/bash

tar xvf install-tl-unx.tar.gz 
cd install-tl-2*
mkdir ~/bin

TEXLIVE_INSTALL_PREFIX=~/bin/texlive
export TEXLIVE_INSTALL_PREFIX
./install-tl --profile=~/texlive.profile
