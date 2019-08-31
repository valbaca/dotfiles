#!/bin/sh
# Runs commands specific to ec2 (needs `yum`)
echo "Install updates"
sudo yum update

echo "Install tmux"
sudo yum install tmux

echo "Install build tools (mostly for mosh)"
sudo yum -y install autoconf automake gcc gcc-c++ make boost-devel zlib-devel ncurses-devel protobuf-devel openssl-devel

echo "Install emacs"
sudo yum install emacs

echo "Install misc programs"
sudo yum install tree

echo "Install dotfiles"
~/dotfiles/install.sh

