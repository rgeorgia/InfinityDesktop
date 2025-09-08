#!/bin/sh

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/github/copilot.vim.git ~/.vim/pack/github/start/copilot.vim
