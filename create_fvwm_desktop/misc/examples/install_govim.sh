sudo pkgin in gh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim
echo "Copy dot-vimrc to $HOME/.vimrc"
cp $HOME/.vimrc $HOME/.vimrc.bak
cp dot-vimrc $HOME/.vimrc
echo "Launch vim and run :PluginInstall"
