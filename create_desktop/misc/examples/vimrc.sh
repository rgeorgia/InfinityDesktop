pkgin in gh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Copy dot-vimrc to $HOME/.vimrc"
cp $HOME/.vimrc $HOME/.vimrc.bak
cp dot-vimrc $HOME/.vimrc
echo "Launch vim and run :PluginInstall"
