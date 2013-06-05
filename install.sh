#!/bin/bash
# ln -s $PWD/emacs.el $HOME/.emacs
ln -s $PWD/ $HOME/.emacs.d
git submodule update --init --recursive
(cd vendor/jabber && autoreconf --install && ./configure && make)
mkdir cache
# cd .emacs.d/cedet
# make
# cd ..
# cd .emacs.d/jde
# CLASSPATH=/usr/share/java/ant-contrib.jar ant
