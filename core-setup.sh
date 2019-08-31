#!/bin/sh

# Installs my configs (should work for any *nix)

cd ~
echo "Configure git"
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global

echo "Configure shell"
ln -s ~/dotfiles/.sh_aliases ~/.sh_aliases
ln -s ~/dotfiles/.sh_path ~/.sh_path
echo "source ~/.sh_aliases" >> ~/.bashrc
echo "source ~/.sh_path" >> ~/.bashrc

echo "Configure vim"
ln -s ~/dotfiles/.vimrc ~/.vimrc

echo "Install Vundle (vim plugin manager)"
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing vim plugins"
vim +PluginInstall +qall

echo "Install spacemacs (assumes emacs is installed)"
cd ~
mv .emacs.d .emacs.d.bak
mv .emacs .emacs.bak
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

echo "Config spacemacs"
ln -s ~/dotfiles/.spacemacs ~/.spacemacs

echo "Download, build, & install mosh (assumes build tools installed)"
curl https://mosh.org/mosh-1.3.2.tar.gz -o ~/mosh.tar.gz
tar -xzf ~/mosh.tar.gz
cd ~/mosh-1.3.2/
./configure
make
sudo make install

echo "Install nvm, node, & npm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
nvm install node

echo "Install tldr"
npm install tldr

echo "DONE"
